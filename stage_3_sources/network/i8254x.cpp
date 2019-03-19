#include "i8254x.h"
#include "mmio.h"
#include "kstdio.h"
#include "irq_isr.h"
#include "memmanip.h"
#include "time.h"
#include "callbacks.h"
#include <utility>

inline static int trailing_zero_count (uint32 number) {
	// float f = (float)(number & -number);
	// return (*(uint32 *)&f >> 23) - 0x7f;
	int i = 0;
	while (!(number & 1)) {
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
		char netDriverBuff[sizeof(NetDriver)];
		bool valid;

		int init() {
			new ((NetDriver *)&netDriverBuff) NetDriver();

			if (!driver().valid) {
				uninit();
				return -1;
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
			delete (NetDriver *)&netDriverBuff;
		}

		bool is_valid() {
			return valid;
		}

		NetDriver &driver() {
			return *(NetDriver *)netDriverBuff; 
		}

		uint32 vendorDevice[] = {
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
		const uint32 deviceTypeCount = sizeof(vendorDevice) / sizeof(uint32) / 2;


		void net_irq_fn (void *) {
			if (!net::i8254x::is_valid()) {
				kprintf("Invalid network driver in interrupt\n");
				return ;
			}
			auto& driver = net::i8254x::driver();
			uint32 flags = mmio_read32(driver.mmio_base + REG_ICR);
			kprintf("interrupt called from net driver ...\n");
			kprintf("value: %b\n", flags);
			mmio_read32(driver.mmio_base + REG_ICR);
		}

		pci::Device getFirstNetworkPciDevice() {
			return pci::Device::getFirst([](const pci::Device& dev){
				for (uint32 i = 0; i < deviceTypeCount; i++)
					if (dev.vendorId == vendorDevice[i * 2 + 0] && 
							dev.deviceId == vendorDevice[i * 2 + 1])
						return true;
				return false;
			});
		}

		NetDriver::NetDriver() {
			this->valid = false;
			for (uint32 i = 0; i < RX_DESC_COUNT; i++)
				rxDesc[i].addr = NULL;
			for (uint32 i = 0; i < TX_DESC_COUNT; i++)
				txDesc[i].addr = NULL;

			pciDevice = getFirstNetworkPciDevice();
			if (!pciDevice.valid)
				return ;

			uint32 bar0 = pciDevice.bar0;
			uint8 type = (pciDevice.bar0 & 0b110) >> 1;

			if (type != 0)
				return ;

			/* Map locations from bar virtual memory */
			uint32 mmio_phys = (bar0 & ~0x3);
			for (uint32 i = 0; i < REG_SPACE_SIZE / 0x1000; i++)
				paging::registerPageK((uint32 *)(mmio_phys + i * 0x1000),
						(uint32 *)(V_NET_MEM_BASE + i * 0x1000),
						(uint32 *)K_PAGING);
			mmio_base = (uint8 *)V_NET_MEM_BASE;

			/* Get the mac address */
			uint16 macWord;
			macWord = readEEPROM(0);
			mac[0] = macWord & 0xff;
			mac[1] = (macWord >> 8) & 0xff;
			macWord = readEEPROM(1);
			mac[2] = macWord & 0xff;
			mac[3] = (macWord >> 8) & 0xff;
			macWord = readEEPROM(2);
			mac[4] = macWord & 0xff;
			mac[5] = (macWord >> 8) & 0xff;

			/* Enable interrupts for net driver */
			irq_isr::add_interupt_fn(pciDevice.intLine, 
					Callback<void(void *)>(net_irq_fn, this));
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

		void NetDriver::enable() {
			mmio_write32(mmio_base + REG_RCTL, 
					mmio_read32(mmio_base + REG_RCTL) | RCTL::EN);
			mmio_write32(mmio_base + REG_TCTL, 
					mmio_read32(mmio_base + REG_TCTL) | TCTL::EN);
			mmio_write32(mmio_base + REG_CTRL, 
					mmio_read32(mmio_base + REG_CTRL) | CTRL::SLU);
		}

		int NetDriver::initRX() {
			for (uint32 i = 0; i < RX_DESC_COUNT; i++) {
				rxDesc[i].addr = (uint64)new uint8[RX_BUFF_SIZE];;
				if (!rxDesc[i].addr) {
					kprintf("failed to init rx buffer %d\n", i);
					return -1;
				}
				else {
					rxDesc[i].stat = 0;
				}
			}
			mmio_write32(mmio_base + REG_RDBAH, ((uint64)&rxDesc) >> 32);
			mmio_write32(mmio_base + REG_RDBAL, ((uint64)&rxDesc) & 0xffff'ffff);
			mmio_write32(mmio_base + REG_RDLEN, sizeof(rxDesc));
			mmio_write32(mmio_base + REG_RDH, 0);
			mmio_write32(mmio_base + REG_RDT, 0);
			mmio_write32(mmio_base + REG_RCTL, 
				RCTL::UPE		// ?
				| RCTL::MPE		// ?
				| RCTL::LPE
				| RCTL::BAM
			 // | RCTL::SBP
				| RCTL::SECRC
				| PLACE_BY_MASK(bsex_val, RCTL::BSEX)
				| PLACE_BY_MASK(bsize_val, RCTL::BSIZE)
			);
			rx_tail = 0;
			return 0;
		}

		int NetDriver::initTX() {
			for (uint32 i = 0; i < TX_DESC_COUNT; i++) {
				txDesc[i].addr = NULL;
				txDesc[i].stat = 0;
			}
			mmio_write32(mmio_base + REG_TDBAH, ((uint64)&txDesc) >> 32);
			mmio_write32(mmio_base + REG_TDBAL, ((uint64)&txDesc) & 0xffff'ffff);
			mmio_write32(mmio_base + REG_TDLEN, sizeof(txDesc));
			mmio_write32(mmio_base + REG_TDH, 0);
			mmio_write32(mmio_base + REG_TDT, 0);
			tx_tail = 0;
			return 0;
		}

		uint16 NetDriver::readEEPROM(uint8 addr) {
			mmio_write32(mmio_base + REG_EERD, EERD::START | 
					PLACE_BY_MASK(addr, EERD::ADDR));

			while (!(mmio_read32(mmio_base + REG_EERD) & EERD::DONE))
				sleep(1);

			return (mmio_read32(mmio_base + REG_EERD) & EERD::DATA) >> 16; 
		}

		NetDriver::~NetDriver() {
			this->valid = false;
			irq_isr::remove_interupt_fn(pciDevice.intLine, 
					Callback<void(void *)>(net_irq_fn, this));
			for (uint32 i = 0; i < RX_DESC_COUNT; i++) {
				if (rxDesc[i].addr) {
					delete [] (uint8 *)rxDesc[i].addr;
					rxDesc[i].addr = NULL;
				}
			}
			for (uint32 i = 0; i < TX_DESC_COUNT; i++) {
				if (txDesc[i].addr) {
					delete [] (uint8 *)rxDesc[i].addr;
					rxDesc[i].addr = NULL;
				}
			}
		}

		static int send_packet (void *packet, int len) {
			(void)packet;
			(void)len;
			(void)send_packet;
			// put buffer in tx que
			// set the callback for when the packet is transmited`
			return 0;
		}

		static int recv_packet_cbk (Callback<void(void *)> cbk) {
			(void)cbk;
			(void)recv_packet_cbk;
			// set a callback to be called when packets are ready to be
			// recieved
			return 0;
		}
	}
}