#ifndef RMODE_H
#define RMODE_H

#include "types.h"

extern "C" uint16_t	bios_putchr(uint16_t chr);
extern "C" uint16_t get_ram_size(uint16_t addr);
extern "C" uint16_t get_vesa_info(uint16_t addr);
extern "C" uint16_t set_vesa_mode(uint16_t addr);
extern "C" uint16_t disk_read(uint16_t addr_off, uint16_t addr_seg, uint16_t lba,
		uint16_t cnt, uint16_t drive);

#endif
