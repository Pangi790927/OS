#include "memmanip.h"
#include "arp.h"
#include "netutils.h"
#include "hash.h"
#include "kcond_var.h"
#include "kmutex.h"
#include "time.h"
#include "lock_guard.h"
#include "net.h"

namespace net
{
	namespace arp
	{
		static void arp_rx (void *);
		static void send_arp_req (uint32 ask_of_ip);
		static void send_arp_rsp (uint32 asker, mac_addr_t hasker);

		struct arp_ctx_t {
			bool valid = false;
			util::hash_table_t<uint32, mac_addr_t, 1024> ip_to_mac;
			// util::hash_table_t<mac_addr_t, uint32, 1024> mac_to_ip;
			kthread::CondVar recv_cv;
			kthread::Mutex recv_mu;
			kthread::Mutex table_mu;
			bool sent_arp = false;

			arp_ctx_t() {
				recv_cv.init();
				recv_mu.init();
				table_mu.init();
			}
		};

		static uint8 arp_ctx_buff[sizeof(arp_ctx_t)];
		static arp_ctx_t &arp_ctx = *(arp_ctx_t *)arp_ctx_buff;

		int init() {
			if (eth::ethernet().reg_rx_cbk(eth::PROTO_ARP,
					cbk_t<>(arp_rx, NULL)))
			{
				return -1;
			}
			new ((arp_ctx_t *)&arp_ctx_buff) arp_ctx_t();
			arp_ctx.valid = true;
			return 0;
		}

		void uninit() {
			eth::ethernet().unreg_rx_cbk(eth::PROTO_ARP);
			((arp_ctx_t *)arp_ctx_buff)->~arp_ctx_t();
			arp_ctx.valid = false;
		}

		/* we suppport only mac hdwr addr */
		int reg_addr_v4 (const mac_addr_t& haddr, uint32 addr) {
			std::lock_guard<kthread::Mutex> guard(arp_ctx.table_mu);
			arp_ctx.ip_to_mac.insert(std::make_pair(addr, haddr));
			// arp_ctx.mac_to_ip.insert(std::make_pair(haddr, addr));
			return 0;
		}

		int get_addr_v4 (uint32 addr, mac_addr_t& haddr) {
			std::pair<uint32, mac_addr_t> *addr_pair;
			{
				std::lock_guard<kthread::Mutex> guard(arp_ctx.table_mu);
				addr_pair = arp_ctx.ip_to_mac.find(addr);
				if (addr_pair) {
					haddr = addr_pair->second;
					return 0;
				}
			}
			/* here we sent a request for this ip and wait a time for a response
			to be registered in our arp table */
			send_arp_req(addr);
			uint64 last_time = time_ms();
			while (time_ms() - last_time < RECV_TIMEOUT && !addr_pair) {
				arp_ctx.recv_mu.lock();
				uint64 to_wait = RECV_TIMEOUT - (last_time - time_ms());
				if (to_wait)
					arp_ctx.recv_cv.wait_for(arp_ctx.recv_mu, to_wait);
				
				{
					std::lock_guard<kthread::Mutex> guard(arp_ctx.table_mu);
					addr_pair = arp_ctx.ip_to_mac.find(addr);
				}
				
				arp_ctx.recv_mu.unlock();
			}
			if (addr_pair) {
				haddr = addr_pair->second;
				return 0;
			}
			return -1;
		}

		void arp_rx (void *msg) {
			uint8 *message = (uint8 *)msg;
			auto &arp_hdr = *(arp_hdr_t *)(message + sizeof(eth_hdr_t));
			if (ip4_eth_t::pro == ntoh16(arp_hdr.pro) &&
					ip4_eth_t::hrd == ntoh16(arp_hdr.hrd))
			{
				auto &data_hdr = *(arp::ip4_eth_t *)
						(message + sizeof(eth_hdr_t) + sizeof(arp_hdr));

				{
					std::lock_guard<kthread::Mutex> guard(arp_ctx.table_mu);
					arp_ctx.ip_to_mac.insert(
							std::make_pair((uint32)data_hdr.sip, data_hdr.sha));
				}

				if (ntoh16(arp_hdr.op) == arp::op_req) {
					send_arp_rsp(data_hdr.sip, data_hdr.sha);
				}
			}
		}

		void send_arp_req (uint32 ask_of_ip) {
			uint32 len = sizeof(eth_hdr_t) + sizeof(arp_hdr_t) +
				sizeof(arp::ip4_eth_t);
			uint8 message[len];

			auto &eth_hdr = *(eth_hdr_t *)message;
			auto &arp_hdr = *(arp_hdr_t *)(message + sizeof(eth_hdr_t));
			auto &data_hdr = *(arp::ip4_eth_t *)
					(message + sizeof(eth_hdr_t) + sizeof(arp_hdr));

			eth_hdr.dst = mac_addr_t({0xff, 0xff, 0xff, 0xff, 0xff, 0xff});
			eth_hdr.src = *(mac_addr_t *)driver().mac;
			eth_hdr.type = hton16(proto_arp_code);

			arp_hdr.hrd = hton16(arp::ip4_eth_t::hrd);
			arp_hdr.pro = hton16(arp::ip4_eth_t::pro);
			arp_hdr.hln = arp::ip4_eth_t::hln;
			arp_hdr.pln = arp::ip4_eth_t::pln;
			arp_hdr.op = hton16(arp::op_req);

			data_hdr.sha = *(mac_addr_t *)driver().mac;
			/* we strongly believe we are 10.0.0.3 */
			data_hdr.sip = net::str_to_ip("10.0.0.3");
			data_hdr.tha = mac_addr_t({0xff, 0xff, 0xff, 0xff, 0xff, 0xff});
			data_hdr.tip = ask_of_ip;

			driver().send(message, len);
		}

		void send_arp_rsp (uint32 asker, mac_addr_t hasker) {
			uint32 len = sizeof(eth_hdr_t) + sizeof(arp_hdr_t) +
				sizeof(arp::ip4_eth_t);
			uint8 message[len];

			auto &eth_hdr = *(eth_hdr_t *)message;
			auto &arp_hdr = *(arp_hdr_t *)(message + sizeof(eth_hdr_t));
			auto &data_hdr = *(arp::ip4_eth_t *)
					(message + sizeof(eth_hdr_t) + sizeof(arp_hdr));

			eth_hdr.dst = mac_addr_t({0xff, 0xff, 0xff, 0xff, 0xff, 0xff});
			eth_hdr.src = *(mac_addr_t *)driver().mac;
			eth_hdr.type = hton16(proto_arp_code);

			arp_hdr.hrd = hton16(arp::ip4_eth_t::hrd);
			arp_hdr.pro = hton16(arp::ip4_eth_t::pro);
			arp_hdr.hln = arp::ip4_eth_t::hln;
			arp_hdr.pln = arp::ip4_eth_t::pln;
			arp_hdr.op = hton16(arp::op_rpl);

			data_hdr.sha = *(mac_addr_t *)driver().mac;
			/* we strongly believe we are 10.0.0.3 */
			data_hdr.sip = net::str_to_ip("10.0.0.3");
			data_hdr.tha = hasker;
			data_hdr.tip = asker;

			driver().send(message, len);
		}

		std::string to_string (const ip4_eth_t& hdr_data) {
			std::string ret;

			ret += "data send: [sha: ";
			ret += eth::to_string(hdr_data.sha);
			ret += ", sip: ";
			ret += ip_to_str(hdr_data.sip);
			ret += "]\n";

			ret += "data recv: [tha: ";
			ret += eth::to_string(hdr_data.tha);
			ret += ", tip: ";
			ret += ip_to_str(hdr_data.tip);
			ret += "]\n";

			return ret;
		}

		std::string to_string (const arp_hdr_t& hdr) {
			std::string ret;

			ret += "hdr: [";
			ret += "hrd: ";
			ret += std::to_string(ntoh16(hdr.hrd), 16);
			ret += " pro: ";
			ret += std::to_string(ntoh16(hdr.pro), 16);
			ret += " hln: ";
			ret += std::to_string(hdr.hln, 16);
			ret += " pln: ";
			ret += std::to_string(hdr.pln, 16);
			ret += " op: ";
			ret += std::to_string(ntoh16(hdr.op), 16);
			ret += "]";

			return ret;
		}
	}
}