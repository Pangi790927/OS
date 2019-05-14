#ifndef ARP_H
#define ARP_H

#include "ethernet.h"

namespace net
{
	struct __attribute__((__packed__)) arp_hdr_t {
		uint16 hrd;
		uint16 pro;
		uint8 hln;	/* n */
		uint8 pln;	/* m */
		uint16 op;
		/* nbytes sender ha */
		/* mbytes sender pa */
		/* nbytes target ha */
		/* mbytes target pa */
	};

	namespace arp
	{
		constexpr const uint16 op_req = 1;
		constexpr const uint16 op_rpl = 2;
		struct __attribute__((__packed__)) ip4_eth_t {
			constexpr const static uint16 hrd = 1;
			constexpr const static uint16 pro = proto_ip4_code;
			constexpr const static uint16 hln = sizeof(mac_addr_t);
			constexpr const static uint16 pln = sizeof(uint32);
			mac_addr_t sha;
			uint32 sip;
			mac_addr_t tha;
			uint32 tip;
		};

		const int RECV_TIMEOUT = 30000;

		int init();
		void uninit();

		/* we suppport only mac hdwr addr */
		int reg_addr_v4 (const mac_addr_t& haddr, uint32 addr);
		int get_addr_v4 (uint32 addr, mac_addr_t& haddr);

		std::string to_string (const ip4_eth_t& hdr_data);
		std::string to_string (const arp_hdr_t& hdr);
	}
}

#endif