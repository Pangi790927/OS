#ifndef MBR_HDR_H
#define MBR_HDR_H

#include "mbr_opts.h"

struct mbr_part_t {
	uint8_t		bit_field;
	uint8_t		sig1;
	uint16_t	hi_start;
	uint8_t		sys_id;
	uint8_t		sig2;
	uint16_t	hi_len;
	uint32_t	lo_start;
	uint32_t	lo_len;
} __attribute__((__packed__));

struct mbr_hdr_t {
	uint8_t		code[400];
	mbr_opts_t	opts;
	uint32_t	disk_sig;
	uint16_t	zero2;
	mbr_part_t	part1;
	mbr_part_t	part2;
	mbr_part_t	part3;
	mbr_part_t	part4;
	uint16_t	boot_sig;
} __attribute__((__packed__));

#endif