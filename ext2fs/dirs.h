#ifndef DIRS_H
#define DIRS_H

#include "inodes.h"

// TO DO: change directory size to be multiple of 1024 and store fake direntry
// or at end of block, when deleting entry just increase prev entry
// TO DO: add meta-data entry at beggining of block to remember used/free space
// TO DO: implement defragmentation

/*

*/
struct dir_meta_t {
	dir_entry_t entry;
	uint32_t used_bytes;
	uint32_t freed_bytes;
	uint32_t meta_len;

	dir_meta_t() {
		meta_len = entry.rec_len;
		used_bytes = 0;
		freed_bytes = 0;
	}
} __attribute__((__packed__));

class Dirs {
public:
	Inodes &inodes;
	char blk_buff[BLK_SIZE];

	Dirs(Inodes &inodes) : inodes(inodes) {}

	int mkdir(const char *path, const char *name, int rights = EXT2_S_RMASK,
			int uid = 0, int gid = 0)
	{
		int dino = find_rec(path);
		if (dino < 1)
			dino = 2;
		int ino = inodes.create(EXT2_S_IFDIR | rights, uid, gid);
		if (ino < 1) {
			DBG("Invalid inode %d", ino);
			return -1;
		}
		if (add_file(dino, ino, name, EXT2_FT_DIR)) {
			DBG("Can't add file to dir");
			return -1;
		}
		if (add_file(ino, ino, ".", EXT2_FT_DIR)) {
			// TO DO: clear dir here
			DBG("Can't add self ref");
			return -1;
		}
		if (add_file(ino, dino, "..", EXT2_FT_DIR)) {
			DBG("Can't add parr ref");
			// TO DO: clear dir here
			return -1;
		}
		return 0;
	}

	int rmdir(const char *path, const char *name) {
		int dino = find_rec(path);
		if (dino < 1)
			return -1;
		dir_entry_t finode;
		if (find_file(dino, name, finode) <= 0) {
			DBG("didn't find file to remove");
			return -1;
		}
		if (finode.file_type != EXT2_FT_DIR) {
			DBG("file not dir: [%d]%s but %d",
					finode.ino, finode.name, finode.file_type);
			return -1;
		}
		if (count(finode.ino) != 0) {
			DBG("dir must be empty and valid");
			return -1;
		}
		if (rm_file(dino, name)) {
			DBG("couldn't remove dir '%s' from '%s'", name, path);
			return -1;
		}
		if (inodes.remove(finode.ino)) {
			DBG("couldn't remove inode %d", finode.ino);
			return -1;
		}
		return 0;
	}

	/* must be an absolute path */
	int find_rec(const char *cpath) {
		int curr_dir = 2;

		/* TO DO: fix this */
		char buff[256] = {0};
		const char *path = cpath;
		int n = 0;
		while (*path != '\0') {
			buff[n] = *path;
			path++;
			n++;
			if (n >= (int)sizeof(buff)) {
				DBG("path is too large");
				return -1;
			}
		}
		for (int i = 0; i < n; i++)
			if (buff[i] == '/')
				buff[i] = '\0';
		int i = 0;
		while (i < n) {
			if (buff[i] == '\0') {
				i++;
				continue;
			}
			dir_entry_t aux;
			if ((curr_dir = find_file(curr_dir, buff + i, aux)) < 1)
				return -1;
			while (buff[i] != '\0')
				i++;
		}
		return curr_dir;
	}

	int count(int dino) {
		int i = 0;
		if (listdir(dino, [&i](auto&) { i++; }))
			return -1;
		return i - 2;
	}

	template <typename Fn>
	int listdir(const char *path, Fn&& fn) {
		int dino = find_rec(path);
		if (dino < 0)
			return -1;
		return listdir(dino, fn);
	}

	bool match_entry_name(const char *entry_name, int len, const char *name) {
		int i = 0;
		for (i = 0; i < len; i++)
			if (entry_name[i] != name[i])
				return false;
		return name[i] == '\0';
	}

	int init_dir_meta(int ino) {
		if (inodes.truncate(ino, BLK_SIZE) != 0) {
			DBG("Can't truncate file: %d", ino);
			return -1;
		}
		
		dir_meta_t *meta_dir = (dir_meta_t *)blk_buff;
		dir_entry_t *entry = (dir_entry_t *)(blk_buff + sizeof(dir_entry_t));
		*meta_dir = dir_meta_t{};
		*entry = dir_entry_t{};
		entry->rec_len = BLK_SIZE - sizeof(dir_meta_t); 

		if (inodes.write(ino, 0, blk_buff, BLK_SIZE) < BLK_SIZE) {
			DBG("Can't init dir meta: %d", ino);
			return -1;
		}
		return 0;
	}

	int defragment() {

	}

	template <typename Fn>
	int listdir(int dino, Fn&& fn) {
		dir_entry_t entry;
		inode_t dinode;
		int off = 0;
		if (dino <= 0)
			return -1;
		if (inodes.getino(dino, &dinode))
			return -1;
		if (dinode.size < BLK_SIZE)
			return 0;
		while (off < dinode.size) {
			if (inodes.read(dino, off, blk_buff, BLK_SIZE) < BLK_SIZE) {
				return -1;
			}
			off += BLK_SIZE;
			int rec_off = 0;
			while (len < BLK_SIZE) {
				dir_entry_t *entry = (dir_entry_t *)(blk_buff + rec_off);
				if (entry->ino)
					fn(*entry);
				rec_off += entry->rec_len;
			}
		}
		return 0;
	}

	int find_file(int dino, const char *name, dir_entry_t &res) {
		dir_entry_t entry;
		inode_t dinode;
		int off = 0;
		if (inodes.getino(dino, &dinode))
			return -1;
		if (dinode.size < sizeof(dir_entry_t))
			return -1;
		while (true) {
			if (inodes.read(dino, off, (char *)&entry, sizeof(entry))
					< (int)sizeof(entry))
			{
				DBG("can't read entry: off[%d] ino[%d]", off, dino);
				return -1;
			}
			
			if (match_entry_name((char *)entry.name, entry.name_len, name)) {
				res = entry;
				return entry.ino;
			}
			if (off + entry.next + sizeof(dir_entry_t) > dinode.size) {
				return -1;
			}
			off += entry.next;
		}
	}

	int add_file(int dino, int fino, const char *name, int file_type) {
		inode_t dinode;
		if (dino < 1) {
			return -1;
		}
		if (inodes.getino(dino, &dinode)) {
			DBG("Can't read dir inode");
			return -1;
		}
		if (!(dinode.mode & EXT2_S_IFDIR)) {
			DBG("Can only add entryes to dir inodes: %x", dinode.mode);
			return -1;
		}
		dir_entry_t temp;
		if (find_file(dino, name, temp) > 0) {
			DBG("name taken: %s", name);
			return -1;
		}
		dir_entry_t dirent;
		dirent.ino = fino;
		dirent.next = sizeof(dir_entry_t);
		dirent.name_len = strlen(name);
		dirent.file_type = file_type;
		if (dirent.name_len > sizeof(dirent.name) + 1) {
			DBG("File name to large");
			return -1;
		}
		memmove((char *)dirent.name, name, strlen(name) + 1);
		if (dinode.size < sizeof(dir_entry_t)) {
			if (inodes.truncate(dino, sizeof(dir_entry_t))) {
				DBG("Can't truncate dir");
				return -1;
			}
			if (inodes.write(dino, 0, (char *)&dirent, sizeof(dirent)) <
					(int)sizeof(dir_entry_t))
			{
				DBG("Can't write new entry");
				return -1;
			}
			if (inodes.mod_links(fino, 1)) {
				/* should reverse add process or try more times */
				DBG("Con't modify the number of links to inode");
				return -1;
			}
			return 0;
		}
		int off = 0;
		while (true) {
			dir_entry_t entry;
			if (inodes.read(dino, off, (char *)&entry, sizeof(entry)) <
					(int)sizeof(entry))
			{
				DBG("Can't read entry at offset %d", off);
				return -1;
			}
			if (entry.next >= 2 * sizeof(dir_entry_t)) {
				dirent.next = entry.next - sizeof(dir_entry_t);
				entry.next = sizeof(dir_entry_t);
				if (inodes.write(dino, off, (char *)&entry, sizeof(entry)) <
						(int)sizeof(dir_entry_t))
				{
					DBG("Can't modify entry");
					return -1;
				}
				if (inodes.write(dino, off + sizeof(dir_entry_t),
						(char *)&dirent, sizeof(dirent))
						< (int)sizeof(dir_entry_t))
				{
					DBG("Can't write new entry");
					return -1;
				}
				if (inodes.mod_links(fino, 1)) {
					/* should reverse add process or try more times */
					DBG("Con't modify the number of links to inode");
					return -1;
				}
				return 0;
			}
			if (off + entry.next + sizeof(dir_entry_t) > dinode.size) {
				if (inodes.truncate(dino, dinode.size + sizeof(dir_entry_t))) {
					DBG("Can't truncate");
					return -1;
				}
				if (inodes.write(dino, off + sizeof(dir_entry_t),
						(char *)&dirent, sizeof(dirent))
						< (int)sizeof(dir_entry_t))
				{
					DBG("Can't write new entry");
					return -1;
				}
				if (inodes.mod_links(fino, 1)) {
					/* should reverse add process or try more times */
					DBG("Con't modify the number of links to inode");
					return -1;
				}
				return 0;
			}
			off = off + entry.next;
			if (entry.next < sizeof(dir_entry_t))
				EXCEPTION("can't have a dirent so small");
		}
	}

	int rm_file(int dino, const char *name) {
		dir_entry_t entry;
		inode_t dinode;
		int off = 0;
		if (inodes.getino(dino, &dinode))
			return -1;
		if (dinode.size < sizeof(dir_entry_t))
			return -1;
		while (true) {
			if (inodes.read(dino, off, (char *)&entry, sizeof(entry)) <
					(int)sizeof(entry))
			{
				return -1;
			}
			if (match_entry_name((char *)entry.name, entry.name_len, name)) {
				if (off + entry.next + sizeof(dir_entry_t) > dinode.size) {
					if (inodes.truncate(dino, off)) {
						DBG("Can't truncate for remove");
						return -1;
					}
					if (inodes.mod_links(entry.ino, -1)) {
						/* should reverse add process or try more times */
						DBG("Con't modify the number of links to inode");
						return -1;
					}
					return 0;
				}
				dir_entry_t to_move;
				if (inodes.read(dino, off + entry.next,
						(char *)&to_move, sizeof(to_move))
						< (int)sizeof(to_move))
				{
					return -1;
				}
				to_move.next = to_move.next + entry.next;
				if (off + to_move.next + sizeof(dir_entry_t) > dinode.size) {
					to_move.next = sizeof(dir_entry_t);
					if (inodes.truncate(dino, off + sizeof(dir_entry_t))) {
						DBG("Can't truncate for remove");
						return -1;
					}
				}
				if (inodes.write(dino, off, (char *)&to_move,
						sizeof(to_move)) < (int)sizeof(to_move))
				{
					return -1;
				}
				if (inodes.mod_links(entry.ino, -1)) {
					/* should reverse add process or try more times */
					DBG("Con't modify the number of links to inode");
					return -1;
				}
				return 0;
			}
			if (off + entry.next + sizeof(dir_entry_t) > dinode.size) {
				return -1;
			}
			off += entry.next;
		}
	}
};

#endif