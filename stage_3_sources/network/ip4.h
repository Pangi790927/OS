#ifndef IP4_H
#define IP4_H

#include "string.h"
#include "callbacks.h"
#include <Types.h>

namespace net
{
	struct __attribute__((__packed__)) ip4_hdr_t {
		uint32 ihl		: 4,
				ver		: 4; 
		uint32 tos		: 8;
		uint32 len		: 16;
		uint32 id		: 16;
		uint32 frag_off	: 16;
		uint32 ttl		: 8;
		uint32 proto	: 8;
		uint32 chsum	: 16;
		uint32 src;
		uint32 dst;
	};

	namespace ip4
	{
		const uint8 DONT_FRAGMENT = 2;
		const uint8 MORE_FRAGMENTS = 4;

		const constexpr uint16 proto_tcp_code = 6;
		const constexpr uint16 proto_udp_code = 17;

		enum Protocols {
			PROTO_UDP,
			PROTO_TCP,
			_end_proto_,
		};

		int init();
		void uninit();

		int reg_rx_cbk(uint16 proto, const cbk_t<>& cbk);
		void unreg_rx_cbk(uint16 proto);

		ip4_hdr_t create_hdr();
		std::string to_string (const ip4_hdr_t& ip_hdr);
	}
}

#endif