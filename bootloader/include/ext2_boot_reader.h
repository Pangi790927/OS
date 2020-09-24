#ifndef EXT2_BOOT_H
#define EXT2_BOOT_H

// loads ext2 fs readonly to find the kernel data 
struct Ext2BootReader {
	// std::vector<uint8_t> intern_buff;
	// std::string filename;
	uint32_t lba_cnt = 0;

	// Ext2BootReader(std::string filename) : filename(filename) {
	// 	intern_buff = read_file(filename);
	// 	lba_cnt = (intern_buff.size() / LBA_SZ);
	// }

	int read_sector(uint32_t lba, uint32_t cnt, char *buff) {
		if (lba >= lba_cnt || lba + cnt - 1 >= lba_cnt) {
			DBG("Outside of bounds lba: %d max: %d, cnt: %d",
					lba, lba_cnt, cnt);
			return -1;
		}
		(void)buff;
		DBG("[ERROR] TO DO: implement it");
		// uint8_t *addr = (uint8_t *)&intern_buff[lba * LBA_SZ];
		// memcpy(buff, addr, LBA_SZ * cnt);
		return -1;
	}

	int write_sector(uint32_t lba, uint32_t cnt, char *buff) {
		if (lba >= lba_cnt || lba + cnt - 1 >= lba_cnt) {
			DBG("Outside of bounds lba: %d max: %d, cnt: %d",
					lba, lba_cnt, cnt);
			return -1;
		}
		(void)buff;
		DBG("[ERROR] can't write in bootloader, driver is readonly");
		return -1;
	}

	uint32_t lba_size() {
		return lba_cnt;
	}

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