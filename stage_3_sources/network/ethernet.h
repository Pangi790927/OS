#ifndef ETHERNET_H
#define ETHERNET_H

#include "Types.h"
#include "memory.h"
#include "kthread.h"
#include "atomic32.h"
#include "netutils.h"
#include <initializer_list>

/* This library makes abstractions for driver interaction */
/* Examples are: send, recv, callback recv */

namespace net
{
	struct __attribute__((__packed__)) mac_addr_t {
		uint8 addr[6] = {0};

		mac_addr_t();
		mac_addr_t(std::initializer_list<int> list);
		bool operator == (const mac_addr_t& oth);
		bool cmp_vendor(const mac_addr_t& oth);
		bool cmp_machine(const mac_addr_t& oth);
		mac_addr_t vendor();
		mac_addr_t machine();
	};

	struct __attribute__((__packed__)) eth_hdr_t {
		mac_addr_t dst;
		mac_addr_t src;
		uint16 type;
	};

	const constexpr uint16 proto_ip4_code = 0x0800;
	const constexpr uint16 proto_ip6_code = 0x86DD;
	const constexpr uint16 proto_arp_code = 0x0806;

	namespace eth
	{
		enum ERROR {
			NO_ERROR = 0,
			DRIVER_NOT_LOADED,
			ETH_INIT_FAIL,
			ETH_TOO_BIG
		};

		enum Protocols {
			PROTO_ARP,
			PROTO_IP4,
			PROTO_IP6,
			_end_proto_,
		};

		struct Ethernet {
			std::shared_ptr<kthread::Thread> rx_thread_ptr;
			bool valid = false;
			kthread::Atomic32 alive = false;
			kthread::Atomic32 pending_rx = false;
			cbk_t<> proto_rx_cbk[_end_proto_];

			~Ethernet();
			Ethernet();

			void handle_rx();
			int reg_rx_cbk(uint16 proto, const cbk_t<>& cbk);
			void unreg_rx_cbk(uint16 proto);

			void rx_cbk();
			static void rx_cbk(void *self);
			void rx_thread();
			static void rx_thread(void *self);
		};

		int init();
		void uninit();
		Ethernet &ethernet();

		std::string to_string (const mac_addr_t& maddr);
		std::string to_string (const eth_hdr_t& hdr);
	}
}

#endif
