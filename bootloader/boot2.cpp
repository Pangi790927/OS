#include <initializer_list>
#include "serial.h"
#include "dbg.h"
#include "mbr_post.h"
#include "gpt.h"
#include "vesa_putchar.h"
#include "ioports.h"
#include "mem_mappings.h"

// TO DO: rename dev.h
#include "ext2.h"
#include "boot_reader.h"

mbr_post_t *mbr = (mbr_post_t *)0x7c00;
gpt_hdr_t *gpt_hdr = (gpt_hdr_t *)EXT2_GPT_HDR_START;
gpt_part_t *gpt_part_cache = (gpt_part_t *)EXT2_GPT_PART_SEC_START;

char *cache = (char *)EXT2_CACHE_START;
uint32_t cache_size = EXT2_CACHE_END - EXT2_CACHE_START;

static uint16_t no_putchar(uint16_t) {
	return 0;
}

static void emu_close() {
	DBGSCOPE();
	outw(0xB004, 0x2000); // bochs
	outw(0x604, 0x2000);  // qemu
	outw(0x4004, 0x3400); // virtual box
}

static int read_gpt(BootReader &boot_rodev) {
	using GptDev = Dev<LBA_SZ>;
	mbr_part_t *parts[] = {&mbr->mbr_hdr.part1, &mbr->mbr_hdr.part2,
			&mbr->mbr_hdr.part3, &mbr->mbr_hdr.part4};

	int gpt_lba = parts[mbr->mbr_boot]->lo_start |
			parts[mbr->mbr_boot]->hi_start;

	DBG("gpt_lba: %x", gpt_lba);
	GptDev gpt_dev(boot_rodev.get_if(), 0, boot_rodev.lba_cnt,
			cache, cache_size);

	auto hdr_sect = gpt_dev.get_sect(gpt_lba);
	if (!hdr_sect.get()) {
		DBG("can't read gpt header");
		return -1;
	}
	for (uint i = 0; i < sizeof(gpt_hdr_t); i++)
		((char *)gpt_hdr)[i] = hdr_sect.get()[i];
	hdr_sect.unload();

	char sig[9] = {0};
	for (uint i = 0; i < 8; i++)
		sig[i] = gpt_hdr->sig[i];
	DBG("gpt sig: %s", sig);
	DBG("gpt part array lba: %d", gpt_hdr->part_arr_lba);

	auto part_sect = gpt_dev.get_sect(gpt_hdr->part_arr_lba);
	if (!part_sect.get()) {
		DBG("can't read first gpt partition");
		return -1;
	}

	for (uint i = 0; i < sizeof(gpt_part_t); i++)
		((char *)gpt_part_cache)[i] = part_sect.get()[i];

	part_sect.unload();

	char type_guid[17] = {0};
	for (uint i = 0; i < 16; i++)
		type_guid[i] = gpt_part_cache->type_guid[i];
	DBG("gpt part 1 type_guid: %s", type_guid);
	DBG("gpt part 1 first_lba: %d", gpt_part_cache->first_lba);
	return 0;
}

extern "C" int boot2()
{
	intern_putchar = &no_putchar;
	serial::sendstr("========= Entering protected mode =========\n\r");

	// no need to re-init serial
	// serial::init();
	vesa::init((void *)VESA_PUTCHAR_BUFF_START, (void *)VESA_PUTCHAR_FONT_START,
			mbr->vesa_display);
	intern_putchar = &vesa::putchar;
	DBGSCOPE();

	BootReader boot_rodev;
	if (boot_rodev.init() != 0) {
		DBG("can't init boot driver");
		return -1;
	}

	if (read_gpt(boot_rodev) != 0) {
		DBG("can't read gpt");
		return -1;
	}

while (true)
		asm volatile ("nop");
	ExtDev ext_dev(boot_rodev.get_if(), gpt_part_cache->first_lba,
			boot_rodev.lba_cnt - gpt_part_cache->first_lba,
			cache, cache_size);
	Ext2 ext2(ext_dev, ext_dev.sect_cnt / (BLK_SIZE / LBA_SZ),
			gpt_part_cache->first_lba);
	if (ext2.init() != 0){
		DBG("Can't init ext2");
		return -1;
	}

	ext2.dirs.listdir("/", [](auto& entry, int, int) {
		DBG("[%d]/%s", entry.ino, entry.name);
		return 0;
	});

	ext2.dirs.listdir("/boot", [](auto& entry, int, int) {
		DBG("[%d]/%s", entry.ino, entry.name);
		return 0;
	});

	char conf[BLK_SIZE];
	int conf_ino = ext2.dirs.find_rec("/boot/boot.conf");
	if (conf_ino <= 0) {
		DBG("can't find config inode");
		return -1;
	}
	int ret = ext2.inodes.read(conf_ino, 0, conf, BLK_SIZE);
	if (ret <= 0) {
		DBG("can't read config inode");
		return -1;
	}

	DBG("boot.conf:\n%s", conf);

	for (int i = 0; i < 100; i++)
		DBG("printing i: %d", i);

	ext2.uninit();

	// uint32_t conf_lba = mbr->init_opts.conf_lba;
	// uint32_t conf_cnt = mbr->init_opts.conf_cnt;
	// char conf[BLK_SIZE];
	// boot_rodev.read_sector(conf_lba, conf_cnt, conf);
	// DBG("conf[lba %x cnt: %d]:\n%s", conf_lba, conf_cnt, conf);

	emu_close();
	while (true)
		asm volatile ("nop");
	return 0;
}
