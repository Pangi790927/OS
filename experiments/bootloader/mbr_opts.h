#ifndef MBR_OPTS_H
#define MBR_OPTS_H

struct mbr_opts_t {
	uint8_t boot_drive;
	uint16_t boot_start;
	uint16_t boot_size;
	uint16_t boot_addr;
} __attribute__((__packed__));

#endif