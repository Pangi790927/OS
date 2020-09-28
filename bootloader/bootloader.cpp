/* TO DO:
	- write code for vga selection(extension)
	+ write code for ram(extension)
	- write code for loading large areas from disk
	- write code for reading parts of mbr and gpt
	- write code for loading files from a ext2 file system
	- write code for finding an inode in a directory for ext2fs
	- write code for loading a configuration file
	- write code for storing structures from this phase for later phases
	- write code to execute protected mode stage
*/
/* EXTRA:
	- redesign stage 2 so that modules loaded in that stage could be used in
		later stages
	- maybe we can get elf here and create .so? and we can somehow use the links
		later? or will this break because we need that relative addresses thing?
*/
/* Format on disk:
	The first thing on disk will be a sector of assembler that loads this sector
	in ram. This sector will be referenced by the mbr_opts table inside mbr.
*/

#include <initializer_list>
#include "rmode.h"
#include "serial.h"
#include "dbg.h"
#include "mbr_post.h"
#include "gpt.h"
#include "vesa_bios.h"
// #include "vesa_putchar.h"
#include "ioports.h"
#include "mem_mappings.h"
#include "ext2.h"
#include "ext2_boot_reader.h"

mbr_post_t *mbr = (mbr_post_t *)0x7c00;
gpt_hdr_t *gpt = (gpt_hdr_t *)EXT2_GPT_HDR_START;

static uint16_t no_putchar(uint16_t) {
	return 0;
}

static void emu_close() {
	DBGSCOPE();
	outw(0xB004, 0x2000); // bochs
	outw(0x604, 0x2000);  // qemu
	outw(0x4004, 0x3400); // virtual box
}

static int find_vesa_mode(vesa_display_t *info) {
	vesa_info_t vesa_info;
	uint16_t ret = 0;
	DBG("vesa info ptr: %x", (void *)(&vesa_info));
	if ((ret = vesa_info_get(&vesa_info)) != 0)
		return -1;

	DBG("vesa sig: %c%c%c%c", vesa_info.sig[0], vesa_info.sig[1],
			vesa_info.sig[2], vesa_info.sig[3]);
	DBG("vesa version: %x", vesa_info.version);
	DBG("oem str ptr: %x", PTR_ARR(vesa_info.oem_str_ptr))
	DBG("oem str: %s", PTR_ARR(vesa_info.oem_str_ptr))

	if (vesa_info.version != 0x300) {
		DBG("Version not supported");
		ret = -1;
		return -1;
	}

	vesa_mode_buff_t vesa_mode_buff;
	for (size_t i = 0; i < sizeof(vesa_mode_buff); i++)
		*(char *)&vesa_mode_buff = 0;

	uint16_t *mode_ptr = (uint16_t *)PTR_ARR(vesa_info.vide_mode_ptr);
	for (int i = 0; mode_ptr[i] != 0xFFFF; i++) {
		if ((ret = vesa_mode_get(&vesa_mode_buff, mode_ptr[i])) != 0)
			continue;

		vesa_mode_t &mode = vesa_mode_buff.info;
		DBG("vesa mode: attr[%x] %x, [%dX%d] bpp: %d pitch %d base: %x",
				mode.attr, mode_ptr[i], mode.width, mode.height,
				mode.bpp, mode.pitch, mode.physbase);

		// Packed pixel or Direct Color
		if (mode.memory_model != 4 && mode.memory_model != 6)
		{
			continue;
		}

		// must be linear, must have linear frame buffer attribute, must not
		// have any padding
		if (mode.width == 800 && mode.height == 600 &&
				mode.attr & VESA_LINEAR_FBUFFER && mode.bpp == 32
				&& mode.bpp / 8 * mode.width == mode.pitch)
		{
			if ((ret = vesa_mode_set(mode_ptr[i], true)) == 0) {
				// vesa_set_putchar_mode(mode);
				intern_putchar = &no_putchar;
				DBG("selected mode: %x", mode_ptr[i]);

				info->width = mode.width;
				info->height = mode.height;
				info->pitch = mode.pitch;
				info->bpp = mode.bpp;
				info->attr = mode.attr;
				info->physbase = mode.physbase;
				return 0;
			}
			else {
				DBG("failed to set mode: %x", mode_ptr[i]);
			}
		}
	}

	return -1;
}

static void init_ramsize() {
	DBGSCOPE();
	mbr->ramsize = get_ramsize();
	DBG("RAM size: kb: %d + 64kb: %d", mbr->ramsize.ax, mbr->ramsize.bx);
}

static void init_mbr() {
	DBGSCOPE();
	auto parts = {&mbr->mbr_hdr.part1, &mbr->mbr_hdr.part2, &mbr->mbr_hdr.part3,
			&mbr->mbr_hdr.part4};
	int i = 0;
	for (auto part : parts) {
		DBG("part%d\r\nfield: [%x], start_lo [%d], start_hi: [%d], "
				"len_lo [%d], len_hi[%d], sys_id[%d]", i, part->bit_field,
				part->lo_start, part->hi_start, part->lo_len, part->hi_len,
				part->sys_id);
		// TO DO: make a smarter check
		if (part->sys_id == 0xee) {
			DBG("Found boot part: %d", i);
			mbr->mbr_boot = i;
		}
		i++;
	}
}

extern "C" int bootloader()
{
	DBGSCOPE();
	serial::init();
	DBG("Starting bootloader");
	init_ramsize();
	init_mbr();

	Ext2BootReader ro_dev(mbr->init_opts.boot_drive);
	init_gpt(ro_dev);

	uint16_t lba_start = 0;
	uint16_t lba_size = 100;
	ExtDev ext_dev(ro_dev.get_if(), lba_start, lba_size,
			(char *)EXT2_CACHE_START, EXT2_CACHE_END - EXT2_CACHE_START);
	Ext2 ext2(ext_dev, lba_size / (BLK_SIZE / LBA_SZ), lba_start);
	ext2.init();

	find_vesa_mode(&mbr->vesa_display);
	load_kernel();

	ext2.uninit();
	// for (int k = 0; k < 100; k++)
	// 	DBG("Print a string: %s %d", "a string", k);
		// fill_rect(&test_mode, 100, 100, 600, 450, 0xffaa55 * k / 100);

	// for (int i = 0; i < 100; i++)
	// 	for (int j = 0; j < 100; j++) {
	// 		fill_rect(&test_mode, 0, 0, test_mode.width, test_mode.height, 0);
	// 		fill_rect(&test_mode, 0, 0, 50, 100, 0x00ffaa);
	// 		move_rect(&test_mode, 0, 0, i * 10, j * 10, 50, 100);
	// 	}

	// 	for (int i = 100; i < 700; i++)
	// 		for (int j = 100; j < 550; j++)
	// 			put_pixel(&test_mode, i, j, 0xffaa55 * k / 10);

	emu_close();
	while (true)
		asm volatile ("nop");
	return 0;
}
