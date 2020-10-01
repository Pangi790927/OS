#ifndef GDT_H
#define GDT_H

#include "types.h"

/*
	direction bit:
		* for data selectors tells if the sector grows up or down, for us should
			be 0
		* for code selectors:
			- 1 means that lower or eq priv can execute this code
				ex: code from ring 0 cannot execute code from priv 2
				ex: code from ring 3 and 2 can execute code from priv 2
			- 0 means only eq priv can execute this code
	readable bit/writeable bit:
		* for data: if you can write here, read is always allowed
		* for code: if you can read, write is never allowed
*/
struct gdt_access_t {
	uint8_t	ac		: 1;	// set to 0, cpu sets to 1 when using it
	uint8_t	rw		: 1;	// readable bit/writeable bit
	uint8_t	dc		: 1;	// direction bit
	uint8_t	ex		: 1;	// executable bit, 0 for data sector
	uint8_t	s		: 1;	// 1:code/data, 0:sys_segs(ex: tss)
	uint8_t	priv	: 2;	// privilege 0:kernel, 3:user 
	uint8_t	pr		: 1;	// present bit, must be 1 for valid selector
} __attribute__((__packed__));

struct gdt_entry_t {
	uint16_t	limit_lo;
	uint16_t	base_lo;
	uint8_t		base_mi;
	union {
		gdt_access_t access;
		uint8_t access_val;
	};
	uint8_t		limit_hi	: 4;
	uint8_t		flag_zero	: 2;	// set to 0
	uint8_t		flag_sz 	: 1;	// 0 means 16 bit mode, 1 means 32 bit mode
	uint8_t		flag_gr		: 1;	// 0 means 1byte granularity, else 4Kb
	uint8_t		base_hi;

	void zero() {
		limit_lo = 0;
		base_lo = 0;
		base_mi = 0;
		access.ac = 0;
		access.rw = 0;
		access.dc = 0;
		access.ex = 0;
		access.s = 0;
		access.priv = 0;
		access.pr = 0;
		limit_hi = 0;
		flag_zero = 0;
		flag_sz = 0;
		flag_gr = 0;
		base_hi = 0;
	}

	void set_limit(uint32_t value) {
		limit_lo = value & 0xffff;
		limit_hi = (value >> 16) & 0xf;
	}

	uint32_t get_limit() {
		return uint32_t(limit_lo) | (uint32_t(limit_hi) << 16);
	}

	void set_base(uint32_t value) {
		base_lo = value & 0xffff;
		base_mi = (value >> 16) & 0xff;
		base_hi = (value >> 24) & 0xff;
	}

	uint32_t get_base() {
		return uint32_t(base_lo) | (uint32_t(base_mi) << 16) |
				(uint32_t(base_hi) << 24);
	}

} __attribute__((__packed__));

struct gdt_desc_t {
	uint16_t size;
	uint32_t addr;
} __attribute__((__packed__));

struct gdt_sel_t {
	uint16_t priv		: 2;
	uint16_t t			: 1;
	uint16_t index		: 13;

	gdt_sel_t(uint16_t value = 0) {
		*(uint16_t *)this = value;
	}

	operator uint16_t() {
		return *(uint16_t *)this;	
	}
} __attribute__((__packed__));

#endif