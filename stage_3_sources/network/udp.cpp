#include "udp.h"
#include "ip4.h"
#include "ethernet.h"
#include "callbacks.h"

namespace net
{
	namespace udp
	{
		static void udp_rx (void *);

		int init() {
			if (ip4::reg_rx_cbk(ip4::PROTO_UDP, cbk_t<>(udp_rx, NULL)))
				return -1;
			return 0;
		}

		void uninit() {
			ip4::unreg_rx_cbk(ip4::PROTO_UDP);
		}

		void udp_rx (void *message) {
			uint8 *msg = (uint8 *)message;
			eth_hdr_t *eth_hdr = (eth_hdr_t *)msg;
			ip4_hdr_t *ip4_hdr = (ip4_hdr_t *)((uint8 *)eth_hdr +
					sizeof(eth_hdr_t));
			udp_hdr_t *udp_hdr = (udp_hdr_t *)((uint8 *)ip4_hdr +
					ip4_hdr->ihl * 4);
			uint8 *data = (uint8 *)udp_hdr + sizeof(udp_hdr_t);

			kprintf("ip_hdr: %s\n", ip4::to_string(*ip4_hdr));
			kprintf("udp message received len %d %s\n",
					ntoh16(udp_hdr->len), data);
		}

		int send_to (uint32 ip, uint16 port, uint8 *buff, uint16 len) {
			(void)ip;
			(void)port;
			(void)buff;
			(void)len;

			/* a lot to be done ...
				allocate eth + ip + udp + data packet
				find out mac of ip or gateaway -> -1 if can't do that
				compose the pseudo header and checksum it
				put eth, ip and udp headers in place
				send the data using the driver */

			return 0;
		}

		int recv_from (uint32 &ip, uint16 port, uint8 *buff, uint16 max_len) {
			(void)ip;
			(void)port;
			(void)buff;
			(void)max_len;

			/* well this function will happen only when we get an interesting
			message from our future callback from the ip level, namely a udp
			message with dst port equal to our port */

			return 0;
		}
	}
}
