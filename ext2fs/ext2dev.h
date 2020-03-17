#ifndef EXT2DEV_H
#define EXT2DEV_H

#include <vector>
#include <map>
#include <cstring>

#include "dev.h"
#include "except.h"

struct zone_data_t {
	uint32_t sect_start = 0;
	uint32_t sect_cnt = 0;
};

inline uint64_t sect2faddr(uint32_t sect) {
	return sect * SECTOR_SZ;
}

// this loses precision as this will point to the sector having that address
// but the start of that sector is not necessarily equal to faddr
inline uint32_t faddr2sect(uint64_t faddr) {
	return faddr / SECTOR_SZ;
}

inline void print_zone(uint32_t start, zone_data_t zone) {
	zone.sect_start -= start;
	for (uint32_t i = 0; i < 120; i++) {
		printf("%c",
				i >= zone.sect_start && i < zone.sect_start + zone.sect_cnt ?
				'#' : '.');
	}
	printf("%c\n", 121 < zone.sect_start + zone.sect_cnt ? '>' : '.');
}

class Ext2Dev {
public:
	Dev &dev;
	uint32_t start;
	uint32_t cnt;
	std::map<void *, zone_data_t> loaded_zones;

	Ext2Dev(Dev &dev, uint32_t start, uint32_t cnt)
	: dev(dev), start(start), cnt(cnt) {}

	template <typename Type>
	Type *load(uint64_t faddr, uint64_t size) {
		auto zone = get_zone(faddr, size);
		void *sect_addr = dev.get_sect(zone.sect_start, zone.sect_cnt);
		void *addr = (char *)sect_addr + faddr -
				sect2faddr(zone.sect_start - start);
		loaded_zones[addr] = zone;
		// printf("R[%4u, %4u]:", zone.sect_start, zone.sect_cnt);
		// print_zone(start, zone);
		return (Type *)addr;
	}

	void unload(void *ptr) {
		if (loaded_zones.find(ptr) != loaded_zones.end()) {
			auto zone = loaded_zones[ptr];
			dev.unload_sect(zone.sect_start, zone.sect_cnt);
			loaded_zones.erase(ptr);
		}
	}

	void write(void *ptr, uint64_t faddr, uint64_t size) {
		auto zone = get_zone(faddr, size);
		void *sect_addr = dev.get_sect(zone.sect_start, zone.sect_cnt);
		void *addr = (char *)sect_addr + faddr -
				sect2faddr(zone.sect_start - start);
		memmove(addr, ptr, size);
		// printf("W[%4u, %4u]:", zone.sect_start, zone.sect_cnt);
		// print_zone(start, zone);
		dev.commit_sect(zone.sect_start, zone.sect_cnt);
		dev.unload_sect(zone.sect_start, zone.sect_cnt);
	}

	~Ext2Dev() {
		// unload all loaded zones
		for (auto&& [ptr, zone] : loaded_zones)
			dev.unload_sect(zone.sect_start, zone.sect_cnt);
	}

	zone_data_t get_zone(uint64_t faddr, uint64_t size) {
		uint32_t sect_start = faddr2sect(faddr) + start;
		uint32_t end_sect = faddr2sect(faddr + size) + start;
		if ((faddr + size) % SECTOR_SZ == 0)
			end_sect--;
		uint32_t sect_cnt = end_sect - sect_start + 1;
		if (sect_start + sect_cnt > start + cnt)
			EXCEPTION("Requested too much memory from this dev: \n"
					"[faddr]%lu [size]%lu [start]%u [cnt]%u",
					faddr, size, start, cnt);
		return zone_data_t{
			.sect_start = sect_start,
			.sect_cnt = sect_cnt
		};
	}
};

#endif