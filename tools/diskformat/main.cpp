#include <iostream>
#include <fstream>
#include <cstdio>
#include <zlib.h>
#include "hexdump.h"
#include "mbr.h"
#include "gpt.h"
#include "to_str.h"
#include "crc32.h"
#include "dev_layout.h"
#include "dev.h"
#include "file.h"
#include "ext2.h"
#include "file_prov_dev.h"

#define PART_SIZE	((int)sizeof(gpt_part_t))

/* just a sector */
#define MBR_SIZE	(LBA_SZ)

/* header + partitions */
#define GPT_SIZE	(LBA_SZ + PART_SIZE * 128)

/* 1024 offset, 1 superblock, group table, 1 blk_bitmap, 1 inode bitmap,
	1 blk for 8 inodes, 8 blks for 8 data blks */
#define MIN_FS_SIZE (1024 + (1 + 1 + 1 + 1 + 9) * BLK_SIZE)
#define TOT_SIZE	(MBR_SIZE + GPT_SIZE * 2 + MIN_FS_SIZE)

using MbrDev = Dev<LBA_SZ>;
using GptDev = Dev<LBA_SZ>;

// char ext2_grp_cache[128 * sizeof(blk_grp_desc_t)];
// char ext2_map_cache[256 * sizeof(Bitmap)];
char part_cache[128 * PART_SIZE];
char dev_cache[LBA_SZ * 64];
uint32_t cache_size = sizeof(dev_cache);
uint16_t boot_lba = 0;
uint16_t boot_lba_cnt = 0;

void install_mbr(FileProvDev &file_dev, DevLayout &layout) {
	MbrDev mbr_dev(file_dev.get_if(), 0, 1, dev_cache, cache_size);

	auto mbr_code = read_file(layout.path("src_path", "mbr_boot"));
	if (mbr_code.empty())
		mbr_code.resize(LBA_SZ);

	auto sect = mbr_dev.get_sect(0);
	mbr_hdr_t &mbr = *(mbr_hdr_t *)sect.get();
	mbr = *(mbr_hdr_t *)(&mbr_code[0]);

	mbr.boot_sig = 0xAA55;
	mbr.disk_sig = 0;
	mbr.zero2 = 0;

	mbr.part1 = {0};
	mbr.part1.sys_id = 0xEE;
	mbr.part1.lo_start = 1;
	mbr.part1.lo_len = file_dev.lba_size() - 1ULL > 0xFFFFFFFFULL ?
			0xFFFFFFFFULL : file_dev.lba_size() - 1ULL;
	mbr.part2 = {0};
	mbr.part3 = {0};
	mbr.part4 = {0};

	// mbr.opts.boot_drive = 0;
	mbr.opts.boot_start = boot_lba;
	mbr.opts.boot_size = boot_lba_cnt;
	mbr.opts.boot_addr = 0x7e00;

	// printf("mbr: %s\n", mbr_str(mbr).c_str());
	sect.save(true);
}

void install_gpt(FileProvDev &file_dev, DevLayout &layout) {
	GptDev gpt_dev(file_dev.get_if(), 0, file_dev.lba_size(),
			dev_cache, cache_size);
	
	for (int i = 0; i < 128 / (LBA_SZ / PART_SIZE); i++) {
		auto sect = gpt_dev.get_sect(2 + i);
		memset(sect.get(), 0, LBA_SZ);
		sect.save(true);
	}
	auto gpt_sect = gpt_dev.get_sect(1);
	gpt_hdr_t &gpt = *(gpt_hdr_t *)gpt_sect.get();
	memset(&gpt, 0, sizeof(gpt));

	memcpy(gpt.sig, "EFI PART", 8);
	gpt.rev = 0x00010000;
	gpt.hdr_sz = 92;
	gpt.curr_lba = 1;
	gpt.backup_lba = file_dev.lba_size() - 1ULL;
	gpt.first_part_lba = (GPT_SIZE + MBR_SIZE ) / LBA_SZ;
	gpt.last_part_lba = file_dev.lba_size() - GPT_SIZE / LBA_SZ - 1;
	gpt.part_arr_lba = 2;
	gpt.part_cnt = 128;
	gpt.part_sz = PART_SIZE;

	auto part1_sect = gpt_dev.get_sect(gpt.part_arr_lba);
	gpt_part_t &part1 = *(gpt_part_t *)part1_sect.get();
	part1.first_lba = gpt.first_part_lba;
	part1.last_lba = gpt.last_part_lba;
	memcpy(part1.type_guid, "rand1-------16b", 16);
	memcpy(part1.uniq_guid, "rand2-------16b", 16);
	memcpy(part1.name, u"OsBoot", 16);

	auto backup_sect = gpt_dev.get_sect(gpt.backup_lba);
	memcpy(backup_sect.get(), gpt_sect.get(), LBA_SZ);

	for (int i = 0; i < 128 / (LBA_SZ / PART_SIZE); i++) {
		auto sect = gpt_dev.get_sect(gpt.part_arr_lba + i);
		auto back_sect = gpt_dev.get_sect(gpt.last_part_lba + 1 + i);
		memcpy(back_sect.get(), sect.get(), LBA_SZ);
		back_sect.save(true);
		sect.unload();
	}

	gpt_hdr_t &back_gpt = *(gpt_hdr_t *)backup_sect.get();
	
	back_gpt.curr_lba = gpt.backup_lba;
	back_gpt.backup_lba = gpt.curr_lba;

	gpt.part_crc = 0;
	gpt.hdr_crc = 0;
	back_gpt.hdr_crc = 0;


	for (int i = 0; i < 128 / (LBA_SZ / PART_SIZE); i++) {
		auto sect = gpt_dev.get_sect(gpt.part_arr_lba + i);
		memcpy(part_cache + i * LBA_SZ, sect.get(), LBA_SZ);
		sect.unload();
	}
	gpt.part_crc = crc32(part_cache, gpt.part_cnt * gpt.part_sz);
	back_gpt.part_crc = gpt.part_crc;

	gpt.hdr_crc = crc32(gpt_sect.get(), gpt.hdr_sz);
	back_gpt.hdr_crc = crc32(backup_sect.get(), back_gpt.hdr_sz);

	// printf("gpt: %s\n", gpt_str(gpt).c_str());
	// printf("back gpt: %s\n", gpt_str(back_gpt).c_str());
	// printf("part1: %s\n", 
	// 		part_arr_str((uint8_t *)part1_sect.get(), 1, gpt.part_sz).c_str());

	backup_sect.save(true);
	part1_sect.save(true);
	gpt_sect.save(true);
}

int install_boot(Ext2 &ext2, DevLayout &layout) {
	int bootloader_ino = ext2.inodes.create(EXT2_S_IFREG | EXT2_S_RMASK, 0, 0);
	if (bootloader_ino <= 0) {
		printf("can't create bootloader file\n");
		return -1;
	}
	printf("bootload ino: %d\n", bootloader_ino);

	auto bootloader_code = read_file(layout.path("src_path", "bootloader"));
	if (bootloader_code.size() == 0) {
		printf("empty bootloader\n");
		return -1;
	}
	if (bootloader_code.size() % LBA_SZ != 0)
		bootloader_code.resize(roundup(bootloader_code.size(), LBA_SZ));

	if (ext2.inodes.write_imutable(bootloader_ino, (char *)&bootloader_code[0],
			bootloader_code.size()))
	{
		printf("Can't write bootloader file\n");
		return -1;
	}

	inode_t bootloader_inode;
	if (ext2.inodes.getino(bootloader_ino, &bootloader_inode) < 0) {
		printf("Can't get bootloader inode info\n");
		return -1;
	}

	if (bootloader_inode.size == 0 || bootloader_inode.block[0] == 0) {
		printf("Invalid bootloader inode size %d\n", bootloader_inode.size);
		return -1;
	}

	boot_lba = bootloader_inode.block[0] * (BLK_SIZE / LBA_SZ);
	boot_lba_cnt = bootloader_inode.size * (BLK_SIZE / LBA_SZ);

	std::string bootloader_path = layout.path("dst_path", "bootloader");
	std::string bootconf_path = layout.path("dst_path", "bootconf");

	int bootdir_ino = ext2.dirs.find_rec("/boot");
	if (bootdir_ino < 1) {
		printf("can't find boot inode\n");
		return -1;
	}

	if (ext2.dirs.add_file(bootdir_ino, bootloader_ino,
			bootloader_path.c_str()))
	{
		printf("Can't add %s to boot inode\n", bootloader_path.c_str());
		return -1;
	}

	int bootconf_ino = ext2.inodes.create(EXT2_S_IFREG | EXT2_S_RMASK, 0, 0);
	if (bootconf_ino <= 0) {
		printf("can't create boot config\n");
		return -1;
	}

	auto bootconfig = read_config(layout.path("src_path", "bootconf"));
	if (bootconfig.size() >= BLK_SIZE) {
		printf("boot config must be max %d bytes\n", BLK_SIZE);
		return -1;
	}
	bootconfig.resize(BLK_SIZE, 0);

	if (ext2.inodes.write(bootconf_ino, 0, (char *)&bootconfig[0], BLK_SIZE)
			!= BLK_SIZE)
	{
		printf("Failed to write boot config\n");
		return -1;
	}

	int ret = ext2.dirs.add_file(bootdir_ino, bootconf_ino,
			bootconf_path.c_str());
	if (ret < 0) {
		printf("can't add boot config in boot directory\n");
		return -1;
	}

	inode_t bootconf_inode;
	if (ext2.inodes.getino(bootconf_ino, &bootconf_inode)) {
		printf("Failed to get conf inode\n");
		return -1;
	}
	char confbuf[BLK_SIZE];
	if (ext2.inodes.read(bootconf_ino, 0, confbuf, sizeof(confbuf))
			!= sizeof(confbuf))
	{
		printf("Failed to read boot config\n");
		return -1;
	}
	printf("config: [size: %lu]: %s\n", sizeof(confbuf), confbuf);

	/* TO DO:
		- write kernel into /boot
	 */
	return 0;
}

/*
	TO FIX:
		- commit fcn
		- add directory support
		- lost+found ????
		- check all
*/
void install_ext2(FileProvDev &file_dev, DevLayout &layout) {
	/* this depends on gpt but not on mbr */
	GptDev gpt_dev(file_dev.get_if(), 0, file_dev.lba_size(),
			dev_cache, cache_size);
	auto gpt_sect = gpt_dev.get_sect(1);
	gpt_hdr_t &gpt = *(gpt_hdr_t *)gpt_sect.get();

	uint32_t first_lba = gpt.first_part_lba;
	uint32_t lba_cnt = gpt.last_part_lba - gpt.first_part_lba + 1;
	gpt_sect.unload();

	ExtDev ext_dev(file_dev.get_if(), first_lba, lba_cnt,
			dev_cache, cache_size);
	Ext2 ext2(ext_dev, lba_cnt / (BLK_SIZE / LBA_SZ));
	
	printf("Installling ext2 from: %dlba to: %dlba\n",
			first_lba, first_lba + lba_cnt);
	if (ext2.init() != 0) {
		printf("Can't init ext2\n");
		return ;
	}
	if (ext2.create_fs() != 0) {
		printf("Can't create ext2 fs\n");
		return ;
	}

	printf("Create some usual dirs\n");
	ext2.dirs.mkdir("/", "bin");
	ext2.dirs.mkdir("/", "boot");
	ext2.dirs.mkdir("/", "dev");
	ext2.dirs.mkdir("/", "etc");
	ext2.dirs.mkdir("/", "usr");
	ext2.dirs.mkdir("/", "home");

	ext2.dirs.mkdir("/etc", "init.d");
	ext2.dirs.mkdir("/etc", "net");
	ext2.dirs.mkdir("/etc", "vesa");

	if (ext2.dirs.add_file(2, 11, "lost+found")) {
		printf("Can't add lost+found to root inode\n");
		return ;
	}

	if (install_boot(ext2, layout) < 0) {
		printf("couldn't install boot data\n");
		return ;
	}

	printf("Listing dirs\n");
	ext2.dirs.listdir("/", [](auto& entry, int, int) {
		printf("[%3d]/%s\n", entry.ino, entry.name);
		return 0;
	});
	ext2.dirs.listdir("/etc", [](auto& entry, int, int) {
		printf("[%3d]/etc/%s\n", entry.ino, entry.name);
		return 0;
	});
	ext2.dirs.listdir("/boot", [](auto& entry, int, int) {
		printf("[%3d]/boot/%s\n", entry.ino, entry.name);
		return 0;
	});

	ext2.commit_backups();
	// printf("Ext2: %s\n", ext2.to_string().c_str());
	ext2.uninit();
}

int main (int argc, char const *argv[]) try {
	if (argc < 2) {
		printf("Needs at least 1 argument: %s img_file [layout.json]\n",
				argv[0]);
		return -1;
	}

	DevLayout dev_layout(argc == 3 ? argv[2] : "dev_layout.json");
	FileProvDev file_dev(argv[1]);

	if (file_dev.lba_size() * LBA_SZ < TOT_SIZE) {
		printf("specified img_file is to small, needs to be at least %d bytes\n",
				TOT_SIZE);
		return -1;
	}

	install_gpt(file_dev, dev_layout);
	install_ext2(file_dev, dev_layout);
	install_mbr(file_dev, dev_layout);
	file_dev.save();

	return 0;
}
catch (std::exception& ex) {
	std::cout << "program terminated after: " << ex.what() << std::endl;
}

/*
		bellow is old: 
	boot-code (400 bytes) + mbr_opts (40) + prot-mbr (rest)
		-> zipped toghether in a single mbr sector
	gpt-hdr and gpt-partitions(read from config and prob 1) place on disk
		-> also place backup at end just because that crc wasn't enough
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
