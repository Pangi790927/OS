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
#include "pci.h"
#include "brk_alloc.h"
#include "crc32.h"
#include "dev_ifaces.h"
#include "boot_dev_mgr.h"

#define CACHE_SIZE (sizeof(char[128 * 512]))

mbr_post_t *mbr = (mbr_post_t *)0x7c00;

gpt_hdr_t *gpt_hdr = NULL;
gpt_part_t *gpt_part_cache = NULL;
char *cache = NULL;

extern "C" void __cxa_pure_virtual() {
    EXCEPTION("__cxa_pure_virtual call");
}

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
			cache, CACHE_SIZE);

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
	uint32_t crc = crc32((char *)mbr->init_opts.boot2_addr,
			mbr->init_opts.boot2_cnt * LBA_SZ);

	/* first thing first, initialize debuger */
	intern_putchar = &no_putchar;
	serial::init();
	serial::sendstr("========= Entering protected mode =========\n\r");
	DBGSCOPE();

	DBG("we check own crc as fast as we can");
	if (crc != mbr->init_opts.boot2_crc) {
		DBG("wrong crc: %x, should be: %x", crc, mbr->init_opts.boot2_crc);
		return -1;
	}
	else {
		DBG("crc ok");
	}

	DBG("we initialize mem managment");
	brk_alloc_init((void *)BRK_START, BRK_SIZE);
	void *vesa_buff = brk_alloc(sizeof(vesa::buff_t));
	void *vesa_font = brk_alloc(sizeof(vesa::font_t));
	gpt_hdr = (gpt_hdr_t *)brk_alloc(LBA_SZ);
	gpt_part_cache = (gpt_part_t *)brk_alloc(LBA_SZ);
	cache = (char *)brk_alloc(CACHE_SIZE);

	if (!vesa_buff || !vesa_font || !gpt_hdr || !gpt_part_cache || !cache) {
		DBG("Failed to init memory: %p %p %p %p %p",
				vesa_buff, vesa_font, gpt_hdr, gpt_part_cache, cache);
		return -1;
	}

	DBG("initialize vesa print, from now on we will print on screeen");
	vesa::init(vesa_buff, vesa_font, mbr->vesa_display);
	intern_putchar = &vesa::putchar;

	DBG("0x17e00 < %p < %x", (void *)&intern_putchar,
			mbr->init_opts.boot2_addr + mbr->init_opts.boot2_cnt * LBA_SZ);

	DBG("initialize device manager");
	/* we first initialize dev_mgr and add our drivers to it */
	dev_mgr_init(brk_alloc, (free_fn_t)+[](void *){});
	auto dev_mgr = (dev_mgr_if *)dev_mgr_get_if(dev_mgr_if::n);

	ata_reg_drivers(dev_mgr, brk_alloc, (free_fn_t)+[](void *){});
	
	DBG("initialize pci and start reading");
	/* we then scan pci buses and create virtual devices for our real entries
	on the pci bus. */
	pci::init(dev_mgr);
	pci::scan_buses();

	/* we now let the boot reader to find a device that has our boot sector */
	BootReader boot_rodev;
	if (boot_rodev.init(dev_mgr, mbr) != 0) {
		DBG("can't init boot driver");
		return -1;
	}

	if (read_gpt(boot_rodev) != 0) {
		DBG("can't read gpt");
		return -1;
	}

	ExtDev ext_dev(boot_rodev.get_if(), gpt_part_cache->first_lba,
			boot_rodev.lba_cnt - gpt_part_cache->first_lba,
			cache, CACHE_SIZE);
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

	/* TO DO:
		- parse config (use it in stage 1 to choose vga)
		- load first and second stage of kernel
		- prepare some structures for the kernel, for example we will pass the
		detected pci-devices so the kernel won't need to find them again
		- that's all for the bootloader, we now need to structure the kernel
		in a smarter way, we will have named devices, we need to add a page
		allocator */

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
