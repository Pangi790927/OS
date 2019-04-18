#ifndef NET_H
#define NET_H

#include "i8254x.h"

namespace net
{
	inline int init() {
		// maybe some day we will chose between diferent drivers
		return net::i8254x::init();
	}

	inline void uninit() {
		net::i8254x::uninit();
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