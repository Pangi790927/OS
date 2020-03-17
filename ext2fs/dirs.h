#ifndef DIRS_H
#define DIRS_H

#include "inodes.h"

struct dir {
	int ino;
	dir_entry_t dirent;
};

inline std::vector<std::string> split(const char *str, char c = ' ')
{
	std::vector<std::string> result;

	do {
		const char *begin = str;
		while(*str != c && *str)
			str++;
		result.push_back(std::string(begin, str));
	} while (0 != *str++);

	return result;
}

class Dirs {
public:
	Inodes &inodes;

	Dirs(Inodes &inodes) : inodes(inodes) {}

	int mkdir(const char *path, const char *name, int rights = EXT2_S_RMASK,
			int uid = 0, int gid = 0)
	{
		int dino = find_rec(path);
		if (dino < 1)
			dino = 2;
		int ino = inodes.create(EXT2_S_IFDIR | rights, uid, gid);
		if (ino < 1) {
			printf("Invalid inode %d\n", ino);
			return -1;
		}
		if (add_file(dino, ino, name, EXT2_FT_DIR)) {
			printf("Can't add file to dir\n");
			return -1;
		}
		if (add_file(ino, ino, ".", EXT2_FT_DIR)) {
			// TO DO: clear dir here
			printf("Can't add self ref\n");
			return -1;
		}
		if (add_file(ino, dino, "..", EXT2_FT_DIR)) {
			printf("Can't add parr ref\n");
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
			printf("didn't find file to remove\n");
			return -1;
		}
		if (finode.file_type != EXT2_FT_DIR) {
			printf("file not dir: [%d]%s but %d\n",
					finode.ino, finode.name, finode.file_type);
			return -1;
		}
		if (count(finode.ino) != 0) {
			printf("dir must be empty and valid\n");
			return -1;
		}
		if (rm_file(dino, name)) {
			printf("couldn't remove dir '%s' from '%s'\n", name, path);
			return -1;
		}
		if (inodes.remove(finode.ino)) {
			printf("couldn't remove inode %d\n", finode.ino);
			return -1;
		}
		return 0;
	}

	int add_file(int dino, int fino, const char *name, int file_type) {
		inode_t dinode;
		if (dino < 1) {
			return -1;
		}
		if (inodes.getino(dino, &dinode)) {
			printf("Can't read dir inode\n");
			return -1;
		}
		if (dinode.mode != EXT2_S_IFDIR & ~EXT2_S_RMASK) {
			printf("Can only add entryes to dir inodes\n");
			return -1;
		}
		dir_entry_t temp;
		if (find_file(dino, name, temp) > 0) {
			printf("name taken: %s\n", name);
			return -1;
		}
		dir_entry_t dirent;
		dirent.ino = fino;
		dirent.next = sizeof(dir_entry_t);
		dirent.name_len = strlen(name);
		dirent.file_type = file_type;
		if (dirent.name_len > sizeof(dirent.name) + 1) {
			printf("File name to large\n");
			return -1;
		}
		memmove((char *)dirent.name, name, strlen(name) + 1);
		if (dinode.size < sizeof(dir_entry_t)) {
			if (inodes.truncate(dino, sizeof(dir_entry_t))) {
				printf("Can't truncate dir\n");
				return -1;
			}
			if (inodes.write(dino, 0, (char *)&dirent, sizeof(dirent)) <
					sizeof(dir_entry_t))
			{
				printf("Can't write new entry\n");
				return -1;
			}
			if (inodes.mod_links(fino, 1)) {
				/* should reverse add process or try more times */
				printf("Con't modify the number of links to inode\n");
				return -1;
			}
			return 0;
		}
		bool done = false;
		int off = 0;
		while (true) {
			dir_entry_t entry;
			if (inodes.read(dino, off, (char *)&entry, sizeof(entry))
					< sizeof(entry))
			{
				printf("Can't read entry at offset %d\n", off);
				return -1;
			}
			if (entry.next >= 2 * sizeof(dir_entry_t)) {
				dirent.next = entry.next - sizeof(dir_entry_t);
				entry.next = sizeof(dir_entry_t);
				if (inodes.write(dino, off, (char *)&entry, sizeof(entry)) <
						sizeof(dir_entry_t))
				{
					printf("Can't modify entry\n");
					return -1;
				}
				if (inodes.write(dino, off + sizeof(dir_entry_t),
						(char *)&dirent, sizeof(dirent)) < sizeof(dir_entry_t))
				{
					printf("Can't write new entry\n");
					return -1;
				}
				if (inodes.mod_links(fino, 1)) {
					/* should reverse add process or try more times */
					printf("Con't modify the number of links to inode\n");
					return -1;
				}
				return 0;
			}
			if (off + entry.next + sizeof(dir_entry_t) > dinode.size) {
				if (inodes.truncate(dino, dinode.size + sizeof(dir_entry_t))) {
					printf("Can't truncate\n");
					return -1;
				}
				if (inodes.write(dino, off + sizeof(dir_entry_t),
						(char *)&dirent, sizeof(dirent)) < sizeof(dir_entry_t))
				{
					printf("Can't write new entry\n");
					return -1;
				}
				if (inodes.mod_links(fino, 1)) {
					/* should reverse add process or try more times */
					printf("Con't modify the number of links to inode\n");
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
					sizeof(entry))
			{
				return -1;
			}
			if (strcmp((char *)entry.name, name) == 0) {
				if (off + entry.next + sizeof(dir_entry_t) > dinode.size) {
					if (inodes.truncate(dino, off)) {
						printf("Can't truncate for remove\n");
						return -1;
					}
					if (inodes.mod_links(entry.ino, -1)) {
						/* should reverse add process or try more times */
						printf("Con't modify the number of links to inode\n");
						return -1;
					}
					return 0;
				}
				dir_entry_t to_move;
				if (inodes.read(dino, off + entry.next,
						(char *)&to_move, sizeof(to_move))
						< sizeof(to_move))
				{
					return -1;
				}
				to_move.next = to_move.next + entry.next;
				if (off + to_move.next + sizeof(dir_entry_t) > dinode.size) {
					to_move.next = sizeof(dir_entry_t);
					if (inodes.truncate(dino, off + sizeof(dir_entry_t))) {
						printf("Can't truncate for remove\n");
						return -1;
					}
				}
				if (inodes.write(dino, off, (char *)&to_move,
						sizeof(to_move)) < sizeof(to_move))
				{
					return -1;
				}
				if (inodes.mod_links(entry.ino, -1)) {
					/* should reverse add process or try more times */
					printf("Con't modify the number of links to inode\n");
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
					< sizeof(entry))
			{
				printf("can't read entry: off[%d] ino[%d]\n", off, dino);
				return -1;
			}
			if (strcmp((char *)entry.name, name) == 0) {
				res = entry;
				return entry.ino;
			}
			if (off + entry.next + sizeof(dir_entry_t) > dinode.size) {
				return -1;
			}
			off += entry.next;
		}
	}

	/* must be an absolute path */
	int find_rec(const char *cpath) {
		int curr_dir = 2;
		auto path = split(cpath, '/');
		for (auto&& file : path) {
			if (file == "")
				continue;
			dir_entry_t aux;
			if ((curr_dir = find_file(curr_dir, file.c_str(), aux)) < 1)
				return -1;
		}
		return curr_dir;
	}

	int count(int dino) {
		int i = 0;
		if (listdir(dino, [&i](auto& entry) { i++; }))
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

	template <typename Fn>
	int listdir(int dino, Fn&& fn) {
		dir_entry_t entry;
		inode_t dinode;
		int off = 0;
		if (dino < 0)
			return -1;
		if (inodes.getino(dino, &dinode))
			return -1;
		if (dinode.size < sizeof(dir_entry_t))
			return 0;
		while (true) {
			if (inodes.read(dino, off, (char *)&entry, sizeof(entry))
					< sizeof(entry))
			{
				return -1;
			}
			fn(entry);
			if (off + entry.next + sizeof(dir_entry_t) > dinode.size) {
				return 0;
			}
			off += entry.next;
		}
		return 0;
	}
};

#endif