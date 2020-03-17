#ifndef GPT_HDR_H
#define GPT_HDR_H

struct gpt_part_t {
	uint8_t		type_guid[16];
	uint8_t		uniq_guid[16];
	uint64_t	first_lba;
	uint64_t	last_lba;
	uint64_t	flags;
	uint8_t		name[72];
} __attribute__((__packed__));


struct gpt_hdr_t {
	union {
		struct __attribute__((__packed__)) {
			uint8_t		sig[8];
			uint32_t	rev;
			uint32_t	hdr_sz;
			uint32_t	hdr_crc;
			uint32_t	zero1;
			uint64_t	curr_lba;
			uint64_t	backup_lba;
			uint64_t	first_part_lba;
			uint64_t	last_part_lba;
			uint8_t		guid[16];
			uint64_t	part_arr_lba;
			uint32_t	part_cnt;
			uint32_t	part_sz;
			uint32_t	part_crc;
		};
		uint8_t data[512];
	};
} __attribute__((__packed__));

#endif