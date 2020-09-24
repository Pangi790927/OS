#ifndef RMODE_H
#define RMODE_H

#include "types.h"

#define PTR(seg, off) ((void *)(((int)seg << 4) + off))
#define PTR_ARR(arr) PTR(arr[1], arr[0])

#define SEG(x) (((int)x & 0xf0000) >> 16)
#define OFF(x) ((int)x & 0xffff)

extern "C" uint16_t	bios_putchr(uint16_t chr);
extern "C" uint16_t get_ram_size(uint16_t addr);
extern "C" uint16_t disk_read(uint16_t addr_off, uint16_t addr_seg, uint16_t lba,
		uint16_t cnt, uint16_t drive);

#endif
