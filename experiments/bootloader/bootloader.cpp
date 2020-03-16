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
	- redisaign stage 2 so that modules loaded in that stage could be used in
		later stages
	- maybe we can get elf here and create .so? and we can somehow use the links
		later? or will this break because we need that relative addresses thing?
*/
/* Format on disk:
	The first thing on disk will be a sector of assembler that loads this sector
	in ram. This sector will be referenced by the mbr_opts table inside mbr.
*/

#include <initializer_list>
#include "serial.h"
#include "dbg.h"
#include "mbr_post.h"
#include "gpt.h"

mbr_post_t *mbr = (mbr_post_t *)0x7c00;
gpt_hdr_t gpt;

void gather_info() {
	DBGSCOP();

	// get ram size
	mbr->ramsize = get_ramsize();
	DBG("RAM size: kb: %d + 64kb: %d", mbr->ramsize.ax, mbr->ramsize.bx);

	// iterate mbr partitions:
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
	// TO DO: check if partition is gpt
	/* next steps:
		- manage vesa and save a pointer to it's structures
		- read gpt and check it
		- read superblock from first partition and check it
		- read inode 2 and search for /boot and find the kernel in it
		- in dir /boot find 'boot_opts' and read it
	*/
	/* obs:
		- in boot_opts we will find how big is the first phase of the kernel
		- in boot_opts we will see what we want for vesa(later)
	*/
}

void load_kernel() {
	/* in this phase we will load the firstpart of the kernel after us in memory
	and to do that we must write a function to read inodes, we need that for
	dirs too */
}

extern "C" int bootloader()
{
	DBGSCOP();
	serial::init();
	DBG("Starting bootloader");
	gather_info();

	while (true)
		asm volatile ("nop");
	return 0;
}
