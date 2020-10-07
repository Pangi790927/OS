#ifndef BOOT_READER_H
#define BOOT_READER_H

#include "types.h"
#include "dbg.h"
#include "pci.h"
#include "ata_driver.h"

// loads ext2 fs readonly to find the kernel data 
struct BootReader {
	// std::vector<uint8_t> intern_buff;
	// std::string filename;
	uint32_t lba_cnt = 0;
	bool is_lba_28 = false;

	BootReader() {}

	int init() {
		if (!ata::sendIdentify(0, is_lba_28, true, lba_cnt)) {
			DBG("Identify Failed");
			return -1;
		}

		return 0;
	}

	// void add_pci_hook(pci_dev_t *driver) {
	// 	driver->reg_cbk()
	// } 

	int read_sector(uint32_t lba, uint32_t cnt, char *buff) {
		if (!ata::read(buff, lba * LBA_SZ, cnt * LBA_SZ, 0, is_lba_28)) {
			DBG("failed to read from disk: addr %p lba 0x%x cnt %d is_28 %d",
					buff, lba, cnt, is_lba_28);
			return -1;
		}
		return 0;
	}

	int write_sector(uint32_t lba, uint32_t cnt, char *buff) {
		(void)lba;
		(void)cnt;
		(void)buff;
		DBG("[ERROR] can't write in bootloader, driver is readonly");
		return -1;
	}

	ProvInterface get_if() {
		return ProvInterface(this,
			[](void *ctx, uint32_t lba, uint32_t cnt, char *buff) {
				return ((BootReader *)ctx)->read_sector(lba, cnt, buff);
			},
			[](void *ctx, uint32_t lba, uint32_t cnt, char *buff) {
				return ((BootReader *)ctx)->write_sector(lba, cnt, buff);
			});
	}
};

#endif