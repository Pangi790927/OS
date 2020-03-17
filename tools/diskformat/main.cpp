#include <iostream>
#include <fstream>
#include <cstdio>
#include <zlib.h>
#include "hexdump.h"
#include "mbr.h"
#include "gpt.h"
#include "ext2.h"
#include "to_str.h"
#include "crc32.h"
#include "dev_layout.h"
#include "dev.h"
#include "file.h"
#include "ext2dev.h"

#define PART_SIZE	((int)sizeof(gpt_part_t))

/* just a sector */
#define MBR_SIZE	(SECTOR_SZ)

/* header + partitions */
#define GPT_SIZE	(SECTOR_SZ + PART_SIZE * 128)

/* 1024 offset, 1 superblock, group table, 1 blk_bitmap, 1 inode bitmap,
	1 blk for 8 inodes, 8 blks for 8 data blks */
#define MIN_FS_SIZE (1024 + (1 + 1 + 1 + 1 + 9) * BLK_SIZE)
#define TOT_SIZE	(MBR_SIZE + GPT_SIZE * 2 + MIN_FS_SIZE)

void install_mbr(Dev &dev, DevLayout &layout) {
	auto mbr_code = read_file(layout.path("main_boot"));
	if (mbr_code.empty())
		mbr_code.resize(SECTOR_SZ);

	mbr_hdr_t &mbr = *(mbr_hdr_t *)dev.get_sect(0);
	mbr = *(mbr_hdr_t *)(&mbr_code[0]);

	mbr.boot_sig = 0xAA55;
	mbr.disk_sig = 0;
	mbr.zero2 = 0;

	mbr.part1 = {0};
	mbr.part1.sys_id = 0xEE;
	mbr.part1.lo_start = 1;
	mbr.part1.lo_len = dev.sect_cnt() - 1ULL > 0xFFFFFFFFULL ? 0xFFFFFFFFULL :
			dev.sect_cnt() - 1ULL;
	mbr.part2 = {0};
	mbr.part3 = {0};
	mbr.part4 = {0};

	printf("mbr: %s\n", mbr_str(mbr).c_str());
}

void install_gpt(Dev &dev, DevLayout &layout) {
	for (int i = 0; i < 128; i++) {
		memset(dev.get_sect(2 + i), 0, PART_SIZE);
	}
	gpt_hdr_t &gpt = *(gpt_hdr_t *)dev.get_sect(1);
	memset(&gpt, 0, sizeof(gpt));

	memcpy(gpt.sig, "EFI PART", 8);
	gpt.rev = 0x00010000;
	gpt.hdr_sz = 92;
	gpt.curr_lba = 1;
	gpt.backup_lba = dev.sect_cnt() - 1ULL;
	gpt.first_part_lba = (GPT_SIZE + MBR_SIZE ) / SECTOR_SZ;
	gpt.last_part_lba = dev.sect_cnt() - GPT_SIZE / SECTOR_SZ - 1;
	gpt.part_arr_lba = 2;
	gpt.part_cnt = 128;
	gpt.part_sz = PART_SIZE;

	gpt_part_t &part1 = *(gpt_part_t *)dev.get_sect(gpt.part_arr_lba);
	part1.first_lba = gpt.first_part_lba;
	part1.last_lba = gpt.last_part_lba;
	memcpy(part1.type_guid, "rand1-------16b", 16);
	memcpy(part1.uniq_guid, "rand2-------16b", 16);
	memcpy(part1.name, u"OsBoot", 16);

	memcpy(dev.get_sect(gpt.backup_lba), dev.get_sect(gpt.curr_lba),
			SECTOR_SZ);
	memcpy(dev.get_sect(gpt.last_part_lba + 1), dev.get_sect(gpt.part_arr_lba),
			gpt.part_cnt * gpt.part_sz);

	gpt_hdr_t &back_gpt = *(gpt_hdr_t *)dev.get_sect(dev.sect_cnt() - 1);
	
	back_gpt.curr_lba = gpt.backup_lba;
	back_gpt.backup_lba = gpt.curr_lba;

	gpt.part_crc = 0;
	gpt.hdr_crc = 0;
	back_gpt.hdr_crc = 0;

	gpt.part_crc = crc32(dev.get_sect(gpt.part_arr_lba),
			gpt.part_cnt * gpt.part_sz);
	back_gpt.part_crc = gpt.part_crc;

	gpt.hdr_crc = crc32(dev.get_sect(gpt.curr_lba), gpt.hdr_sz);
	back_gpt.hdr_crc = crc32(dev.get_sect(back_gpt.curr_lba), back_gpt.hdr_sz);

	printf("gpt: %s\n", gpt_str(gpt).c_str());
	printf("back gpt: %s\n", gpt_str(back_gpt).c_str());
	printf("parts: %s\n", 
			part_arr_str(dev.get_sect(gpt.part_arr_lba),
			gpt.part_cnt, gpt.part_sz).c_str());
}
/*
	TO FIX:
		- commit fcn
		- add directory support
		- lost+found ????
		- check all
*/
void install_ext2(Dev &dev, DevLayout &layout) {
	/* this depends on gpt but not on mbr */
	gpt_hdr_t &gpt = *(gpt_hdr_t *)dev.get_sect(1);
	gpt_part_t &part1 = *(gpt_part_t *)dev.get_sect(gpt.part_arr_lba);

	Ext2 ext2(dev, gpt.first_part_lba,
			gpt.last_part_lba - gpt.first_part_lba + 1);
	ext2.create_fs();

	printf("Create some usual dirs\n");
	ext2.dirs.mkdir("/", "bin");
	ext2.dirs.mkdir("/", "boot");
	ext2.dirs.mkdir("/", "dev");
	ext2.dirs.mkdir("/", "etc");
	ext2.dirs.mkdir("/etc", "init.d");
	ext2.dirs.mkdir("/etc", "net");

	printf("Create boot file(inode 5)\n");
	char boot[] = "Ana are mere multe aici";
	if (ext2.inodes.write_imutable(5, boot, sizeof(boot))) {
		printf("Can't create boot file\n");
		return ;
	}
	int boot_ino = ext2.dirs.find_rec("/boot");
	if (boot_ino < 1) {
		printf("can't find boot inode\n");
		return ;
	}
	if (ext2.dirs.add_file(boot_ino, 5, "boot.boot", EXT2_FT_DIR)) {
		printf("Can't add boot.boot to boot inode\n");
		return ;
	}

	printf("Hexdump boot:\n");
	inode_t bootino;
	if (ext2.inodes.getino(5, &bootino)) {
		printf("Failed to get boot inode\n");
		return ;
	}
	char bootbuf[bootino.size];
	if (ext2.inodes.read(5, 0, bootbuf, sizeof(bootbuf)) != sizeof(bootbuf)) {
		printf("Failed to read boot.boot\n");
		return ;
	}
	printf("boot.boot[size: %lu]: \n", sizeof(bootbuf));
	util::hexdump(bootbuf, sizeof(bootbuf));

	/* TO DO:
		- write real boot program here
		- write kernel into /boot
	 */

	printf("Listing dirs\n");
	ext2.dirs.listdir("/", [](auto& entry) {
		printf("[%3d]/%s\n", entry.ino, entry.name);
	});
	ext2.dirs.listdir("/etc", [](auto& entry) {
		printf("[%3d]/etc/%s\n", entry.ino, entry.name);
	});
	ext2.dirs.listdir("/boot", [](auto& entry) {
		printf("[%3d]/boot/%s\n", entry.ino, entry.name);
	});

	ext2.commit_backups();
	printf("Ext2: %s\n", ext2.to_string().c_str());
}

int main (int argc, char const *argv[]) try {
	if (argc < 2) {
		printf("Needs at least 1 argument: %s img_file [layout.json]\n",
				argv[0]);
		return -1;
	}

	DevLayout dev_layout(argc == 3 ? argv[2] : "dev_layout.json");
	Dev dev(argv[1]);

	if (dev.size() < TOT_SIZE) {
		printf("specified img_file is to small, needs to be at least %d bytes\n",
				TOT_SIZE);
		return -1;
	}

	install_gpt(dev, dev_layout);
	install_ext2(dev, dev_layout);
	install_mbr(dev, dev_layout);
	dev.save();

	return 0;
}
catch (std::exception& ex) {
	std::cout << "program terminated after: " << ex.what() << std::endl;
}

/*
	boot-code 0-440 bytes and prot-mbr
		-> zipped toghether in a single mbr sector
	gpt-hdr and gpt-partitions(read from config and prob 1) place on disk
		-> also place backup at end just because that crc wasn't enaugh
	-> config file for all the boot extensions and their size(will be a
			struct and a program to edit the struct)
	zip in the filesystem
		-> *
	add into the filesystem the following:
		-> important boot extensions - those will do all the job, set vesa, load
				the second stage of the kernel, etc
		-> second stage - will load the third stage from protected mode and
				with the address sent from boot

	After all this the new boot will look like so:
		- the boot sector is loaded togheter with the prot-mbr and started
		- this boot program will know where the config.boot part is
		- he will load from that all the extensions named there in ram
		- the boot sector will than also find the address(inode) of the 2 stages
		- he will execute all boot extensions and after that start prot mode
		- protected mode will transition to stage 2

	This program basically formats the disk  
*/
