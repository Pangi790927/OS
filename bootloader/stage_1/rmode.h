#ifndef RMODE_H
#define RMODE_H

#include "types.h"
#include "ramsize.h"

#define PTR(seg, off) ((void *)(((int)seg << 4) + off))
#define PTR_ARR(arr) PTR(arr[1], arr[0])

#define SEG(x) ((((int)x & 0xf0000) >> 16) << 12)
#define OFF(x) ((int)x & 0xffff)

extern "C" uint16_t	bios_putchr(uint16_t chr);
extern "C" uint16_t get_ram_size(uint16_t addr);
extern "C" long load_prot_mode(long gdt_addr, long code_sel,
		long code_addr, long data_sel);
extern "C" uint16_t disk_read(uint16_t addr_off, uint16_t addr_seg, uint16_t lba,
		uint16_t cnt, uint16_t drive);

// TO DO: fix bug not reading ram
inline ramsize_t get_ramsize(void (*perr)(const char *err)) {
	ramsize_t ret = { .ax = 0xbad, .bx = 0xfeed };
	uint64_t ptr = (uint64_t)&ret;
	if (ptr < (1 << 16))
		get_ram_size(uint16_t(ptr));
	else
		perr("Failed to get ramsize: pointer too far");
	if (ret.ax == (uint16_t)-1 && ret.bx == (uint16_t)-2)
		perr("Failed to get ramsize: int 0x15 returned error");
	return ret;
}


#endif
