#include "ethernet.h"

namespace net
{
	namespace eth
	{
		enum ERROR {
			NO_ERROR = 0,
			DRIVER_NOT_LOADED = 1,
			ETH_INIT_FAIL = 2
		};

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
			delete (Ethernet *)&eth_buff;
		}

		Ethernet &ethernet() {
			return *(Ethernet *)&eth_buff;
		}

		int send(void *packet, uint32 len);
	}
}