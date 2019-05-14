#include "i8254x.h"
#include "mmio.h"
#include "kstdio.h"
#include "irq_isr.h"
#include "memmanip.h"
#include "time.h"
#include "callbacks.h"
#include "netutils.h"
#include "lock_guard.h"
#include <utility>

inline static int trailing_zero_count (uint32 number) {
	int i = 0;
	if (!number)
		return 0;
	while (!(number & 1) && i < 32) {
		number = number >> 1;
		i++;
	}
	return i;
}

#define PLACE_BY_MASK(value, mask) \
		((value << trailing_zero_count(mask)) & mask)

namespace net
{
	namespace i8254x
	{
		uint32 vendor_device[] = {
			0x8086, 0x1019,
			0x8086, 0x101A,
			0x8086, 0x1010,
			0x8086, 0x1012,
			0x8086, 0x101D,
			0x8086, 0x1079,
			0x8086, 0x107A,
			0x8086, 0x107B,
			0x8086, 0x100F,
			0x8086, 0x1011,
			0x8086, 0x1026,
			0x8086, 0x1027,
			0x8086, 0x1028,
			0x8086, 0x1107,
			0x8086, 0x1112,
			0x8086, 0x1013,
			0x8086, 0x1018,
			0x8086, 0x1077,
			0x8086, 0x1076,
			0x8086, 0x1017,
			0x8086, 0x1078,
			0x8086, 0x1016,
			0x8086, 0x100E,
			0x8086, 0x1015
		};
		const uint32 device_type_cnt =
				sizeof(vendor_device) / sizeof(uint32) / 2;

		alignas(64 * 1024) uint8 driver_buff[sizeof(NetDriver)];
		bool valid;

		static pci::Device find_net_pci() {
			return pci::Device::getFirst([](const pci::Device& dev){
				for (uint32 i = 0; i < device_type_cnt; i++)
					if (dev.vendorId == vendor_device[i * 2 + 0] && 
							dev.deviceId == vendor_device[i * 2 + 1])
						return true;
				return false;
			});
		}

		int init() {
			new ((NetDriver *)&driver_buff) NetDriver();

			if (!driver().valid) {
				uninit();
				return DRIVE_ERR;
			}
			valid = true;

			/*	the driver will just annoy me with an 'finished all jobs'
				when it will be first enabled resulting in an interrupt
				on a driver that was not fully initialized if I don't
				initialize it here
			*/
			driver().enable();
			return 0;
		}

		void uninit() {
			valid = false;
			((NetDriver *)&driver_buff)->~NetDriver();
		}

		bool is_valid() {
			return valid;
		}

		NetDriver &driver() {
			return *(NetDriver *)&driver_buff; 
		}

		void net_irq_fn (void *) {
			if (!net::i8254x::is_valid()) {
				kprintf("Invalid network driver in interrupt\n");
				return ;
			}
			auto& driver = net::i8254x::driver();
			driver.interrupt_handle();
		}

		NetDriver::NetDriver() {
			this->valid = false;
			for (uint32 i = 0; i < RX_DESC_COUNT; i++)
				rx_desc[i].addr = NULL;
			for (uint32 i = 0; i < TX_DESC_COUNT; i++)
				tx_desc[i].addr = NULL;
			rx_lock.init();
			tx_lock.init();

			/* TO MANNY BUGS FROM PCI, rewrite the pci lib for stage3 and
			cosult pci manual */
			pci_device = find_net_pci();
			if (!pci_device.valid)
				return ;

			/* enable bus mastering*/
			pci_device.writeWord(1, 0, pci_device.readWord(1, 0) | 4);
			
			/* Map locations from bar virtual memory */
			uint32 bar0 = pci_device.bar0;
			uint8 type = (pci_device.bar0 & 0b110) >> 1;

			if (type != 0)
				return ;

			uint32 mmio_phys = (bar0 & ~0x3);
			for (uint32 i = 0; i < REG_SPACE_SIZE / 0x1000; i++)
				paging::registerPageK((uint32 *)(mmio_phys + i * 0x1000),
						(uint32 *)(V_NET_MEM_BASE + i * 0x1000),
						(uint32 *)K_PAGING);
			mmio_base = (uint8 *)V_NET_MEM_BASE;

			/* Get mac address */
			uint16 macWord;
			macWord = read_eeprom(0);
			mac[0] = macWord & 0xff;
			mac[1] = (macWord >> 8) & 0xff;
			macWord = read_eeprom(1);
			mac[2] = macWord & 0xff;
			mac[3] = (macWord >> 8) & 0xff;
			macWord = read_eeprom(2);
			mac[4] = macWord & 0xff;
			mac[5] = (macWord >> 8) & 0xff;

			/* Manual says we should allways add own address to ral/rah */
			insertReadAddress(mac, 0);
			uint8 bmac[] = {255, 255, 255, 255, 255, 255};
			insertReadAddress(bmac, 1);

			/* Link up */
			mmio_write32(mmio_base + REG_CTRL,
					mmio_read32(mmio_base + REG_CTRL)
					| CTRL::SLU | CTRL::ASDE | CTRL::FD);

			/* Enable interrupts for net driver */
			irq_isr::add_interupt_fn(pci_device.intLine, 
					cbk_t<void(void *)>(net_irq_fn, this));
			mmio_write32(mmio_base + REG_IMS, 0);
			mmio_write32(mmio_base + REG_IMC, 0);
			mmio_write32(mmio_base + REG_IMS, interrupt_mask);

			/* Init RxTx */
			if (initRX() != 0)
				return ;
			if (initTX() != 0)
				return ;

			this->valid = true;
		}

		int NetDriver::initRX() {
			for (uint32 i = 0; i < RX_DESC_COUNT; i++) {
				rx_buff[i] = new uint8[RX_BUFF_SIZE];
				rx_desc[i].addr =
						paging::addr2phy((uint32)rx_buff[i], (uint32 *)K_PAGING);
				if (!rx_desc[i].addr) {
					kprintf("failed to init rx buffer %d\n", i);
					return DRIVE_ERR;
				}
				else {
					rx_desc[i].stat = 0;
				}
			}
			for (int i = 0; i < 128; i++)
				mmio_write32(mmio_base + REG_MTA + (i * 4), 0);

			mmio_write32(mmio_base + REG_RDBAH, 0);
			mmio_write32(mmio_base + REG_RDBAL,
					paging::addr2phy((uint32)rx_desc, (uint32 *)K_PAGING));

			mmio_write32(mmio_base + REG_RDLEN, sizeof(rx_desc));
			mmio_write32(mmio_base + REG_RDH, 0);
			mmio_write32(mmio_base + REG_RDT, RX_DESC_COUNT - 1);
			mmio_write32(mmio_base + REG_RCTL, 
				RCTL::UPE		// ?
				| RCTL::MPE		// ?
				| RCTL::LPE
				| RCTL::LBM
				| RCTL::BAM
				| RCTL::SBP
				| RCTL::SECRC
				| PLACE_BY_MASK(bsex_val, RCTL::BSEX)
				| PLACE_BY_MASK(bsize_val, RCTL::BSIZE)
			);
			rx_tail = RX_DESC_COUNT - 1;
			return 0;
		}

		int NetDriver::initTX() {
			for (uint32 i = 0; i < TX_DESC_COUNT; i++) {
				tx_desc[i].addr = NULL;
				tx_desc[i].stat = 0;
			}
			mmio_write32(mmio_base + REG_TDBAH, 0);
			mmio_write32(mmio_base + REG_TDBAL,
					paging::addr2phy((uint32)tx_desc, (uint32 *)K_PAGING));
			mmio_write32(mmio_base + REG_TDH, 0);
			mmio_write32(mmio_base + REG_TDT, 0);
			mmio_write32(mmio_base + REG_TDLEN, sizeof(tx_desc));
			mmio_write32(mmio_base + REG_TCTL, TCTL::PSP);
			tx_tail = 0;
			return 0;
		}

		void NetDriver::enable() {
			mmio_write32(mmio_base + REG_RCTL, 
					mmio_read32(mmio_base + REG_RCTL) | RCTL::EN);
			mmio_write32(mmio_base + REG_TCTL, 
					mmio_read32(mmio_base + REG_TCTL) | TCTL::EN);
		}

		void NetDriver::insertReadAddress (uint8 addr[6], uint8 pos) {
			uint32 lo = addr[0]
					| (addr[1] << 8)
					| (addr[2] << 16)
					| (addr[3] << 24);

			uint32 hi = addr[4] | (addr[5] << 8);

			mmio_write32(mmio_base + REG_RAL + 8 * pos, lo);
			mmio_write32(mmio_base + REG_RAH + 8 * pos, hi
					| PLACE_BY_MASK(0, RAH::AS)
					| RAH::AV);
		}

		uint16 NetDriver::read_eeprom(uint8 addr) {
			mmio_write32(mmio_base + REG_EERD, EERD::START | 
					PLACE_BY_MASK(addr, EERD::ADDR));

			while (!(mmio_read32(mmio_base + REG_EERD) & EERD::DONE))
				sleep(1);

			return (mmio_read32(mmio_base + REG_EERD) & EERD::DATA) >> 16; 
		}

		NetDriver::~NetDriver() {
			this->valid = false;
			irq_isr::remove_interupt_fn(pci_device.intLine, 
					cbk_t<void(void *)>(net_irq_fn, this));
			for (uint32 i = 0; i < RX_DESC_COUNT; i++) {
				if (rx_desc[i].addr) {
					delete [] rx_buff[i];
					rx_desc[i].addr = NULL;
				}
			}
		}

		void NetDriver::test_send (void *packet, uint32 len) {
			send((uint8 *)packet, len);
		}

		void NetDriver::interrupt_handle() {
			uint32 flags = mmio_read32(mmio_base + REG_ICR);
			
			if (flags & INTM::LSC) {
				/* if link status has changed we try to put it back up */
				mmio_write32(mmio_base + REG_CTRL,
						mmio_read32(mmio_base + REG_CTRL) | CTRL::SLU);
			}
			if (flags & (INTM::TXDW | INTM::TXQE)) {
				/* we sent some packets so tx_out_cnt can be updated */
				update_free_tx(true);
			}
			if (flags & (INTM::RXDMT0 | INTM::RXO | INTM::RXT0)) {
				/* Those cases are
					RXDMT0 - minimum threshold reached, we do the same as in
							receiving a packet for now
					RXO - we treat it as above, for those two we should post
							error messages in the futer or discard packets
							by some algorithm
					RXT0 - timer interrupt, we simply have packets on line
				*/
				/* head and tail should allways be 1 apart */
				recv_cbk.call();
				update_pending_rx(true);
			}

			// kprintf("free tx: %d pending rx: %d\n",
			// 		(uint32)tx_free_cnt, (uint32)rx_pending_cnt);
			/* We are not intereseted in the following:
				RXSEQ - should be handled above somehow, it means
						Receive Descriptor Minimum Threshold Reached
				MDAC - MDI/O Access Complete
				RXCFG - something that seems we should do
				PHYINT - don't care
				GPI_SDP6, GPI_SDP7, GPI - no idea
				TXD_LOW - we shouldn't care about this one
				SRPD - small packet recieved, don't care
			 */
		}

		int NetDriver::tx_free() {
			return tx_free_cnt;
		}

		int NetDriver::rx_pending() {
			return rx_pending_cnt;
		}

		int NetDriver::send (uint8 *packet, uint32 len) {
			(void)packet;
			(void)len;

			tx_lock.lock();
			if (!tx_free()) {
				/* No more space in send queue */
				tx_lock.unlock();
				return -DRIVE_ERR;	
			}
			TxDesc &first_free = tx_desc[tx_tail];

			first_free.addr = paging::addr2phy((uint32)packet,
					(uint32 *)K_PAGING);
			first_free.len = len;
			// need to put this commands in an enum:
			first_free.cmd = ((1 << 3) | (3));

			inc_tx_tail(false);
			update_free_tx(false);
			tx_lock.unlock();

			while (!first_free.stat /* IMPLEMENT TIMEOUT*/ ) 
				{}
			if (first_free.stat != TX_STAT::DD)
				return -first_free.stat;
			return 0;
		}

		int NetDriver::recv (uint8 *buff, uint32 len) {
			// !! must be syncronized
			/* here we will: move pending packet buff, update rx_tail */

			std::lock_guard<kthread::Lock> guard(rx_lock);
			if (!rx_pending()) {
				/* Can't recv if nothing is pending */
				return DRIVE_ERR;
			}

			RxDesc &pkt = rx_desc[madd(rx_tail, 1, RX_DESC_COUNT)];
			// kprintf("------------- RECVED: -------------\n");
			// kprintf("recv err: %b\n", pkt.err);
			// kprintf("recv stat: %b\n", pkt.stat);
			// kprintf("recv len: %d\n", pkt.len);

			if (pkt.err) {
				return -pkt.err;
			}

			if (pkt.len <= len) {
				memcpy(buff, rx_buff[madd(rx_tail, 1, RX_DESC_COUNT)], pkt.len);
			}
			else {
				return DRIVE_SPACE_ERR;
			}

			inc_rx_tail(false);
			update_pending_rx(false);

			return pkt.len;
		}

		int NetDriver::add_cbk (const cbk_t<void(void *)>& cbk) {
			asm volatile ("cli");
			int ret = recv_cbk.insert(cbk);
			asm volatile ("sti");
			return ret;
		}

		void NetDriver::update_pending_rx (bool in_int) {
			if (!in_int)
				asm volatile ("cli");

			uint32 rx_head = mmio_read32(mmio_base + REG_RDH);
			if (rx_head == rx_tail)
				rx_pending_cnt = RX_DESC_COUNT;
			else {
				rx_pending_cnt = mdist(rx_tail, rx_head, RX_DESC_COUNT) - 1;
			}

			if (!in_int)
				asm volatile ("sti");
		}

		void NetDriver::update_free_tx (bool in_int) {
			if (!in_int)
				asm volatile ("cli");

			uint32 tx_head = mmio_read32(mmio_base + REG_TDH);
			tx_free_cnt = TX_DESC_COUNT -
					mdist(tx_head, tx_tail, TX_DESC_COUNT);

			if (!in_int)
				asm volatile ("sti");
		}

		void NetDriver::inc_tx_tail (bool in_int) {
			if (!in_int)
				asm volatile ("cli");

			minc(tx_tail, TX_DESC_COUNT);
			mmio_write32(mmio_base + REG_TDT, tx_tail);

			if (!in_int)
				asm volatile ("sti");
		}

		void NetDriver::inc_rx_tail (bool in_int) {
			if (!in_int)
				asm volatile ("cli");

			minc(rx_tail, RX_DESC_COUNT);
			mmio_write32(mmio_base + REG_RDT, rx_tail);

			if (!in_int)
				asm volatile ("sti");
		}
	}
}

// builded qemu for debbuging:

// -> sudo apt-get install git libglib2.0-dev libfdt-dev libpixman-1-dev
//			zlib1g-dev
// recomanded:
// -> sudo apt-get install git-email
// -> sudo apt-get install libaio-dev libbluetooth-dev libbrlapi-dev libbz2-dev
// -> sudo apt-get install libcap-dev libcap-ng-dev libcurl4-gnutls-dev
//			libgtk-3-dev
// -> sudo apt-get install libibverbs-dev libjpeg8-dev libncurses5-dev
//			libnuma-dev
// -> sudo apt-get install librbd-dev librdmacm-dev
// -> sudo apt-get install libsasl2-dev libsdl1.2-dev libseccomp-dev
//			libsnappy-dev libssh2-1-dev
// -> sudo apt-get install libvde-dev libvdeplug-dev libvte-2.90-dev libxen-dev
//			liblzo2-dev
// -> sudo apt-get install valgrind xfslibs-dev 
// -> sudo apt-get install libnfs-dev libiscsi-dev
// install:
// -> follow qemu readme for build
//			(git clone git://git.qemu-project.org/qemu.git)
// -> sudo make install

