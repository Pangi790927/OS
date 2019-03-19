#ifndef ETHERNET_H
#define ETHERNET_H

#include "net.h"

/* This library makes abstractions for driver interaction */
/* Examples are: send, recv, callback recv */

namespace net
{
	namespace eth
	{
		int send(void *packet, uint32 len);
		int recv(void *packet, uint32 len);
		int register_recv_cbk(void (*)(void));
	}
}

#endif