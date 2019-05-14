#include "ip4.h"
#include "ethernet.h"
#include "netutils.h"

namespace net
{
	namespace ip4
	{
		static int ip_id_count = 0;
		
		static void ip4_rx (void *);
		
		struct ip4_ctx_t {
			cbk_t<> proto_rx_cbk[_end_proto_];
		} ip4_ctx;

		int init() {
			if (eth::ethernet().reg_rx_cbk(eth::PROTO_IP4,
					cbk_t<>(ip4_rx, NULL)))
			{
				return -1;
			}
			new (&ip4_ctx) ip4_ctx_t();
			return 0;
		}

		void uninit() {
			eth::ethernet().unreg_rx_cbk(eth::PROTO_IP4);
			ip4_ctx.~ip4_ctx_t();
		}

		int reg_rx_cbk (uint16 proto, const cbk_t<>& cbk) {
			if (ip4_ctx.proto_rx_cbk[proto]) {
				kprintf("proto callback already set\n");
				return -1;
			}
			ip4_ctx.proto_rx_cbk[proto] = cbk;
			return 0;
		}

		void unreg_rx_cbk (uint16 proto) {
			ip4_ctx.proto_rx_cbk[proto] = cbk_t<>();
		}

		void ip4_rx (void *message) {
			uint8 *msg = (uint8 *)message;
			ip4_hdr_t &hdr = *(ip4_hdr_t *)(msg + sizeof(eth_hdr_t));
			uint32 proto = hdr.proto;

			/* packet rebuilding must be done here and afterwords send it to
			above layers, what they do with it afterwards is their job */

			switch (proto) {
				case proto_udp_code:
					ip4_ctx.proto_rx_cbk[PROTO_UDP](message);
					break;
				case proto_tcp_code:
					ip4_ctx.proto_rx_cbk[PROTO_TCP](message);
					break;
				default: break;
			}
		}

		ip4_hdr_t create_hdr (uint16 pro, uint32 src, uint32 dst, uint16 len) {
			ip4_hdr_t new_hdr;

			new_hdr.ver = 4;
			new_hdr.ihl = 5;
			new_hdr.tos = 0b0011'1111;
			new_hdr.len = hton16(len);
			new_hdr.id = ip_id_count++;
			new_hdr.frag_off = 0;
			new_hdr.ttl = 255;
			new_hdr.proto = pro;
			new_hdr.chsum = 0;
			new_hdr.src = src;
			new_hdr.dst = dst;
			new_hdr.chsum = checksum((uint8 *)&new_hdr, sizeof(new_hdr));

			return new_hdr;
		}

		std::string to_string (const ip4_hdr_t& ip_hdr) {
			std::string ip_hdr_str;

			ip_hdr_str += "ver: ";
			ip_hdr_str += std::to_string(ip_hdr.ver);
			ip_hdr_str += " ihl: ";
			ip_hdr_str += std::to_string(ip_hdr.ihl);
			ip_hdr_str += " src: ";
			ip_hdr_str += ip_to_str(ip_hdr.src);
			ip_hdr_str += " dst: ";
			ip_hdr_str += ip_to_str(ip_hdr.src);
			ip_hdr_str += " proto: ";
			ip_hdr_str += std::to_string(ip_hdr.proto);
			ip_hdr_str += " len: ";
			ip_hdr_str += std::to_string(ntoh16(ip_hdr.len));

			return ip_hdr_str;
		}
	}
}