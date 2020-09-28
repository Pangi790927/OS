#ifndef EXT2_BOOT_H
#define EXT2_BOOT_H

#include "rmode.h"

// loads ext2 fs readonly to find the kernel data 
struct Ext2BootReader {
	// std::vector<uint8_t> intern_buff;
	// std::string filename;
	uint32_t drive = 0;

	Ext2BootReader(uint32_t drive) : drive(drive) {
		DBG("will use drive: %x", drive);
	}

	int read_sector(uint32_t lba, uint32_t cnt, char *buff) {
		int ret = 0;
		ret = disk_read(OFF(buff), SEG(buff), lba, cnt, drive);
		if (ret != 0) {
			DBG("disk_read returned err code: %d", ret);
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

	// uint32_t lba_size() {
	// 	return lba_cnt;
	// }

	// void save() {
	// 	write_file(filename, intern_buff);
	// }

	ProvInterface get_if() {
		return ProvInterface(this,
			[](void *ctx, uint32_t lba, uint32_t cnt, char *buff) {
				return ((Ext2BootReader *)ctx)->read_sector(lba, cnt, buff);
			},
			[](void *ctx, uint32_t lba, uint32_t cnt, char *buff) {
				return ((Ext2BootReader *)ctx)->write_sector(lba, cnt, buff);
			});
	}
};

#endif