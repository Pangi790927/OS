#ifndef MBR_POST_H
#define MBR_POST_H

#include "types.h"
#include "mbr_opts.h"
#include "ramsize.h"

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
	uint32_t	disk_sig;
	uint16_t	zero2;
	mbr_part_t	part1;
	mbr_part_t	part2;
	mbr_part_t	part3;
	mbr_part_t	part4;
	uint16_t	boot_sig;
} __attribute__((__packed__));

struct vesa_display_t {
	uint16_t	width;
	uint16_t	height;
	uint16_t	pitch;			// bytes_per_scan_line
	uint8_t		bpp;
	uint16_t	attr;
	uint32_t	physbase;
} __attribute__((__packed__));

struct mbr_post_t {
	union {
		struct {
			union {
				struct {
					/* here we will put data that must remain post boot and this
					structure must be known from kernel, reutilizes the mbr
					code to store those values */
					ramsize_t ramsize;
					vesa_display_t vesa_display;
					int mbr_boot;
				} __attribute__((__packed__));
				uint8_t data1[400];
			};
			mbr_opts_t init_opts;
			mbr_hdr_t mbr_hdr;
		} __attribute__((__packed__));
		uint8_t data2[512];
	};
} __attribute__((__packed__));

#endif