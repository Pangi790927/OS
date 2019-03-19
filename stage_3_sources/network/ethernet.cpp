#include "ethernet.h"

namespace net
{
	namespace eth
	{
		enum ERROR {
			NO_ERROR = 1,
			DRIVER_NOT_LOADED = 2
		};

		int send(void *packet, uint32 len, void (*)(void *ctx), void *) {
			(void)packet;
			(void)len;
			if (net::is_valid()) {
				return DRIVER_NOT_LOADED;
			}
			return NO_ERROR;
		}

		int recv(void *&packet, uint32 &len) {
			(void)packet;
			(void)len;
			if (net::is_valid()) {
				return DRIVER_NOT_LOADED;
			}

			return NO_ERROR;
		}

		int register_recv_cbk(void (*)(void *ctx), void *) {
			if (net::is_valid()) {
				return DRIVER_NOT_LOADED;
			}
			return NO_ERROR;
		}
	}
}