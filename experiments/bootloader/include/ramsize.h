#ifndef RAMSIZE_H
#define RAMSIZE_H

#include "types.h"
#include "rmode.h"

struct ramsize_t {
	uint16_t ax; // kbytes under 16M
	uint16_t bx; // 64k blocks after 16M
} __attribute__((__packed__));

// TO DO: fix bug not reading ram
inline ramsize_t get_ramsize() {
	ramsize_t ret = { .ax = 0xbad, .bx = 0xfeed };
	uint64_t ptr = (uint64_t)&ret;
	if (ptr < (1 << 16))
		get_ram_size(uint16_t(ptr));
	else
		DBG("Failed to get ramsize: pointer too far");
	if (ret.ax == (uint16_t)-1 && ret.bx == (uint16_t)-2)
		DBG("Failed to get ramsize: int 0x15 returned error");
	return ret;
}

#endif
