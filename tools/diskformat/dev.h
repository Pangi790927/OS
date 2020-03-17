#ifndef DEV_H
#define DEV_H

#include "file.h"

#define SECTOR_SZ 512

struct Dev {
	std::vector<uint8_t> buff;
	std::string filename;

	Dev(std::string filename) : filename(filename) {
		buff = read_file(filename);
		for (auto&& elem : buff)
			elem = 0;
	}

	void save() {
		write_file(filename, buff);
	}

	uint8_t *data() {
		if (buff.empty())
			return NULL;
		return &buff[0];
	}

	size_t sect_rount(size_t nr) {
		return (nr / SECTOR_SZ) * SECTOR_SZ;
	}

	size_t size() {
		return sect_rount(buff.size());
	}

	size_t sect_cnt() {
		return size() / SECTOR_SZ;
	}

	uint8_t *get_sect(uint32_t first_sec, uint32_t cnt = 0) {
		if (first_sec >= sect_cnt() || first_sec + cnt >= sect_cnt())
			return NULL;
		return &buff[first_sec * SECTOR_SZ];
	}

	void unload_sect(uint32_t first_sec, uint32_t cnt = 0) {
		(void)cnt;
		(void)first_sec;
	}

	void commit_sect(uint32_t first_sec, uint32_t cnt = 0) {
		(void)cnt;
		(void)first_sec;
	}
};

#endif