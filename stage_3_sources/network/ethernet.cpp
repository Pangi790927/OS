#include "ethernet.h"
#include "net.h"
#include "scheduler.h"
#include "vga_stdio.h"

namespace net
{
	mac_addr_t::mac_addr_t() {}
	mac_addr_t::mac_addr_t(std::initializer_list<int> list) {
		int i = 0;
		for (auto&& elem : list) {
			addr[i++] = elem;
		}
	}

	bool mac_addr_t::operator == (const mac_addr_t& oth) {
		return oth.addr[0] == addr[0]
				&& oth.addr[1] == addr[1]
				&& oth.addr[2] == addr[2]
				&& oth.addr[3] == addr[3]
				&& oth.addr[4] == addr[4]
				&& oth.addr[5] == addr[5];
	}

	bool mac_addr_t::cmp_vendor(const mac_addr_t& oth) {
		return oth.addr[0] == addr[0]
				&& oth.addr[1] == addr[1]
				&& oth.addr[2] == addr[2];
	}

	bool mac_addr_t::cmp_machine(const mac_addr_t& oth) {
		return oth.addr[3] == addr[3]
				&& oth.addr[4] == addr[4]
				&& oth.addr[5] == addr[5];
	}

	mac_addr_t mac_addr_t::vendor() {
		return mac_addr_t({addr[0], addr[1], addr[2], 0, 0, 0});
	}

	mac_addr_t mac_addr_t::machine() {
		return mac_addr_t({0, 0, 0, addr[3], addr[4], addr[5]});
	}

	namespace eth
	{
		static uint8 eth_buff[sizeof(Ethernet)];
		static bool valid = false;

		int init() {
			if (!net::is_valid()) {
				return DRIVER_NOT_LOADED;
			}
			new ((Ethernet *)&eth_buff) Ethernet();
			if (!ethernet().valid) {
				return ETH_INIT_FAIL;
			}
			valid = true;
			return NO_ERROR;
		}

		void uninit() {
			((Ethernet *)&eth_buff)->~Ethernet();
		}

		Ethernet &ethernet() {
			return *(Ethernet *)&eth_buff;
		}

		std::string to_string (const mac_addr_t& maddr) {
			std::string maddr_str;

			maddr_str += 
				std::to_string((int)maddr.addr[0] >> 4, 16) +
				std::to_string((int)maddr.addr[0] & 0xf, 16) + ":" + 
				std::to_string((int)maddr.addr[1] >> 4, 16) +
				std::to_string((int)maddr.addr[1] & 0xf, 16) + ":" +  
				std::to_string((int)maddr.addr[2] >> 4, 16) + 
				std::to_string((int)maddr.addr[2] & 0xf, 16) + ":" +
				std::to_string((int)maddr.addr[3] >> 4, 16) +
				std::to_string((int)maddr.addr[3] & 0xf, 16) + ":" +
				std::to_string((int)maddr.addr[4] >> 4, 16) +
				std::to_string((int)maddr.addr[4] & 0xf, 16) + ":" +
				std::to_string((int)maddr.addr[5] >> 4, 16) +
				std::to_string((int)maddr.addr[5] & 0xf, 16);

			return maddr_str;
		}

		std::string to_string (const eth_hdr_t& hdr) {
			std::string hdr_str;

			hdr_str += "[dst: ";
			hdr_str += to_string(hdr.dst);
			hdr_str += ", src: ";
			hdr_str += to_string(hdr.src);
			hdr_str += "] type: ";
			hdr_str += std::to_string(ntoh16(hdr.type), 16);

			return hdr_str;
		}

		/* Thernet class bellow */
		Ethernet::Ethernet() {
			rx_thread_ptr = std::shared_ptr<kthread::Thread>(
					new kthread::Thread(&rx_thread, this));
			if (!rx_thread_ptr)
				return ;
			alive = true;
			driver().add_cbk(cbk_t<void(void *)>(rx_cbk, this));
			valid = true;
		}

		Ethernet::~Ethernet() {
			alive = false;
			if (rx_thread_ptr && rx_thread_ptr->joinable())
				rx_thread_ptr->join();
			valid = false;
		}

		int Ethernet::reg_rx_cbk(uint16 proto, const cbk_t<>& cbk) {
			if (proto_rx_cbk[proto]) {
				kprintf("proto callback already set\n");
				return -1;
			}
			proto_rx_cbk[proto] = cbk;
			return 0;
		}

		void Ethernet::unreg_rx_cbk(uint16 proto) {
			proto_rx_cbk[proto] = cbk_t<>();
		}

		void Ethernet::handle_rx() {
			uint8 buffer[1500];
			while (net::driver().rx_pending()) {
				net::driver().recv(buffer, sizeof(buffer));
				eth_hdr_t &header = *(eth_hdr_t *)buffer;

				if (mac_addr_t({0x33, 0x33, 0x00}).cmp_vendor(header.dst)) {
					/* something with ipv6, not supported right now? */
				}
				else {
					switch (ntoh16(header.type)) {
						case proto_arp_code:
							proto_rx_cbk[PROTO_ARP](buffer);
							break;
						case proto_ip4_code:
							proto_rx_cbk[PROTO_IP4](buffer);
							break;
						case proto_ip6_code:
							/* we will ignore it for now */
							break;
						default:
							kprintf("hdr: %s\n", to_string(header).c_str());	
					}
				}
			}
		}

		void Ethernet::rx_thread() {
			/* not in interrupt context  */
			while (alive) {
				if (pending_rx) {
					handle_rx();
					pending_rx = false;
				}
				else {
					scheduler::yield();
				}
			}
		}

		void Ethernet::rx_thread(void *self) {
			/* not in interrupt context  */
			((Ethernet *)self)->rx_thread();			
		}

		void Ethernet::rx_cbk() {
			/* interrupt context */
			pending_rx = true;
		}

		void Ethernet::rx_cbk(void *self) {
			/* interrupt context */
			((Ethernet *)self)->rx_cbk();
		}
	}
}