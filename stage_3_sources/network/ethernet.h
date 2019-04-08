#ifndef ETHERNET_H
#define ETHERNET_H

#include "net.h"

/* This library makes abstractions for driver interaction */
/* Examples are: send, recv, callback recv */

namespace net
{
	namespace eth
	{
		struct Ethernet {
			std::shared_ptr<kthread::Thread> rx_thread;
			
			bool valid = false;
		};

		int init();
		void uninit();
		Ethernet &ethernet();
		int send(void *packet, uint32 len);
	}
}

#endif