#ifndef I8254X_H
#define I8254X_H

#include "Types.h"
#include "pci.h"
#include "paging.h"
#include "global_defines.h"

namespace net
{
	namespace i8254x
	{
		// RCTL.BSIZE recv data storage (pg. 20)
		// RCTL.BSEX recv data storage (pg. 20)

		extern uint32 vendorDevice[];
		extern const uint32 deviceTypeCount;

		struct __attribute__((__packed__)) RxDesc {
			uint32 lenght		: 16;
			uint32 checksum		: 16;
			uint32 status		: 8;
			uint32 errors		: 8;
			uint32 special		: 16;
		};

		struct __attribute__((__packed__)) TxDesc {
			uint64 bufAddr			: 64;	// addr
			uint64 lenght			: 16;
			uint64 checksumOffset	: 8;	// cso
			uint64 command			: 8;	// cmd
			uint64 status			: 4;	// status
			uint64 reserved			: 4;	
			uint64 checkStatStart	: 8;	// css
			uint64 special			: 16;
		};

		pci::Device getFirstNetworkPciDevice();

		class Driver {
		public:
			static const uint32 RX_DESC_COUNT = 32;
			static const uint32 TX_DESC_COUNT = 8;
			static const uint32 REG_SPACE_SIZE = 0x20000;
			
			static const uint32 REG_CTRL = 0x0000;
			static const uint32 REG_STATUS = 0x0008;
			static const uint32 REG_EEPROM = 0x0014;

			pci::Device pciDevice;
			uint32 mmio;
			uint8 mac[6];

			RxDesc *rxDesc[RX_DESC_COUNT];
			TxDesc *txDesc[TX_DESC_COUNT];
			uint16 currentRx;
			uint16 currentTx;

			Driver() {
				pciDevice = getFirstNetworkPciDevice();
				if (pciDevice.valid) {
					uint32 mmio_phys = pciDevice.bar0 & ~0x3;

					for (uint32 i = 0; i < REG_SPACE_SIZE / 0x1000; i++) {
						paging::registerPageK((uint32 *)(mmio_phys + i * 0x1000),
								(uint32 *)(V_NET_MEM_BASE + i * 0x1000),
								(uint32 *)K_PAGING);
					}
					mmio = V_NET_MEM_BASE;
				}
			}

			void writeCommand (uint16 address, uint32 value) {
				(void)address;
				(void)value;
			}

			void readValue(uint16 address) {
				(void)address;
			}
		};
	}
}

#endif