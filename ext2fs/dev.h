#ifndef DEV_H
#define DEV_H

#include "dbg.h"
#include "bitmap.h"

#define LBA_SZ 512

template <class T> struct ext_remove_reference { typedef T type; };
template <class T> struct ext_remove_reference<T&> { typedef T type; };
template <class T> struct ext_remove_reference<T&&> { typedef T type; };

template<class T> inline
typename ext_remove_reference<T>::type&& ext_move(T&& arg) {
    return ((typename ext_remove_reference<T>::type&&)arg);
}

template <typename T>
inline T ext_min(const T& a, const T& b) {
	return a < b ? a : b;
} 

struct ProvInterface {
	using read_fn_t = int (*)(void *c, uint32_t lba, uint32_t cnt, char *buff);
	using write_fn_t = int (*)(void *c, uint32_t lba, uint32_t cnt, char *buff);

	void *ctx;
	read_fn_t read_fn;
	write_fn_t write_fn;

	ProvInterface(void *ctx, read_fn_t read_fn, write_fn_t write_fn)
	: ctx(ctx), read_fn(read_fn), write_fn(write_fn) {}

	int read_sector(uint32_t lba, uint32_t cnt, char *buff) {
		return read_fn(ctx, lba, cnt, buff);
	}

	int write_sector(uint32_t lba, uint32_t cnt, char *buff) {
		return write_fn(ctx, lba, cnt, buff);
	}
};

template <size_t sect_sz>
struct Dev {
	using sect_t = char[sect_sz];
	struct Sector {
		Dev *dev = NULL;
		uint32_t sect_index = -1;
		uint32_t cache_index = -1;
		char *addr = NULL;
		bool verdict = false;

		Sector() {
			verdict = true;
		}

		Sector (Dev *dev, uint32_t sect_index, uint32_t cache_index, char *addr)
		: dev(dev), sect_index(sect_index), cache_index(cache_index), addr(addr)
		{}

		Sector(const Sector&) = delete;
		Sector(Sector&& oth) {
			*this = ext_move(oth);
		}
		Sector& operator = (const Sector&) = delete;
		Sector& operator = (Sector&& oth) {
			dev = oth.dev;
			addr = oth.addr;
			sect_index = oth.sect_index;
			cache_index = oth.cache_index;
			verdict = oth.verdict;
			oth.verdict = true;
			return *this;
		}

		char *get() {
			if (verdict) {
				DBG("Invalid sector %s", backtrace_fn().c_str());
				return NULL;
			}
			return (char *)addr;
		}

		int save(bool should_unload) {
			if (verdict)  {
				DBG("Save after verdict was given");
				return -1;
			}
			if (dev->save_sect(sect_index, cache_index) < 0)
				return -1;
			if (should_unload)
				unload();
			return 0;
		}

		void unload() {
			if (verdict) {
				DBG("Save after verdict was given");
				return ;
			}
			dev->unload_sect(cache_index);
			verdict = true;
		}

		~Sector() {
			if (!verdict) {
				DBG("Sector verdict not given! %s", backtrace_fn().c_str());
			}
		}
	};

	ProvInterface iprov;
	uint32_t lba_start = 0;
	uint32_t sect_cnt = 0;

	int cache_cnt = 0;
	sect_t *cache = NULL;
	Bitmap cache_bitmap;

	Dev (ProvInterface iprov, uint32_t lba_start, uint32_t lba_cnt,
			char *cache_buff, uint32_t cache_size)
	: iprov(iprov), lba_start(lba_start), sect_cnt(lba_cnt),
			cache_bitmap(cache_buff, sect_sz)
	{
		if (cache_size % sect_sz != 0) {
			EXCEPTION("Can't use buffer of size: %d", cache_size);
		}
		if (cache_size < sect_sz * 2 || cache_size / sect_sz > sect_sz  * 8) {
			EXCEPTION("Cache is too small/big: %d", cache_size);
		}
		cache_cnt = cache_size / sect_sz;
		cache = (sect_t *)(cache_buff + sect_sz);
		cache_bitmap.reset();

		if (sect_sz % LBA_SZ)
			EXCEPTION("sect_sz should be a # of LBA_SZ");
		int factor = sect_sz / LBA_SZ;
		sect_cnt = (lba_cnt / factor) * factor;
	}

	Sector get_sect(uint32_t sect_index) {
		if (sect_index >= sect_cnt) {
			DBG("Sector index outside of dev boundry %d %s",
					sect_index, backtrace_fn().c_str());
			return Sector();
		}
		int cache_index = cache_bitmap.get_first_free();
		if (cache_index < 0 || cache_index > cache_cnt) {
			DBG("Cache for dev is full");
			return Sector();
		}
		cache_bitmap.set(cache_index, true);
		char *sect_cache = (char *)&cache[cache_index];
		uint32_t cnt = sect_sz / LBA_SZ;
		if (iprov.read_sector(lba_index(sect_index), cnt, sect_cache) < 0) {
			DBG("Driver couldn't load sector %d", sect_index);
			return Sector();
		}
		// DBG("read block: %d cache_index: %d", sect_index, cache_index);
		// util::hexdump(sect_cache, sect_sz);

		return Sector(this, sect_index, cache_index, sect_cache);
	}

private:
	uint32_t lba_index(uint32_t sect_index) {
		if (sect_sz == LBA_SZ)
			return sect_index;
		if (sect_sz % LBA_SZ)
			EXCEPTION("sect_sz should be a # of LBA_SZ");
		return lba_start + (sect_sz / LBA_SZ) * sect_index;
	}

	int save_sect(uint32_t sect_index, uint32_t cache_index) {
		char *sect_cache = (char *)&cache[cache_index];
		uint32_t cnt = sect_sz / LBA_SZ;

		// DBG("write block: %d cache_index: %d", sect_index, cache_index);
		// util::hexdump(sect_cache, sect_sz);
		if (iprov.write_sector(lba_index(sect_index), cnt, sect_cache) < 0) {
			DBG("Driver couldn't write sector");
			return -1;
		}
		return 0;
	}

	void unload_sect(uint32_t cache_index) {
		// DBG("Unload index: %d", cache_index);
		cache_bitmap.set(cache_index, false);
	}
};

// struct Dev {
// 	std::string filename;

// 	Dev(std::string filename) : filename(filename) {
// 		buff = read_file(filename);
// 		for (auto&& elem : buff)
// 			elem = 0;
// 	}

// 	void save() {
// 		write_file(filename, buff);
// 	}

// 	size_t sect_rount(size_t nr) {
// 		return (nr / SECTOR_SZ) * SECTOR_SZ;
// 	}

// 	size_t size() {
// 		return sect_rount(buff.size());
// 	}

// 	size_t sect_cnt() {
// 		return size() / SECTOR_SZ;
// 	}

// 	uint8_t *get_sect(uint32_t first_sec, uint32_t cnt = 0) {
// 		if (first_sec >= sect_cnt() || first_sec + cnt >= sect_cnt())
// 			return NULL;
// 		return &buff[first_sec * SECTOR_SZ];
// 	}

// 	void unload_sect(uint32_t first_sec, uint32_t cnt = 0) {
// 		(void)cnt;
// 		(void)first_sec;
// 	}

// 	void commit_sect(uint32_t first_sec, uint32_t cnt = 0) {
// 		(void)cnt;
// 		(void)first_sec;
// 	}
// };

#endif