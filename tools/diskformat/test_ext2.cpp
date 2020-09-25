#include <iostream>
#include "hexdump.h"
#include "dev.h"
#include "file.h"
#include "ext2.h"
#include "file_prov_dev.h"

int main(int argc, char const *argv[])
{
	if (argc != 2) {
		printf("Wrong number of arguments, usage : %s fs_image\n", argv[0]);
		return -1;
	}
	printf("fs_file: %s\n", argv[1]);

	char cache[LBA_SZ * 64];
	uint32_t cache_sz = sizeof(cache);

	FileProvDev file_dev(argv[1]);
	ExtDev ext_dev(file_dev.get_if(), 0, file_dev.lba_size(), cache, cache_sz);
	Ext2 ext2(ext_dev, file_dev.lba_size() / (BLK_SIZE / LBA_SZ));

	if (ext2.init() != 0) {
		printf("Can't init ext2\n");
		return -1;
	}

	for (int i = 1; i <= 11; i++) {
		inode_t inode;
		if (ext2.inodes.getino(i, &inode) != 0) {
			printf("Can't getino: %d\n", i);
			return -1;
		}
		printf("ino: %d mode: %x uid: %d size: %d dtime: %d\n",
				i, inode.mode, inode.uid, inode.size, inode.dtime);
	}

	// uint16_t mode;
	// uint16_t uid;
	// uint32_t size;
	// uint32_t atime;
	// uint32_t ctime;
	// uint32_t mtime;
	// uint32_t dtime;
	// uint16_t gid;
	// uint16_t links_cnt;
	// uint32_t bsize;
	// uint32_t flags;
	// uint8_t osd1[4];
	// uint32_t block[15];
	// uint32_t generation;
	// uint32_t file_acl;
	// uint32_t dir_acl;
	// uint32_t faddr;
	// uint8_t osd2[12];

	printf("/boot: %d\n", ext2.dirs.find_rec("/boot"));

	int sample_ino = ext2.dirs.find_rec("/a_sample_0.txt");
	if (sample_ino <= 0) {
		printf("Can't find a_sample_0.txt\n");
		return -1;
	}

	inode_t sample_inode;
	if (ext2.inodes.getino(sample_ino, &sample_inode) < 0) {
		printf("can't get inode: %d\n", sample_ino);
		return -1;
	}

	char content[80];
	if (ext2.inodes.read(sample_ino, 0, content, sample_inode.size) <
			sample_inode.size)
	{
		printf("can't read inode: %d\n", sample_ino);
		return -1;
	}

	printf("a_sample_0: ino: %d size: %d content: %s",
			sample_ino, sample_inode.size, content);

	int ret = ext2.dirs.listdir("/", [](auto& entry, int, int) {
		char name[256];
		memcpy(name, entry.name, entry.name_len);
		name[entry.name_len] = 0;
		printf("[%3d]/%s\n", entry.ino, name);
		return 0;
	});
	if (ret != 0) {
		printf("error listsing dir %d\n", ret);
		return -1;
	}
	ret = ext2.dirs.listdir("/boot", [](auto& entry, int, int) {
		char name[256];
		memcpy(name, entry.name, entry.name_len);
		name[entry.name_len] = 0;
		printf("[%3d]/boot/%s\n", entry.ino, name);
		return 0;
	});

	if (ret != 0) {
		printf("error listsing dir %d\n", ret);
		return -1;
	}

	ext2.uninit();

	return 0;
}