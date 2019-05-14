#ifndef NET_H
#define NET_H

#include "i8254x.h"
#include "ethernet.h"
#include "arp.h"
#include "ip4.h"
#include "udp.h"

namespace net
{
	inline int init() {
		// maybe some day we will chose between diferent drivers
		/* mandatory network stack: */
		if (net::i8254x::init())
			return -1;
		if (net::eth::init())
			return -1;
		if (net::arp::init())
			return -1;
		if (net::ip4::init())
			return -1;
		if (net::udp::init())
			return -1;
		return 0;
	}

	inline void uninit() {
		net::i8254x::uninit();
		net::eth::uninit();
		net::arp::uninit();
		net::ip4::uninit();
		net::udp::uninit();
	}

	inline bool is_valid() {
		return net::i8254x::is_valid();
	}

	inline auto &driver() {
		return net::i8254x::driver();
	}

	inline uint32 max_driver_tx_len() {
		return net::i8254x::TX_BUFF_SIZE;
	}
}

#endif