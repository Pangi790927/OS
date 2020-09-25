#ifndef DIRS_H
#define DIRS_H

#include "inodes.h"

// TO DO: change directory size to be multiple of 1024 and store fake direntry
// or at end of block, when deleting entry just increase prev entry

/*
	* a directory is made out of blocks, it needs to have at least one block,
	for '.' and '..'
	* in those blocks you find multiple dir_entry_t one after another
	add_entry:
		* iterate all entryes to find one that has more space than just for
		itself and for the new entry. modify entry and add new entry over it
		example:
			old block: [entry1, size 20][entry2, size 1004] 
			new block: [entry1, size 20][entry2, size 20][entry3, size 984] 
		* if you can't find any space, just add another block and initialize
		it with an empty entry
	rm_entry:
		* iterate all entryes to find the entry that must be removed
		* if found, merge it with the previus entry, if there is no prev entry
		mark the entry to be removed as unused
		* if the resulting entry is unused and spans the entire block, read
		the last block of the directory, write it over this one and truncate
		the file to it's size minus one block
*/

/*
[40282.850063]
EXT4-fs error (device loop10):
ext4_readdir:235:
inode #16: block 71: comm git_thread:
path /home/pangi/OS/tools/diskformat/mount_point/usr: 
bad entry in directory: rec_len % 4 != 0 -
		offset=0, inode=116, rec_len=117, name_len=0, size=1024

*/

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
		if (init_dir(ino) < 0) {
			DBG("can't init dir_path: %s dir_name: %s ino %d", path, name, ino);
			return -1;
		}
		if (add_file(dino, ino, name)) {
			DBG("Can't add file to dir");
			return -1;
		}
		if (add_file(ino, ino, ".")) {
			// TO DO: clear dir here
			DBG("Can't add self ref");
			return -1;
		}
		if (add_file(ino, dino, "..")) {
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
		dir_entry_t fentry;
		if (find_file(dino, name, fentry) <= 0) {
			DBG("didn't find file to remove");
			return -1;
		}
		inode_t finode;
		if (inodes.getino(fentry.ino, &finode) != 0) {
			DBG("Can't get file '%s' inode: %d", name, fentry.ino);
			return -1;
		}
		if (!(finode.mode & EXT2_S_IFDIR)) {
			DBG("file not dir: [%d]%s but %x",
					fentry.ino, fentry.name, finode.mode);
			return -1;
		}
		if (count(fentry.ino) != 0) {
			DBG("dir must be empty and valid");
			return -1;
		}
		if (rm_file(dino, name)) {
			DBG("couldn't remove dir '%s' from '%s'", name, path);
			return -1;
		}
		if (inodes.remove(fentry.ino)) {
			DBG("couldn't remove inode %d", fentry.ino);
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
		if (listdir(dino, [&i](auto&, int, int) { i++; return 0; }))
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

	static bool match_entry_name(const char *ename, int len, const char *name) {
		int i = 0;
		for (i = 0; i < len; i++)
			if (ename[i] != name[i])
				return false;
		return name[i] == '\0';
	}

	int find_file(int dino, const char *name, dir_entry_t &res) {
		int ret = listdir(dino, [name, &res](auto &entry, int, int){
			if (match_entry_name((char *)entry.name, entry.name_len, name)) {
				res = entry;
				return (int)entry.ino;
			}
			return 0;
		});
		if (ret <= 0)
			return -1;
		return ret;
	}

	int init_dir(int ino) {
		if (inodes.truncate(ino, BLK_SIZE) != 0) {
			DBG("Can't truncate file: %d", ino);
			return -1;
		}
		
		memset(blk_buff, 0, BLK_SIZE);
		dir_entry_t *entry = (dir_entry_t *)(blk_buff);
		*entry = dir_entry_t{};
		entry->rec_len = BLK_SIZE; 

		if (inodes.write(ino, 0, blk_buff, BLK_SIZE) < BLK_SIZE) {
			DBG("Can't init dir: %d", ino);
			return -1;
		}
		return 0;
	}

	template <typename Fn>
	int listdir(int dino, Fn&& fn) {
		inode_t dinode;
		if (dino <= 0)
			return -1;
		if (inodes.getino(dino, &dinode))
			return -1;
		if (dinode.size < BLK_SIZE)
			return 0;
		int off = 0;
		int blk = 0;
		while (off < (int)dinode.size) {
			if (inodes.read(dino, off, blk_buff, BLK_SIZE) < BLK_SIZE) {
				return -1;
			}
			int rec_off = 0;
			while (rec_off < BLK_SIZE) {
				dir_entry_t *entry = (dir_entry_t *)(blk_buff + rec_off);

				// char buff[256] = {0};
				// memcpy(buff, entry->name, entry->name_len);
				// printf("entry name: '%s' rec_len: %d\n", buff, entry->rec_len);

				int ret;
				if ((ret = fn(*entry, blk, rec_off)) != 0)
					return ret;
				rec_off += entry->rec_len;
			}
			off += BLK_SIZE;
			blk++;
		}
		return 0;
	}

	int add_file(int dino, int fino, const char *name) {
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

		char dir_buff[256];
		dir_entry_t *dirent = (dir_entry_t *)dir_buff;
		dirent->ino = fino;
		dirent->name_len = strlen(name);
		dirent->rec_len = roundup(sizeof(dir_entry_t) + dirent->name_len, 4);
		if (dirent->rec_len > sizeof(dir_buff)) {
			DBG("File name to large");
			return -1;
		}
		memmove((char *)dirent->name, name, strlen(name) + 1);

		int last_blk = 0;
		int ret = listdir(dino, [&](auto entry, int blk, int rel_off) {
			last_blk = 0;
			int min_sz = roundup(entry.name_len + sizeof(dir_entry_t), 4) +
					dirent->rec_len;
			if (entry.rec_len >= min_sz) {
				/* add dirent after found entry or replace it if entry is
				unused */
				/* obs: we can use blk_buff again here because we will return
				after this, without continuing the iteration */
				int off = blk * BLK_SIZE;
				if (inodes.read(dino, off, blk_buff, BLK_SIZE) < BLK_SIZE) {
					DBG("Can't read block: %d ino: %d", blk, dino);
					return -1;
				}
				dir_entry_t *oth = (dir_entry_t *)(blk_buff + rel_off);
				if (oth->ino == 0) {
					int dir_rec_len = dirent->rec_len;
					dirent->rec_len = oth->rec_len;
					memcpy(blk_buff + rel_off, dir_buff, dir_rec_len);
				}
				else {
					int oth_rec_len = oth->rec_len;
					int dir_rec_len = dirent->rec_len;
					oth->rec_len =
							roundup(oth->name_len + sizeof(dir_entry_t), 4);
					dirent->rec_len = oth_rec_len - oth->rec_len;
					memcpy(blk_buff + rel_off + oth->rec_len, dir_buff,
							dir_rec_len);
				}

				if (inodes.write(dino, off, blk_buff, BLK_SIZE) < BLK_SIZE) {
					DBG("Can't read block: %d ino: %d", blk, dino);
					return -1;
				}
				return 1;
			}
			return 0;
		});
		if (ret < 0)
			return -1;
		if (ret == 0) {
			// couldn't find entry to mod so we need to add another block
			if (inodes.truncate(dino, dinode.size + BLK_SIZE) != 0) {
				DBG("Can't truncate file: %d", dino);
				return -1;
			}
			memset(blk_buff, 0, BLK_SIZE);
			memcpy(blk_buff, dir_buff, dirent->rec_len);
			dirent->rec_len = BLK_SIZE;
			int off = (last_blk + 1) * BLK_SIZE;
			if (inodes.write(dino, off, blk_buff, BLK_SIZE) < BLK_SIZE) {
				DBG("Can't init block: %d ino: %d", last_blk + 1, dino);
				return -1;
			}
		}
		if (inodes.mod_links(fino, 1)) {
			/* should reverse add process or try more times */
			DBG("Con't modify the number of links to inode");
			return -1;
		}
		return 0;
	}

	int rm_file(int dino, const char *name) {
		inode_t dinode;
		if (inodes.getino(dino, &dinode))
			return -1;
		if (dinode.size < sizeof(dir_entry_t))
			return -1;

		dir_entry_t entry;
		int target_blk = -1;
		int target_off = -1;
		int last_blk = -1;
		int last_off = -1;
		int fino = listdir(dino, [&](auto &ent, int blk, int rel_off) {
			if (match_entry_name((char *)ent.name, ent.name_len, name)) {
				if (last_blk != target_blk)
					last_off = -1;
				target_blk = blk;
				target_off = rel_off;
				entry = ent;
				return (int)ent.ino;
			}
			last_blk = blk;
			last_off = rel_off;
			return 0;
		});
		if (fino <= 0) {
			DBG("Can't find file: %s in dirino: %d", name, dino);
			return -1;
		}
		int blk_off = target_blk * BLK_SIZE;
		if (inodes.read(dino, blk_off, blk_buff, BLK_SIZE) < BLK_SIZE) {
			DBG("Can't read block: %d ino: %d", target_blk, dino);
			return -1;
		}
		dir_entry_t *final_ent = NULL;
		if (last_off != -1) {
			/* in this case the prev entry can be expanded over the removed
			entry */
			final_ent = (dir_entry_t *)(blk_buff + last_off);
			final_ent->rec_len += entry.rec_len;
		}
		else {
			/* can't merge removed entry with another one. */
			final_ent = (dir_entry_t *)(blk_buff + target_off);
			if (target_off != 0)
				DBG("target_off is not 0: %d", target_off);
			final_ent->ino = 0;
		}
		bool should_truncate = false;
		if (final_ent->ino == 0 && final_ent->rec_len == BLK_SIZE) {
			/* must delete block if empty after removal. we do that by
			moving the last block instead of this one */
			int last_blk = dinode.size / BLK_SIZE - 1;
			int end_off = last_blk * BLK_SIZE;
			if (inodes.read(dino, end_off, blk_buff, BLK_SIZE) < BLK_SIZE) {
				DBG("Can't read block: %d ino: %d", last_blk, dino);
				return -1;
			}
			should_truncate = true;
		}
		if (inodes.write(dino, blk_off, blk_buff, BLK_SIZE) < BLK_SIZE) {
			DBG("Can't read block: %d ino: %d", last_blk, dino);
			return -1;
		}
		if (should_truncate) {
			if (inodes.truncate(dino, dinode.size - BLK_SIZE) != 0) {
				DBG("Can't truncate file: %d", dino);
				return -1;
			}
		}
		if (inodes.mod_links(fino, -1)) {
			/* should reverse add process or try more times */
			DBG("Con't modify the number of links to inode");
			return -1;
		}
		inode_t finode;
		if (inodes.getino(fino, &finode))
			return -1;
		if (finode.links_cnt == 0) {
			/* we delete inodes that have no links */ 
			return inodes.remove(fino);
		}
		return 0;
	}
};

#endif