#ifndef FILE_PROV_DEV_H
#define FILE_PROV_DEV_H

struct FileProvDev {
	std::vector<uint8_t> intern_buff;
	std::string filename;
	uint32_t lba_cnt = 0;

	FileProvDev(std::string filename) : filename(filename) {
		intern_buff = read_file(filename);
		lba_cnt = (intern_buff.size() / LBA_SZ);
	}

	int read_sector(uint32_t lba, uint32_t cnt, char *buff) {
		if (lba >= lba_cnt || lba + cnt - 1 >= lba_cnt) {
			DBG("Outside of bounds lba: %d max: %d, cnt: %d",
					lba, lba_cnt, cnt);
			return -1;
		}
		uint8_t *addr = (uint8_t *)&intern_buff[lba * LBA_SZ];
		memcpy(buff, addr, LBA_SZ * cnt);
		return 0;
	}

	int write_sector(uint32_t lba, uint32_t cnt, char *buff) {
		if (lba >= lba_cnt || lba + cnt - 1 >= lba_cnt) {
			DBG("Outside of bounds lba: %d max: %d, cnt: %d",
					lba, lba_cnt, cnt);
			return -1;
		}
		uint8_t *addr = (uint8_t *)&intern_buff[lba * LBA_SZ];
		memcpy(addr, buff, LBA_SZ * cnt);
		return 0;
	}

	uint32_t lba_size() {
		return lba_cnt;
	}

	void save() {
		write_file(filename, intern_buff);
	}

	ProvInterface get_if() {
		return ProvInterface(this,
			[](void *ctx, uint32_t lba, uint32_t cnt, char *buff) {
				return ((FileProvDev *)ctx)->read_sector(lba, cnt, buff);
			},
			[](void *ctx, uint32_t lba, uint32_t cnt, char *buff) {
				return ((FileProvDev *)ctx)->write_sector(lba, cnt, buff);
			});
	}
};

#endif