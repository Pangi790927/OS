#ifndef UDP_H
#define UDP_H

#include "Types.h"

namespace net
{
	struct __attribute__((__packed__)) udp_hdr_t {
		uint16 sport;
		uint16 dport;
		uint16 len;
		uint16 chsum;
	};

	struct __attribute__((__packed__)) pse_udp_hdr_t {
		uint32 src;
		uint32 dst;
		uint8 zero = 0;
		uint8 proto;
		uint16 udp_len;
	};

	namespace udp
	{
		const int proto_nr = 17;
		int init();
		void uninit();

		int send_to (uint32 ip, uint16 port, uint8 *buff, uint16 len);
		int recv_from (uint32 &ip, uint16 port, uint8 *buff, uint16 &max_len);
	}
}

#endif