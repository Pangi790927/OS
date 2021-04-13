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

#include "rmode.h"
#include "serial.h"
#include "dbg.h"
#include "mbr_post.h"
#include "gpt.h"
#include "vesa_bios.h"
// #include "vesa_putchar.h"
#include "ioports.h"
// #include "mem_mappings.h"

mbr_post_t *mbr = (mbr_post_t *)0x7c00;

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
	DBGSCOPE();
	vesa_info_t vesa_info;
	uint16_t ret = 0;
	DBG("vesa info ptr: %x", (void *)(&vesa_info));
	if ((ret = vesa_info_get(&vesa_info)) != 0)
		return -1;

	DBG("vesa sig: %c%c%c%c", vesa_info.sig[0], vesa_info.sig[1],
			vesa_info.sig[2], vesa_info.sig[3]);
	DBG("vesa version: %x", vesa_info.version);
	DBG("oem str ptr: %x", PTR_ARR(vesa_info.oem_str_ptr))
	// DBG("oem str: %s", PTR_ARR(vesa_info.oem_str_ptr))

	if (vesa_info.version != 0x200 && vesa_info.version != 0x300) {
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
	mbr->ramsize = get_ramsize([](const char *err){ DBG("[err]: %s", err); });
	DBG("RAM size: kb: %d + 64kb: %d", mbr->ramsize.ax, mbr->ramsize.bx);
}

static void init_mbr() {
	DBGSCOPE();
	mbr_part_t *parts[] = {&mbr->mbr_hdr.part1, &mbr->mbr_hdr.part2,
			&mbr->mbr_hdr.part3, &mbr->mbr_hdr.part4};
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

static void drive_info() {
	uint16_t drive = mbr->init_opts.boot_drive;

	// DRIVE INFO ==============================================================
	int ret;
	for (uint i = 0; i < sizeof(mbr->boot_dev_info); i++)
		((char *)&mbr->boot_dev_info)[i] = 0;
	mbr->boot_dev_info.size = sizeof(mbr->boot_dev_info);
	uint16_t binfo_off = OFF(&mbr->boot_dev_info);
	uint16_t binfo_seg = SEG(&mbr->boot_dev_info);
	DBG("drive: %x, bioff: %x, biseg: %x", drive, binfo_off, binfo_seg);
	if ((ret = get_boot_dev(drive, binfo_off, binfo_seg)) != 0) {
		DBG("Failed to read boot drive info: %x", ret);
		return ;
	}
	DBG("sz: %x", mbr->boot_dev_info.size);
	DBG("cylinders: %x", mbr->boot_dev_info.cylinders);
	DBG("heads: %x", mbr->boot_dev_info.heads);
	DBG("sectors: %x", mbr->boot_dev_info.sectors_per_track);
	DBG("total sectors1: %x", mbr->boot_dev_info.total_sectors1);
	DBG("total sectors2: %x", mbr->boot_dev_info.total_sectors2);
	DBG("sect_sz: %x", mbr->boot_dev_info.sect_sz);
	DBG("dpte_off: %x", mbr->boot_dev_info.dpte_off);
	DBG("dpte_seg: %x", mbr->boot_dev_info.dpte_seg);
	if (mbr->boot_dev_info.sig != 0xbedd && mbr->boot_dev_info.dev_path_size !=
			0x24)
	{
		DBG("Invalid path info for boot dev: sig[%x] path_sz[%x]",
				mbr->boot_dev_info.sig, mbr->boot_dev_info.dev_path_size);
		return ;
	}
	mbr->boot_dev_info.host_bus[3] = 0;
	mbr->boot_dev_info.if_type[7] = 0;
	DBG("host_bus: %s", mbr->boot_dev_info.host_bus);
	DBG("if_type: %s", mbr->boot_dev_info.if_type);
}

static void load_stage2() {
	DBGSCOPE();
	// TO DO: enter protected mode
	// STAGE_2_OFFSET equ 0xA000

	void *addr = (void *)mbr->init_opts.boot2_addr;
	uint16_t lba = mbr->init_opts.boot2_lba;
	uint16_t cnt = mbr->init_opts.boot2_cnt;
	uint16_t drive = mbr->init_opts.boot_drive;

	// DRIVE READ ==============================================================
	DBG("Will read disk to: %x, lba: %x, cnt: %d, drive: %x",
			addr, lba, cnt, drive);

	uint16_t addr_off = OFF(addr);
	uint16_t addr_seg = SEG(addr);
	uint16_t lba_aux = lba;
	while (cnt) {
		uint16_t to_read = cnt > 128 ? 128 : cnt;
		DBG("read block: cnt: %d lba: %d off: %x seg %x",
				to_read, lba_aux, addr_off, addr_seg);
		int ret = disk_read(addr_off, addr_seg, lba_aux,
				to_read, drive);
		if (ret != 0) {
			DBG("Can't read from disk: %x", ret);
			return ;
		}
		addr_seg += 0x1000;
		lba_aux += to_read;
		cnt -= to_read;
	}

	// GPT INIT ================================================================
	DBG("Will init gdt");

	for (uint16_t i = 0; i < sizeof(mbr->gdt) / sizeof(mbr->gdt[0]); i++)
		mbr->gdt[i].zero();

	// null desc
	mbr->gdt[0].zero();
	
	// code gdt entry
	mbr->gdt[1].zero();
	mbr->gdt[1].access.rw = 1;
	mbr->gdt[1].access.ex = 1;
	mbr->gdt[1].access.s = 1;
	mbr->gdt[1].access.pr = 1;
	mbr->gdt[1].flag_sz = 1;
	mbr->gdt[1].flag_gr = 1;
	mbr->gdt[1].set_limit(0xf'ffff);
	mbr->gdt[1].set_base(0);
	DBG("code selector: limit: %x, base: %x, access: %x, gr: %d, sz: %d",
			mbr->gdt[1].get_limit(), mbr->gdt[1].get_base(),
			mbr->gdt[1].access_val, mbr->gdt[1].flag_gr, mbr->gdt[1].flag_sz);

	// data gdt entry
	mbr->gdt[2].zero();
	mbr->gdt[2].access.rw = 1;
	mbr->gdt[2].access.s = 1;
	mbr->gdt[2].access.pr = 1;
	mbr->gdt[2].flag_sz = 1;
	mbr->gdt[2].flag_gr = 1;
	mbr->gdt[2].set_limit(0xf'ffff);
	mbr->gdt[2].set_base(0);
	DBG("data selector: limit: %x, base: %x, access: %x, gr: %d, sz: %d",
			mbr->gdt[2].get_limit(), mbr->gdt[2].get_base(),
			mbr->gdt[2].access_val, mbr->gdt[2].flag_gr, mbr->gdt[2].flag_sz);

	DBG("dump gdt: %p", mbr->gdt);
	for (int i = 0; i < 6; i++)
		DBG("%b", *((uint32_t *)mbr->gdt + i));

	mbr->gdt_desc.addr = (uint32_t)mbr->gdt;
	mbr->gdt_desc.size = sizeof(mbr->gdt[0]) * 3 - 1;

	DBG("gdt addr: %x, gdt size %d", mbr->gdt_desc.addr, mbr->gdt_desc.size);
	DBG("desc addr: %x", (void *)&mbr->gdt_desc);

	gdt_sel_t code_sel;
	code_sel.index = 1;
	code_sel.t = 0;
	code_sel.priv = 0;

	gdt_sel_t data_sel;
	data_sel.index = 2;
	data_sel.t = 0;
	data_sel.priv = 0;

	DBG("code sel: %x, data sel %x", (uint16_t)code_sel, (uint16_t)data_sel);
	DBG("&load_prot_mode: %p", (void *)&load_prot_mode);

	// START PROTECTED MODE ====================================================
	load_prot_mode((long)&mbr->gdt_desc, code_sel, (long)addr, data_sel);
}

extern "C" int boot1()
{
	serial::init();
	DBGSCOPE();
	DBG("Starting boot1 %d", sizeof(mbr_part_t));
	init_ramsize();
	init_mbr();
	find_vesa_mode(&mbr->vesa_display);
	drive_info();
	load_stage2();

	DBG("[FATAL ERROR] returned to caller in boot1");
	emu_close();
	while (true)
		asm volatile ("nop");
	return 0;
}
