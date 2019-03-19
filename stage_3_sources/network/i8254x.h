#ifndef I8254X_H
#define I8254X_H

#include "Types.h"
#include "pci.h"
#include "paging.h"
#include "global_defines.h"

namespace net
{
	// Check 
	// PCI/PCI-X Family of Gigabit Ethernet Controllers Software Developer’s Manual
	// for understanding this program
	// you may find a copy here: 
	// https://pdos.csail.mit.edu/6.828/2011/readings/hardware/8254x_GBe_SDM.pdf
	namespace i8254x
	{
		// RCTL.BSIZE recv data storage (pg. 20)
		// RCTL.BSEX recv data storage (pg. 20)

		static const uint32 REG_CTRL = 0x0000;
		namespace CTRL { enum {
			ASDE =	0b00000000'00000000'00000000'00100000,
			SLU =	0b00000000'00000000'00000000'01000000,
		};}
		
		static const uint32 REG_STATUS = 0x0008;
		namespace STATUS { enum {

		};}

		static const uint32 REG_EECD = 0x0010;
		static const uint32 REG_EERD = 0x0014;
		namespace EERD { enum {
			START =	0b00000000'00000000'00000000'00000001,
			DONE =	0b00000000'00000000'00000000'00010000,
			ADDR =	0b00000000'00000000'11111111'00000000,
			DATA =	0b11111111'11111111'00000000'00000000
		};}
		
		static const uint32 REG_ICR = 0x00c0;
		static const uint32 REG_ICS = 0x00c8;
		static const uint32 REG_IMS = 0x00d0;
		static const uint32 REG_IMC = 0x00d8;
		namespace INTM { enum {
			TXDW =	0b00000000'00000000'00000000'00000001,
			TXQE =	0b00000000'00000000'00000000'00000010,
			LSC =	0b00000000'00000000'00000000'00000100,
			RXSEQ = 0b00000000'00000000'00000000'00001000,
			RXDMT0 =0b00000000'00000000'00000000'00010000,
			RXO =	0b00000000'00000000'00000000'01000000,
			RXT0 =	0b00000000'00000000'00000000'10000000,
			MDAC =	0b00000000'00000000'00000010'00000000,
			RXCFG =	0b00000000'00000000'00000100'00000000,
			PHYINT =0b00000000'00000000'00010000'00000000,
			GPIGC = 0b00000000'00000000'01111000'00000000,
			TXD_LO =0b00000000'00000000'10000000'00000000,
			SRPD =	0b00000000'00000001'00000000'00000000
		};}

		static const uint32 REG_RCTL = 0x0100;
		static const uint32 REG_RDBAL = 0x2800;
		static const uint32 REG_RDBAH = 0x2804;
		static const uint32 REG_RDLEN = 0x2808;
		static const uint32 REG_RDH = 0x2810;
		static const uint32 REG_RDT = 0x2818;
		namespace RCTL { enum {
			EN =	0b00000000'00000000'00000000'00000010,
			SBP =	0b00000000'00000000'00000000'00000100,
			UPE =	0b00000000'00000000'00000000'00001000,
			MPE =	0b00000000'00000000'00000000'00010000,
			LPE =	0b00000000'00000000'00000000'00100000,
			LBM =	0b00000000'00000000'00000000'11000000,
			RDMTS =	0b00000000'00000000'00000011'00000000,
			MO =	0b00000000'00000000'00110000'00000000,
			BAM =	0b00000000'00000000'10000000'00000000,
			BSIZE =	0b00000000'00000011'00000000'00000000,
			VFE =	0b00000000'00000100'00000000'00000000,
			CFIEN =	0b00000000'00001000'00000000'00000000,
			CFI =	0b00000000'00010000'00000000'00000000,
			DPF =	0b00000000'01000000'00000000'00000000,
			PMCF =	0b00000000'10000000'00000000'00000000,
			BSEX =	0b00000010'00000000'00000000'00000000,
			SECRC =	0b00000100'00000000'00000000'00000000
		};}
		
		static const uint32 REG_TCTL = 0x0400;
		static const uint32 REG_TDBAL = 0x3800;
		static const uint32 REG_TDBAH = 0x3804;
		static const uint32 REG_TDLEN = 0x3808;
		static const uint32 REG_TDH = 0x3810;
		static const uint32 REG_TDT = 0x3818;
		namespace TCTL { enum {
			EN =	0b00000000'00000000'00000000'00000010,
			PSP =	0b00000000'00000000'00000000'00001000,
			CT =	0b00000000'00000000'00001111'11110000,
			COLD =	0b00000000'00111111'11110000'00000000,
			SWXOFF =0b00000000'01000000'00000000'00000000,
			RTLC =	0b00000001'00000000'00000000'00000000,
			NRTU =	0b00000010'00000000'00000000'00000000
		};}

		static const uint32 interrupt_mask
				= 	0b00000000'00000001'11110110'11011111;
		static const uint32 bsex_val = 0b1;
		static const uint32 bsize_val = 0b01;

		static const uint32 RX_DESC_SIZE = 16;
		static const uint32 TX_DESC_SIZE = 16;

		static const uint32 RX_BUFF_SIZE = 16384;
		static const uint32 TX_BUFF_SIZE = 16384;

		extern uint32 vendorDevice[];
		extern const uint32 deviceTypeCount;

		struct __attribute__((__packed__)) RxDesc {
			uint64 addr			: 64;
			uint32 len			: 16;
			uint32 crc			: 16;
			uint32 stat			: 8;
			uint32 err			: 8;
			uint32 special		: 16;
		};
		static_assert(sizeof(RxDesc) == RX_DESC_SIZE, "Wrong rx desc size");

		struct __attribute__((__packed__)) TxDesc {
			uint64 addr				: 64;	// addr
			uint64 len				: 16;
			uint64 crc_off			: 8;	// cso
			uint64 comm				: 8;	// cmd
			uint64 stat				: 4;	// status
			uint64 reserved			: 4;	
			uint64 css				: 8;	// css
			uint64 special			: 16;

			TxDesc() {
				reserved = 0;
			}
		};
		static_assert(sizeof(TxDesc) == TX_DESC_SIZE, "Wrong tx desc size");

		pci::Device getFirstNetworkPciDevice();

		class NetDriver {
		public:
			// those lengths must be a power of eight
			static const uint32 RX_DESC_COUNT = 128;
			static const uint32 TX_DESC_COUNT = 32;

			static const uint32 REG_SPACE_SIZE = 0x20000;

			bool valid;
			pci::Device pciDevice;
			uint8 *mmio_base;
			uint8 mac[6] = {0};

			alignas(16) RxDesc rxDesc[RX_DESC_COUNT];
			alignas(16) TxDesc txDesc[TX_DESC_COUNT];

			uint16 rx_tail;
			uint16 tx_tail;

			NetDriver();
			~NetDriver();
			int initRX();
			int initTX();
			void enable();
			uint16 readEEPROM(uint8 addr);
		};

		int init();
		void uninit();
		bool is_valid();
		NetDriver &driver();
	}
}

#endif
