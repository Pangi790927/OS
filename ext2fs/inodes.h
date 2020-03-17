#ifndef INODES_H
#define INODES_H

#include "interval_map.h"
#include "to_str.h"

struct Commiter {
	struct to_commit_t {
		char *ptr;
		uint32_t blk;
		uint32_t cnt;
	};

	uint32_t blk_size;
	Ext2Dev &ext2dev;
	IntervalMap<to_commit_t> to_commit;
	std::vector<char *> to_unload;

	std::function<void(to_commit_t& keep, const to_commit_t& oth)> merger =
			[this](to_commit_t& keep, const to_commit_t& oth)
	{
		auto aux = keep;
		auto end = std::max(aux.blk + aux.cnt, oth.blk + oth.cnt);
		aux.blk = std::min(aux.blk, oth.blk);
		aux.cnt = end - aux.blk;

		aux.ptr = std::min(keep.ptr, oth.ptr);
		if ((keep.ptr - aux.ptr + keep.cnt * blk_size > end * blk_size) ||
				(oth.ptr - aux.ptr + oth.cnt * blk_size > end * blk_size))
		{
			/* the case where pointers are not one after the oher, we will
			see this case in kernel */
			EXCEPTION("WIP: to be implemented");
		}
		keep = aux;
	};

	Commiter(Ext2Dev &ext2dev, uint32_t blk_size)
	: ext2dev(ext2dev), blk_size(blk_size) {
		to_commit.merge_fn = merger;
	}

	void stage(char *ptr, uint32_t blk, uint32_t cnt) {
		if (!to_commit.insert(blk, blk + cnt, to_commit_t{
				.ptr = ptr, .blk = blk, cnt = cnt}))
		{
			EXCEPTION("Can't insert interval");
		}
	}

	void for_unload(char *ptr) {
		to_unload.push_back(ptr);
	}

	int commit() {
		// TO DO: handle write errors
		to_commit.iterate([this](to_commit_t& obj){
			ext2dev.write(obj.ptr, obj.blk * blk_size, obj.cnt * blk_size);
		});
		for (auto&& ptr : to_unload)
			ext2dev.unload(ptr);
		return 0;
	}

	void reject() {
		to_commit.clear();
		for (auto&& ptr : to_unload)
			ext2dev.unload(ptr);
	}
};

// TO DO: change nake to Groups or something
// TO DO: add a lot of checks
/* a local commiter will be created for each new entry created and
at the end of the operation the blocks will be changed on file */
class Inodes {
public:
	Ext2Dev &ext2dev;
	std::vector<Bitmap> &ino_bitmaps;
	std::vector<Bitmap> &blk_bitmaps;
	ext2_sup_t *&sup;
	blk_grp_desc_t *&desc_table;

	Inodes(Ext2Dev &ext2dev, std::vector<Bitmap> &ino_bitmaps,
			std::vector<Bitmap> &blk_bitmaps, ext2_sup_t *&sup,
			blk_grp_desc_t *&desc_table)
	: ext2dev(ext2dev), ino_bitmaps(ino_bitmaps), blk_bitmaps(blk_bitmaps),
			sup(sup), desc_table(desc_table)
	{}

	// write, read, truncate, create, remove
	// create(mode, uid, gid) -> ino
	// write(ino, off, buf, len) -> num_write
	// read(ino, off, buf, len) -> num_read
	// truncate(ino, newsz) -> success
	// remove(ino) -> success

	int create(int mode, int uid, int gid) {
		Commiter commiter(ext2dev, blk_size());
		int ino = alloc_ino(0, commiter);

		if (ino < 1) {
			commiter.reject();
			return -1;
		}
		if (fill_ino(ino, commiter, mode, uid, gid) < 0) {
			commiter.reject();
			return -1;	
		}
		if (mode == EXT2_S_IFDIR) {
			desc_table[(ino - 1) / sup->ino_per_grp].used_dir_cnt++;
		}
		if (commiter.commit()) {
			printf("can't commit data\n");
			return -1;
		}
		return ino;
	}

	int remove(int ino) {
		Commiter commiter(ext2dev, blk_size());
		if (free_ino(ino, commiter)) {
			printf("free_ino failed\n");
			commiter.reject();
			return -1;
		}
		return commiter.commit();
	}

	int truncate(int ino, int size) {
		Commiter commiter(ext2dev, blk_size());
		auto [inode, blk_ptr] = get_inob(ino, commiter);
		if (!inode) {
			printf("Can't read inode %d\n", ino);
			return -1;
		}
		commiter.for_unload((char *)inode);
		int bsize = roundup_div(size, blk_size());
		if (inode->size == size)
			return commiter.commit();
		commiter.stage((char *)blk_ptr, get_ino_baddr(ino), 1);
		if (bsize == inode->bsize) {
			inode->size = size;
			return commiter.commit();
		}
		if (inode->bsize < bsize) {
			int grp = (ino - 1) / sup->ino_per_grp;
			if (add_blocks(inode, bsize - inode->bsize, grp, commiter,
					[this, &grp, &commiter](){
						return alloc_blk(grp, commiter);
					}))
			{
				commiter.reject();
				return -1;
			}
		}
		if (bsize < inode->bsize) {
			if (rem_blocks(inode, inode->bsize - bsize, commiter)) {
				commiter.reject();
				return -1;
			}
		}
		inode->bsize = bsize;
		inode->size = size;
		return commiter.commit();
	}

	int write(int ino, int off, const char *buf, int len) {
		Commiter commiter(ext2dev, blk_size());
		auto [inode, _] = get_inob(ino, commiter);
		if (!inode)
			return -1;
		commiter.for_unload((char *)inode);
		int start = 0;
		int end = len;
		while (start != end) {
			int blk = bget_off(inode, off, commiter);
			block_t *block = ext2dev.load<block_t>(blk2faddr(blk), blk_size());
			if (!block)
				break;
			commiter.for_unload((char *)block);
			commiter.stage((char *)block, blk, 1);
			int inc = std::min(end - start, int(blk_size() - off % blk_size()));
			memmove((char *)block + off % blk_size(), buf + start, inc);
			off += inc;
			start += inc;
		}
		if (commiter.commit())
			return -1;
		return start;
	}

	int read(int ino, int off, char *buf, int len) {
		Commiter commiter(ext2dev, blk_size());
		auto [inode, _] = get_inob(ino, commiter);
		if (!inode) {
			printf("Can't find inode: %d\n", ino);
			return -1;
		}
		commiter.for_unload((char *)inode);
		int start = 0;
		int end = len;
		while (start != end) {
			int blk = bget_off(inode, off, commiter);
			block_t *block = ext2dev.load<block_t>(blk2faddr(blk), blk_size());
			if (!block)
				break;
			commiter.for_unload((char *)block);
			int inc = std::min(end - start, int(blk_size() - off % blk_size()));
			memmove(buf + start, (char *)block + off % blk_size(), inc);
			off += inc;
			start += inc;
		}
		if (commiter.commit()) {
			printf("Can't commit read for inode: %d\n", ino);
			return -1;
		}
		return start;
	}

	int getino(int ino, inode_t *inode) {
		Commiter commiter(ext2dev, blk_size());
		auto [aux, _] = get_inob(ino, commiter);
		if (!aux)
			return -1;
		*inode = *aux;
		return commiter.commit();
	}

	int mod_links(int ino, int dir) {
		Commiter commiter(ext2dev, blk_size());
		auto [inode, blk_ptr] = get_inob(ino, commiter);
		if (!inode)
			return -1;
		if ((int)inode->links_cnt + dir < 0) {
			commiter.reject();
			return -1;
		}
		inode->links_cnt += dir;
		commiter.stage((char *)blk_ptr, get_ino_baddr(ino), 1);
		return commiter.commit();
	}

	int alloc_specific_ino(int ino, int mode) {
		Commiter commiter(ext2dev, blk_size());
		int grp = 0;
		ino_bitmaps[grp].set(ino - 1, true);
		sup->free_ino_cnt--;
		desc_table[grp].free_ino_cnt--;
		commiter.stage((char *)ino_bitmaps[grp].addr,
				desc_table[grp].ino_bitmap, 1);
		if (fill_ino(ino, commiter, mode))
			return -1;
		if (mode & EXT2_S_IFDIR != 0)
			desc_table[grp].used_dir_cnt++;
		return commiter.commit();
	}

	int alloc_reserved_inodes() {
		alloc_specific_ino(1, EXT2_S_IFREG);
		alloc_specific_ino(2, EXT2_S_IFDIR);
		alloc_specific_ino(3, EXT2_S_IFREG);
		alloc_specific_ino(4, EXT2_S_IFREG);
		alloc_specific_ino(5, EXT2_S_IFREG);
		alloc_specific_ino(6, EXT2_S_IFREG);
		alloc_specific_ino(7, EXT2_S_IFREG);
		alloc_specific_ino(8, EXT2_S_IFREG);
		alloc_specific_ino(9, EXT2_S_IFREG);
		alloc_specific_ino(10, EXT2_S_IFREG);
		return 0;
	}

	/* this creates very specific files that are continuous and imutable */
	int write_imutable(int ino, const char *buff, int size) {
		if (ino < 1 || size <= 0)
			return -1;
		/* modify inode */
		Commiter commiter(ext2dev, blk_size());
		auto [inode, blk_ptr] = get_inob(ino, commiter);
		commiter.stage((char *)blk_ptr, get_ino_baddr(ino), 1);
		inode->flags |= EXT2_IMMUTABLE_FL;

		/* find len blocks of specified size in a contiguous zone
		and alloc them */
		int bsize = roundup_div(size, blk_size());
		int start_blk = -1;
		int grp = 0;
		inode->bsize = bsize;
		inode->size = size;
		for (; grp < blk_bitmaps.size(); grp++) {
			bool found = false;
			int curr_bsize = 0;
			int free_idxs = 0;
			int i = 0;
			for (; free_idxs < desc_table[grp].free_blk_cnt; i++) {
				if (blk_bitmaps[grp].get(i) == 0) {
					free_idxs++;
					curr_bsize++;
				}
				if (blk_bitmaps[grp].get(i) != 0) {
					curr_bsize = 0;
				}
				if (curr_bsize == bsize) {
					found = true;
					break;
				}
			}
			if (found) {
				for (int j = 0; j < bsize; j++, i++) {
					if ((start_blk = alloc_spec_blk(grp, i, commiter)) < 0) {
						printf("Can't alloc blk for imutable: [grp:%d]rel:%d\n",
								grp, i);
						commiter.reject();
						return -1;
					}
				}
				start_blk = start_blk - bsize + 1;
			}
		}
		if (start_blk < 0) {
			printf("Didn't find contiguous space for imutable\n");
			commiter.reject();
		}
		if (add_blocks(inode, bsize, grp, commiter,
				[&start_blk, this, &grp](){
					return start_blk++;
				}))
		{
			commiter.reject();
			return -1;
		}
		if (commiter.commit()) {
			printf("Failed to mod/truncate imutable\n");
			return -1;
		}
		if (write(ino, 0, buff, size) != size) {
			printf("Failed to write imutable\n");
			return -1;
		}
		return 0;
	}

	std::string to_string() {
		std::string ret = "";
		for (int i = 0; i < ino_bitmaps.size(); i++) {
			for (int j = 0; j < sup->ino_per_grp; j++) {
				if (ino_bitmaps[i].get(j)) {
					ret += sformat("ino[%d] %s", i * sup->ino_per_grp + j + 1,
							ino_to_str(i * sup->ino_per_grp + j + 1));
				}
			}
		}
		return ret;
	}

	std::string ino_to_str(int ino) {
		inode_t inode;
		if (getino(ino, &inode))
			return "[err]";
		return ext_ino_str(&inode);
	}

private:
	int bget_off(inode_t *inode, int off, Commiter &commiter) {
		int i = off / blk_size();
		int ipb = blk_size() / sizeof(int);
		if (i < 12) {
			// no indir
			return inode->block[i];
		}
		if (12 <= i && i < 12 + ipb)  {
			// one indir
			i -= 12;
			int *blocks = ext2dev.load<int>(blk2faddr(inode->block[12]),
					blk_size());
			commiter.for_unload((char *)blocks);
			return blocks[i];
		}
		if (12 + ipb <= i && i < 12 + ipb + ipb*ipb) {
			// two indir
			i -= 12 + ipb;
			int *indir1 = ext2dev.load<int>(blk2faddr(inode->block[13]),
					blk_size());
			int *blocks = ext2dev.load<int>(blk2faddr(indir1[i / ipb]),
					blk_size());
			commiter.for_unload((char *)indir1);
			commiter.for_unload((char *)blocks);
			return blocks[i % ipb];
		}
		if (12 + ipb + ipb*ipb <= i && i < 12 + ipb + ipb*ipb + ipb*ipb*ipb) {
			// three indir
			i -= 12 + ipb + ipb*ipb;
			int *indir2 = ext2dev.load<int>(blk2faddr(inode->block[14]),
					blk_size());
			int *indir1 = ext2dev.load<int>(blk2faddr(indir2[i / (ipb * ipb)]),
					blk_size());
			int *blocks = ext2dev.load<int>(blk2faddr(indir1[(i / ipb) % ipb]),
					blk_size());
			commiter.for_unload((char *)indir2);
			commiter.for_unload((char *)indir1);
			commiter.for_unload((char *)blocks);
			return blocks[i % ipb];
		}
		return -1;
	}

	template <typename BlkAlloc>
	int add_blocks(inode_t *inode, int cnt, int grp, Commiter &commiter,
			BlkAlloc&& blk_alloc)
	{
		auto alloc_indir = [&commiter, this, &grp] () {
			int blk = alloc_blk(grp, commiter);
			if (blk < 0)
				return -1;
			
			int *blocks = ext2dev.load<int>(blk2faddr(blk), blk_size());
			for (int i = 0; i < blk_size() / 4; i++)
				blocks[i] = 0;
			commiter.stage((char *)blocks, blk, 1);
			commiter.for_unload((char *)blocks);
			return 0;
		};
		auto add =
		[&commiter, this, &grp, &inode, &alloc_indir, &blk_alloc] (int i) {
			// ints per block
			int ipb = blk_size() / sizeof(int);
			if (i < 12) {
				// no indir
				inode->block[i] = blk_alloc();
				if (inode->block[i] < 0)
					return -1;
			}
			if (12 <= i && i < 12 + ipb)  {
				// one indir
				i -= 12;
				if (!inode->block[12]) {
					inode->block[12] = alloc_indir();
					if (inode->block[12] < 0)
						return -1;
				}
				int *blocks = ext2dev.load<int>(blk2faddr(inode->block[12]),
						blk_size());
				commiter.for_unload((char *)blocks);
				blocks[i] = blk_alloc();
				commiter.stage((char *)blocks, inode->block[12], 1);
			}
			if (12 + ipb <= i && i < 12 + ipb + ipb*ipb) {
				// two indir
				i -= 12 + ipb;
				if (!inode->block[13]) {
					inode->block[13] = alloc_indir();
					if (inode->block[13] < 0)
						return -1;
				}
				int *indir1 = ext2dev.load<int>(blk2faddr(inode->block[13]),
						blk_size());
				commiter.for_unload((char *)indir1);
				if (!indir1[i / ipb]) {
					indir1[i / ipb] = alloc_indir();
					if (indir1[i / ipb] < 0)
						return -1;
				}
				int *blocks = ext2dev.load<int>(blk2faddr(indir1[i / ipb]),
						blk_size());
				commiter.for_unload((char *)blocks);
				blocks[i % ipb] = blk_alloc();
				commiter.stage((char *)blocks, indir1[i / ipb], 1);
			}
			if (12 + ipb + ipb*ipb <= i &&
					i < 12 + ipb + ipb*ipb + ipb*ipb*ipb)
			{
				// three indir
				i -= 12 + ipb + ipb*ipb;
				if (!inode->block[14]) {
					inode->block[14] = alloc_indir();
					if (inode->block[14] < 0)
						return -1;
				}
				int *indir1 = ext2dev.load<int>(blk2faddr(inode->block[14]),
						blk_size());
				commiter.for_unload((char *)indir1);
				if (!indir1[i / (ipb*ipb)]) {
					indir1[i / (ipb*ipb)] = alloc_indir();
					if (indir1[i / (ipb*ipb)] < 0)
						return -1;
				}
				int *indir2 = ext2dev.load<int>(blk2faddr(indir1[i / ipb]),
						blk_size());
				commiter.for_unload((char *)indir1);
				if (!indir2[(i / ipb) % ipb]) {
					indir2[(i / ipb) % ipb] = alloc_indir();
					if (indir2[(i / ipb) % ipb] < 0)
						return -1;
				}
				int *blocks = ext2dev.load<int>(
						blk2faddr(indir2[(i / ipb) % ipb]), blk_size());
				commiter.for_unload((char *)blocks);
				blocks[i % ipb] = blk_alloc();
				commiter.stage((char *)blocks, indir2[(i / ipb) % ipb], 1);
			}
			return 0;
		};
		int inode_bsize = roundup_div(inode->size, blk_size());
		for (int i = 0; i < cnt; i++)
			if (add(inode_bsize + i) < 0)
				return -1;
		return 0;
	}

	int rem_blocks(inode_t *inode, int cnt, Commiter &commiter) {
		auto rem = [&commiter, this, &inode] (int i) {
			int ipb = blk_size() / sizeof(int);
			if (i < 12) {
				// no indir
				if (free_blk(inode->block[i], commiter))
					return -1;
				inode->block[i] = 0;
			}
			if (12 <= i && i < 12 + ipb)  {
				// one indir
				i -= 12;
				int *blocks = ext2dev.load<int>(blk2faddr(inode->block[12]),
						blk_size());
				commiter.for_unload((char *)blocks);
				if (free_blk(blocks[i], commiter))
					return -1;
				blocks[i] = 0;
				commiter.stage((char *)blocks, inode->block[12], 1);
				if (i == 0) {
					if (free_blk(inode->block[12], commiter))
						return -1;
					inode->block[12] = 0;
				}
			}
			if (12 + ipb <= i && i < 12 + ipb + ipb*ipb) {
				i -= 12 + ipb;
				int *indir1 = ext2dev.load<int>(blk2faddr(inode->block[13]),
						blk_size());
				int *blocks = ext2dev.load<int>(blk2faddr(indir1[i / ipb]),
						blk_size());
				commiter.for_unload((char *)indir1);
				commiter.for_unload((char *)blocks);
				if (free_blk(blocks[i % ipb], commiter))
					return -1;
				blocks[i % ipb] = 0;
				commiter.stage((char *)blocks, indir1[i / ipb], 1);
				if (i / ipb == 0) {
					if (free_blk(indir1[i / ipb], commiter))
						return -1;
					indir1[i / ipb] = 0;
					commiter.stage((char *)indir1, inode->block[13], 1);
				}
				if (i == 0) {
					if (free_blk(inode->block[13], commiter))
						return -1;
					inode->block[13] = 0;
				}
				// two indir
			}
			if (12 + ipb + ipb*ipb <= i &&
					i < 12 + ipb + ipb*ipb + ipb*ipb*ipb)
			{
				// three indir
				i -= 12 + ipb + ipb*ipb;
				int *indir2 = ext2dev.load<int>(blk2faddr(inode->block[14]),
						blk_size());
				int *indir1 = ext2dev.load<int>(
						blk2faddr(indir1[i / (ipb*ipb)]), blk_size());
				int *blocks = ext2dev.load<int>(blk2faddr(indir1[i / ipb]),
						blk_size());
				commiter.for_unload((char *)indir2);
				commiter.for_unload((char *)indir1);
				commiter.for_unload((char *)blocks);
				if (free_blk(blocks[i % ipb], commiter))
					return -1;
				blocks[i % ipb] = 0;
				commiter.stage((char *)blocks, indir1[(i / ipb) % ipb], 1);
				if ((i / ipb) % ipb == 0) {
					if (free_blk(indir1[(i / ipb) % ipb], commiter))
						return -1;
					indir1[(i / ipb) % ipb] = 0;
					commiter.stage((char *)indir1,
							inode->block[i / (ipb*ipb)], 1);
				}
				if (i / (ipb*ipb) == 0) {
					if (free_blk(indir2[i / ipb], commiter))
						return -1;
					indir2[i / ipb] = 0;
					commiter.stage((char *)indir2, inode->block[14], 1);
				}
				if (i == 0) {
					if (free_blk(inode->block[14], commiter))
						return -1;
					inode->block[14] = 0;
				}
			}
			return 0;
		};
		int inode_bsize = roundup_div(inode->size, blk_size());
		for (int i = cnt - 1; i >= 0; i--)
			if (rem(inode_bsize + i) < 0)
				return -1;
		return 0;
	}

	int alloc_ino(int sugested_grp, Commiter &commiter) {
		if (desc_table[sugested_grp].free_ino_cnt != 0)
			return alloc_ino_in_grp(sugested_grp, commiter);
		else
			for (int i = 0; i < ino_bitmaps.size(); i++)
				if (desc_table[i].free_ino_cnt != 0)
					return alloc_ino_in_grp(i, commiter);
		return -1;
	}

	int free_ino(int ino, Commiter &commiter) {
		if (ino < 1)
			return -1;
		int grp = (ino - 1) / sup->ino_per_grp;
		int rel_ino = (ino - 1) % sup->ino_per_grp;
		auto [inode, _] = get_inob(ino, commiter);
		commiter.for_unload((char *)inode);
		if (inode->size != 0)
			if (rem_blocks(inode, roundup_div(inode->size, blk_size()),
					commiter))
				return -1;
		ino_bitmaps[grp].set(rel_ino, false);
		sup->free_ino_cnt++;
		desc_table[grp].free_ino_cnt++;
		commiter.stage((char *)ino_bitmaps[grp].addr,
				desc_table[grp].ino_bitmap, 1);
		return 0;
	}

	std::tuple<inode_t *, inode_t *> get_inob(int ino, Commiter &commiter) {
		int grp = (ino - 1) / sup->ino_per_grp;
		int rel_ino = (ino - 1) % sup->ino_per_grp;
		if (rel_ino < 0 || grp < 0)
			return {NULL, NULL};
		inode_t *ptr = ext2dev.load<inode_t>(
				blk2faddr(desc_table[grp].ino_table + rel_ino / 
				(blk_size() / sup->ino_size)), blk_size());
		commiter.for_unload((char *)ptr);
		return {ptr + (rel_ino % (blk_size() / sup->ino_size)), ptr};
	}

	// block_t *get_blk(int blk) {
	// 	int grp = blk / grp_bsize();
	// 	int rel_blk = blk - blk_table(grp);
	// 	if (rel_blk < 0 || grp < 0)
	// 		return NULL;
	// 	return ext2dev.load(blk2faddr(blk_table(grp) + rel_blk), blk_size());
	// }

	int alloc_blk(int sugested_grp, Commiter &commiter) {
		if (desc_table[sugested_grp].free_blk_cnt != 0)
			return alloc_blk_in_grp(sugested_grp, commiter);
		else
			for (int i = 0; i < blk_bitmaps.size(); i++)
				if (desc_table[i].free_blk_cnt != 0)
					return alloc_blk_in_grp(i, commiter);
		return -1;
	}

	int free_blk(int blk, Commiter &commiter) {
		if (blk < 0)
			return -1;
		int grp = blk / grp_bsize();
		int rel_blk = blk - blk_table(grp);
		blk_bitmaps[grp].set(rel_blk, false);
		sup->free_blk_cnt++;
		desc_table[grp].free_blk_cnt++;
		commiter.stage((char *)blk_bitmaps[grp].addr,
				desc_table[grp].blk_bitmap, 1);
		return 0;
	}

	int alloc_blk_in_grp(int grp, Commiter &commiter) {
		int rel_blk = blk_bitmaps[grp].get_first_free();
		blk_bitmaps[grp].set(rel_blk, true);
		sup->free_blk_cnt--;
		desc_table[grp].free_blk_cnt--;
		commiter.stage((char *)blk_bitmaps[grp].addr,
				desc_table[grp].blk_bitmap, 1);
		return rel_blk + blk_table(grp);
	}

	int alloc_spec_blk(int grp, int rel_blk, Commiter &commiter) {
		if (blk_bitmaps[grp].get(rel_blk)) {
			printf("blk already allocated\n");
			return -1;
		}
		blk_bitmaps[grp].set(rel_blk, true);
		sup->free_blk_cnt--;
		desc_table[grp].free_blk_cnt--;
		commiter.stage((char *)blk_bitmaps[grp].addr,
				desc_table[grp].blk_bitmap, 1);
		return rel_blk + blk_table(grp);
	}

	int alloc_ino_in_grp(int grp, Commiter &commiter) {
		int rel_ino = ino_bitmaps[grp].get_first_free();
		ino_bitmaps[grp].set(rel_ino, true);
		sup->free_ino_cnt--;
		desc_table[grp].free_ino_cnt--;
		commiter.stage((char *)ino_bitmaps[grp].addr,
				desc_table[grp].ino_bitmap, 1);
		int ino = rel_ino + grp * sup->ino_per_grp + 1;
		return ino;
	}

	int fill_ino(int ino, Commiter &commiter,
			int mode = 0, int gid = 0, int uid = 0)
	{
		auto [inode, blk_ptr] = get_inob(ino, commiter);
		if (!inode)
			return -1;
		inode->mode = mode;
		inode->gid = gid;
		inode->uid = uid;
		inode->size = 0;
		inode->atime = 0;
		inode->ctime = 0;
		inode->mtime = 0;
		inode->links_cnt = 0;
		inode->bsize = 0;
		inode->flags = 0;
		inode->generation = 0;
		inode->file_acl = 0;
		inode->dir_acl = 0;
		inode->faddr = 0;
		memset(inode->block, 0, sizeof(inode->block));
		commiter.stage((char *)blk_ptr, get_ino_baddr(ino), 1);
		return 0;
	}

	int get_ino_baddr(int ino) {
		if (ino < 1)
			return -1;
		int grp = (ino - 1) / sup->ino_per_grp;
		int idx = (ino - 1) % sup->ino_per_grp;
		return desc_table[grp].ino_table + idx / (blk_size() / sup->ino_size);
	}

	int blk_table(int grp) {
		return desc_table[grp].ino_table +
				roundup_div(sup->ino_size * sup->ino_per_grp, blk_size());
	}

	int grp_bsize() {
		return roundup_div(ino_bitmaps.size() * 32, BLK_SIZE) +
				3 + sup->ino_per_grp * sup->ino_size / BLK_SIZE +
				sup->blk_per_grp;
	}

	uint64_t blk_size() {
		return 1 << (sup->log_blk_size + 10);
	}

	uint64_t blk2faddr(uint32_t blk) {
		return blk * blk_size();
	}
};

#endif