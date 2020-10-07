#ifndef MBR_POST_H
#define MBR_POST_H

#include "types.h"
#include "mbr_opts.h"
#include "ramsize.h"
#include "gdt.h"

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
	uint8_t		reserved;
	uint16_t	reserved2;
} __attribute__((__packed__));

struct boot_if_path_t {
	union {
		struct {
			uint16_t base_addr;
			uint8_t reserved[6];
		} isa;
		struct {
			uint8_t bus;
			uint8_t dev;
			uint8_t fn;
			uint8_t reserved[5];
		} pci;
	};
} __attribute__((__packed__));

struct boot_dev_path_t {
	union {
		struct {
			uint8_t master_slave;	// 0/1
			uint8_t reserved[7];
		} ata;
		struct {
			uint8_t master_slave;	// 0/1
			uint8_t logical_unit_number;
			uint8_t reserved[6];
		} atapi;
		struct {
			uint8_t logical_unit_number;
			uint8_t reserved[7];
		} scsi;
		struct {
			uint8_t to_be_determined;
			uint8_t reserved[7];
		} usb;
		struct {
			uint64_t fibre_wire_guid;
		} ieee1394;
		struct {
			uint64_t word_wide_number;
		} fibre;
	};
} __attribute__((__packed__));

struct boot_dev_info_t {
	uint16_t size;					// 0x42 for v3
	uint16_t info_flags;
	uint32_t cylinders;
	uint32_t heads;
	uint32_t sectors_per_track;
	uint32_t total_sectors1;
	uint32_t total_sectors2;
	uint16_t sect_sz;
	uint16_t dpte_off;
	uint16_t dpte_seg;
	uint16_t sig;					// should be BEDDh for dev_path_info
	uint8_t dev_path_size;			// including signature and this byte (24h)
	uint8_t reserved[3];
	char host_bus[4];				// pci/sci
	char if_type[8];				// ATA/ATAPI/etc
	boot_if_path_t if_path;
	boot_dev_path_t dev_path; 
	uint8_t reserved2;
	uint8_t checksum;
} __attribute__((__packed__));

struct mbr_post_t {
	union {
		struct {
			union {
				struct {
					gdt_entry_t gdt[32];
					gdt_desc_t gdt_desc;
					boot_dev_info_t boot_dev_info;
					/* to do: move gdt here, max 32 entryes(256 bytes) */
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

static_assert(sizeof(mbr_post_t) == 512, "Boot sector must be 512 bytes");

#endif