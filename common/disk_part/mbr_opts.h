#ifndef MBR_OPTS_H
#define MBR_OPTS_H

struct mbr_opts_t {
	union {
		struct {
			uint8_t boot_drive;
			uint16_t boot1_addr;
			uint32_t boot2_addr;
			uint16_t boot1_lba;
			uint16_t boot1_cnt;
			uint16_t boot2_lba;
			uint16_t boot2_cnt;
			uint16_t conf_lba;
			uint16_t conf_cnt;
		} __attribute__((__packed__));
		char data[40];
	};
} __attribute__((__packed__));

#endif