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

	printf("/boot: %d\n", ext2.dirs.find_rec("/boot"));

	int sample_ino = ext2.dirs.find_rec("/a_sample_0.txt");

	inode_t sample_inode;
	ext2.inodes.getino(sample_ino, &sample_inode);

	char content[80];
	ext2.inodes.read(sample_ino, 0, content, sample_inode.size);

	printf("a_sample_0: ino: %d size: %d content: %s",
			sample_ino, sample_inode.size, content);

	ext2.dirs.listdir("/", [](auto& entry) {
		char name[256];
		memcpy(name, entry.name, entry.name_len);
		name[entry.name_len] = 0;
		printf("[%3d]/%s\n", entry.ino, name);
	});
	ext2.dirs.listdir("/boot", [](auto& entry) {
		char name[256];
		memcpy(name, entry.name, entry.name_len);
		name[entry.name_len] = 0;
		printf("[%3d]/boot/%s\n", entry.ino, name);
	});

	ext2.uninit();

	return 0;
}