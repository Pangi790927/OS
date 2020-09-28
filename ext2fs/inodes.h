#ifndef INODES_H
#define INODES_H

#include "dev.h"
#include "ext2defs.h"
#include "stdlib.h"

using ExtDev = Dev<BLK_SIZE>;

struct SectorDesc {
	ExtDev::Sector sect;
	blk_grp_desc_t *desc;
};

struct SectorBitmap {
	ExtDev::Sector sect;
	Bitmap bmap;
};

struct inob_ret_t {
	int blk;
	int off;
};

using load_desc_t = SectorDesc (*)(void *ctx, int grp);
using load_ino_bitmap_t = SectorBitmap (*)(void *ctx, int grp);
using load_blk_bitmap_t = SectorBitmap (*)(void *ctx, int grp);

template <typename UnloadFn>
struct UnloadScope {
	UnloadFn fn;
	int line;
	UnloadScope(UnloadFn fn, int line) : fn(fn), line(line) {}
	~UnloadScope() {
		fn(line);
	}
};

#define CONCAT_(x,y) x##y
#define CONCAT(x,y) CONCAT_(x,y)

#define EXPAND_(x, y) x ## y
#define EXPAND__(x, y) EXPAND_(x, y)
#define EXPAND(x) EXPAND__(x, __LINE__)

#define EXT_LOAD_BLK(name, blk, ret)\
auto name = ext_dev.get_sect(blk);\
UnloadScope EXPAND(unload_scope)([&](int line){\
	if (!name.verdict) {\
		DBG("Unload scope called in inodes.h: line: %d", line);\
		name.unload();\
	}\
}, __LINE__);\
if (!name.get()) {\
	DBG("[ERROR] Couldn't load block: %d", (blk));\
	return ret;\
}

#define EXT_LOAD_DESC(name, grp, ret)\
auto name = load_desc(grp);\
UnloadScope EXPAND(unload_scope)([&](int line){\
	if (!name.sect.verdict) {\
		DBG("Unload scope called in inodes.h: line: %d", line);\
		name.sect.unload();\
	}\
}, __LINE__);\
if (!name.sect.get()) {\
	DBG("[ERROR] Couldn't load desc: %d", (grp));\
	return ret;\
}

#define EXT_LOAD_INO_BM(name, grp, ret)\
auto name = load_ino_bmap(grp);\
UnloadScope EXPAND(unload_scope)([&](int line){\
	if (!name.sect.verdict) {\
		DBG("Unload scope called in inodes.h: line: %d", line);\
		name.sect.unload();\
	}\
}, __LINE__);\
if (!name.sect.get()) {\
	DBG("[ERROR] Couldn't load inode bitmap: %d", (grp));\
	return ret;\
}

#define EXT_LOAD_BLK_BM(name, grp, ret)\
auto name = load_blk_bmap(grp);\
UnloadScope EXPAND(unload_scope)([&](int line){\
	if (!name.sect.verdict) {\
		DBG("Unload scope called in inodes.h: line: %d", line);\
		name.sect.unload();\
	}\
}, __LINE__);\
if (!name.sect.get()) {\
	DBG("[ERROR] Couldn't load block bitmap: %d", (grp));\
	return ret;\
}

#define EXT_SAVE(name, val, ret)\
if (name.save(true) != 0) {\
	DBG("[ERROR] Couldn't save #%s: for %d", #name, val);\
	return ret;\
}

#define EXT_SAVE_BLK(name, grp, ret) EXT_SAVE(name, (grp), ret)
#define EXT_SAVE_DESC(name, grp, ret) EXT_SAVE(name.sect, (grp), ret)
#define EXT_SAVE_INO_BM(name, grp, ret) EXT_SAVE(name.sect, (grp), ret)
#define EXT_SAVE_BLK_BM(name, grp, ret) EXT_SAVE(name.sect, (grp), ret)

class Inodes {
public:
	ExtDev &ext_dev;

	ext2_sup_t *&sup;
	int grp_count = 0;
	void *ctx = NULL;
	load_desc_t load_desc_fn = NULL;
	load_ino_bitmap_t load_ino_bitmap_fn = NULL;
	load_blk_bitmap_t load_blk_bitmap_fn = NULL;

	Inodes(
			ExtDev &ext_dev,
			ext2_sup_t *&sup,
			void *ctx,
			load_desc_t load_desc_fn,
			load_ino_bitmap_t load_ino_bitmap_fn,
			load_blk_bitmap_t load_blk_bitmap_fn)
	: 
			ext_dev(ext_dev),
			sup(sup),
			ctx(ctx),
			load_desc_fn(load_desc_fn),
			load_ino_bitmap_fn(load_ino_bitmap_fn),
			load_blk_bitmap_fn(load_blk_bitmap_fn)
	{}

	SectorDesc load_desc(int i) {
		return load_desc_fn(ctx, i);
	}

	SectorBitmap load_ino_bmap(int i) {
		return load_ino_bitmap_fn(ctx, i);
	}

	SectorBitmap load_blk_bmap(int i) {
		return load_blk_bitmap_fn(ctx, i);
	}

	int grp_cnt() {
		if (roundup_div(sup->ino_cnt, sup->ino_per_grp) !=
				roundup_div(sup->blk_cnt, sup->blk_per_grp))
		{
			EXCEPTION("grp_cnt generated by ino_cnt and blk_cnt must match");
		}
		return roundup_div(sup->ino_cnt, sup->ino_per_grp);
	}

	int create(int mode, int uid, int gid) {
		DBGSCOPE();
		int ino = alloc_ino(0);
		if (ino < 1) {
			DBG("Couldn't allocate inode");
			return -1;
		}
		if (fill_ino(ino, mode, uid, gid) < 0) {
			DBG("Couldn't populate inode");
			return -1;	
		}
		if (mode == EXT2_S_IFDIR) {
			int grp = (ino - 1) / sup->ino_per_grp;
			EXT_LOAD_DESC(desc, grp, -1);
			desc.desc->used_dir_cnt++;
			EXT_SAVE_DESC(desc, grp, -1);
		}
		DBG("created inode: %d", ino);
		return ino;
	}

	int remove(int ino) {
		DBGSCOPE();
		return free_ino(ino);
	}

	int truncate(int ino, int size) {
		DBG("truncate inode: %d to: %d[%dblks]",
				ino, size, roundup_div(size, BLK_SIZE));
		auto [index, off] = get_inob(ino);
		EXT_LOAD_BLK(ino_sect, index, -1);
		auto inode = (inode_t *)(ino_sect.get() + off);
		int bsize = roundup_div(size, BLK_SIZE);
		if ((int)inode->size == size) {
			ino_sect.unload();
			return 0;
		}
		if (bsize == (int)inode->bsize) {
			inode->size = size;
			EXT_SAVE_BLK(ino_sect, index, -1);
			return 0;
		}
		if ((int)inode->bsize < bsize) {
			int grp = (ino - 1) / sup->ino_per_grp;
			if (add_blocks(inode, bsize - inode->bsize, grp,
					[this, &grp](){
						return alloc_blk(grp);
					}))
			{
				ino_sect.unload();
				return -1;
			}
		}
		if (bsize < (int)inode->bsize) {
			if (rem_blocks(inode, inode->bsize - bsize)) {
				ino_sect.unload();
				return -1;
			}
		}
		inode->bsize = bsize;
		inode->size = size;
		EXT_SAVE_BLK(ino_sect, index, -1);
		return 0;
	}

	int write(int ino, int off, const char *buf, int len) {
		auto [index, ino_off] = get_inob(ino);
		EXT_LOAD_BLK(ino_sect, index, -1);
		auto inode = (inode_t *)(ino_sect.get() + ino_off);
		int start = 0;
		int end = len;
		while (start != end) {
			int blk = bget_off(inode, off);

			EXT_LOAD_BLK(sect, blk, -1);
			auto block = (block_t *)sect.get();
			int inc = ext_min(end - start, int(BLK_SIZE - off % BLK_SIZE));
			memmove((char *)block + off % BLK_SIZE, buf + start, inc);
			EXT_SAVE_BLK(sect, blk, -1);

			off += inc;
			start += inc;
		}
		ino_sect.unload();
		return start;
	}

	int read(int ino, int off, char *buf, int len) {
		auto [index, ino_off] = get_inob(ino);
		EXT_LOAD_BLK(ino_sect, index, -1);
		auto inode = (inode_t *)(ino_sect.get() + ino_off);
		int start = 0;
		int end = len;
		while (start != end) {
			int blk = bget_off(inode, off);

			EXT_LOAD_BLK(sect, blk, -1);
			auto block = (block_t *)sect.get();
			int inc = ext_min(end - start, int(BLK_SIZE - off % BLK_SIZE));
			memmove(buf + start, (char *)block + off % BLK_SIZE, inc);
			sect.unload();

			off += inc;
			start += inc;
		}
		ino_sect.unload();
		return start;
	}

	int getino(int ino, inode_t *inode) {
		auto [index, ino_off] = get_inob(ino);
		EXT_LOAD_BLK(ino_sect, index, -1);
		auto aux = (inode_t *)(ino_sect.get() + ino_off);
		*inode = *aux;
		ino_sect.unload();
		return 0;
	}

	int mod_links(int ino, int dir) {
		auto [index, ino_off] = get_inob(ino);
		EXT_LOAD_BLK(ino_sect, index, -1);
		auto inode = (inode_t *)(ino_sect.get() + ino_off);

		if ((int)inode->links_cnt + dir < 0) {
			ino_sect.unload();
			return -1;
		}
		inode->links_cnt += dir;
		EXT_SAVE_BLK(ino_sect, index, -1);
		return 0;
	}

	int alloc_specific_ino(int ino, int mode) {
		int grp = 0;
		EXT_LOAD_INO_BM(sb_ino, grp, -1);
		sb_ino.bmap.set(ino - 1, true);
		
		if (fill_ino(ino, mode))
			return -1;

		EXT_LOAD_DESC(desc, grp, -1);
		desc.desc->free_ino_cnt--;
		if ((mode & EXT2_S_IFDIR) != 0)
			desc.desc->used_dir_cnt++;

		EXT_SAVE_INO_BM(sb_ino, grp, -1);
		EXT_SAVE_DESC(desc, grp, -1);
		sup->free_ino_cnt--;
		return 0;
	}

	int alloc_reserved_inodes() {
		DBGSCOPE();
		alloc_specific_ino(1, 0);
		alloc_specific_ino(2, EXT2_S_IFDIR | EXT2_S_RMASK);
		alloc_specific_ino(3, 0);
		alloc_specific_ino(4, 0);
		alloc_specific_ino(5, 0);
		alloc_specific_ino(6, 0);
		alloc_specific_ino(7, 0);
		alloc_specific_ino(8, 0);
		alloc_specific_ino(9, 0);
		alloc_specific_ino(10, 0);
		alloc_specific_ino(11, EXT2_S_IFDIR | EXT2_S_RMASK);
		return 0;
	}

	/* this creates very specific files that are continuous and imutable */
	int write_imutable(int ino, const char *buff, int size) {
		DBGSCOPE();
		if (ino < 1 || size <= 0)
			return -1;
		/* modify inode */
		auto [index, ino_off] = get_inob(ino);
		EXT_LOAD_BLK(ino_sect, index, -1);
		auto inode = (inode_t *)(ino_sect.get() + ino_off);
		inode->flags |= EXT2_IMMUTABLE_FL;

		/* find len blocks of specified size in a contiguous zone
		and alloc them */
		int bsize = roundup_div(size, BLK_SIZE);
		int start_blk = -1;
		int grp = 0;
		inode->bsize = 0;
		inode->size = 0;
		for (; grp < grp_cnt(); grp++) {
			bool found = false;
			int curr_bsize = 0;
			int free_idxs = 0;
			int i = 0;
			EXT_LOAD_DESC(desc, grp, -1);
			EXT_LOAD_BLK_BM(sb_blk, grp, -1);
			for (; free_idxs < desc.desc->free_blk_cnt; i++) {
				if (sb_blk.bmap.get(i) == 0) {
					curr_bsize++;
					free_idxs++;
				}
				if (sb_blk.bmap.get(i) != 0) {
					curr_bsize = 0;
				}
				if (curr_bsize == bsize) {
					found = true;
					break;
				}
			}
			desc.sect.unload();
			sb_blk.sect.unload();
			if (found) {
				i = i - bsize + 1;
				for (int j = 0; j < bsize; j++, i++) {
					if ((start_blk = alloc_spec_blk(grp, i)) < 0) {
						DBG("Can't alloc blk for imutable: [grp:%d]rel:%d",
								grp, i);
						ino_sect.unload();
						return -1;
					}
				}
				start_blk = start_blk - bsize + 1;
			}
		}
		if (start_blk < 0) {
			DBG("Didn't find contiguous space for imutable");
			return -1;
		}
		grp--;
		DBG("Adding blocks to imutable: ino: %d start: %d", ino, start_blk);
		if (add_blocks(inode, bsize, grp,
				[&start_blk, this, &grp](){
					return start_blk++;
				}))
		{
			ino_sect.unload();
			return -1;
		}
		inode->bsize = bsize;
		inode->size = size;
		EXT_SAVE_BLK(ino_sect, index, -1);
		DBG("Imutable is set and ready to be written");
		if (write(ino, 0, buff, size) != size) {
			DBG("Failed to write imutable");
			return -1;
		}
		return 0;
	}

	// std::string to_string() {
	// 	std::string ret = "";
	// 	for (int i = 0; i < grp_cnt(); i++) {
	// 		for (int j = 0; j < sup->ino_per_grp; j++) {
	// 			EXT_LOAD_INO_BM(sb_ino, i, "err");
	// 			if (sb_ino.bmap.get(j)) {
	// 				ret += sformat("ino[%d] %s", i * sup->ino_per_grp + j + 1,
	// 						ino_to_str(i * sup->ino_per_grp + j + 1));
	// 			}
	// 			sb_ino.sect.unload();
	// 		}
	// 	}
	// 	return ret;
	// }

	// std::string ino_to_str(int ino) {
	// 	inode_t inode;
	// 	if (getino(ino, &inode))
	// 		return "[err]";
	// 	return ext_ino_str(&inode);
	// }

private:
	int bget_off(inode_t *inode, int off) {
		int i = off / BLK_SIZE;
		int ipb = BLK_SIZE / sizeof(int);
		if (i < 12) {
			// no indir
			return inode->block[i];
		}
		if (12 <= i && i < 12 + ipb)  {
			// one indir
			i -= 12;
			EXT_LOAD_BLK(blk, inode->block[12], -1);
			int ret = ((int *)blk.get())[i];
			blk.unload();
			return ret;
		}
		if (12 + ipb <= i && i < 12 + ipb + ipb*ipb) {
			// two indir
			i -= 12 + ipb;

			EXT_LOAD_BLK(blk_1, inode->block[13], -1);
			int indir1 = ((int *)blk_1.get())[i / ipb];
			blk_1.unload();

			EXT_LOAD_BLK(blk_2, indir1, -1);
			int ret = ((int *)blk_2.get())[i % ipb];
			blk_2.unload();

			return ret;
		}
		if (12 + ipb + ipb*ipb <= i && i < 12 + ipb + ipb*ipb + ipb*ipb*ipb) {
			// three indir
			i -= 12 + ipb + ipb*ipb;

			EXT_LOAD_BLK(blk_1, inode->block[14], -1);
			int indir1 = ((int *)blk_1.get())[i / (ipb * ipb)];
			blk_1.unload();

			EXT_LOAD_BLK(blk_2, indir1, -1);
			int indir2 = ((int *)blk_2.get())[(i / ipb) % ipb];
			blk_2.unload();

			EXT_LOAD_BLK(blk_3, indir2, -1);
			int ret = ((int *)blk_3.get())[i % ipb];
			blk_3.unload();

			return ret;
		}
		return -1;
	}

	template <typename BlkAlloc>
	int add_blocks(inode_t *inode, int cnt, int grp, BlkAlloc&& blk_alloc) {
		auto alloc_indir = [this, &grp] () {
			int blk = alloc_blk(grp);
			if (blk < 0) {
				DBG("Can't alloc block in group!");
				return -1;
			}
			EXT_LOAD_BLK(blk_sect, blk, -1);
			memset(blk_sect.get(), 0, BLK_SIZE);
			EXT_SAVE_BLK(blk_sect, blk, -1);
			return blk;
		};
		auto add =
		[this, &grp, &inode, &alloc_indir, &blk_alloc] (int i) {
			// ints per block
			int ipb = BLK_SIZE / sizeof(int);
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
				EXT_LOAD_BLK(blk1, inode->block[12], -1);
				int *blocks = (int *)blk1.get();
				blocks[i] = blk_alloc();
				EXT_SAVE_BLK(blk1, inode->block[12], -1);
			}
			if (12 + ipb <= i && i < 12 + ipb + ipb*ipb) {
				// two indir
				i -= 12 + ipb;
				if (!inode->block[13]) {
					inode->block[13] = alloc_indir();
					if (inode->block[13] < 0)
						return -1;
				}
				EXT_LOAD_BLK(blk1, inode->block[13], -1);
				int *indir1 = (int *)blk1.get();

				if (!indir1[i / ipb]) {
					indir1[i / ipb] = alloc_indir();
					if (indir1[i / ipb] < 0)
						return -1;
				}

				EXT_LOAD_BLK(blk2, indir1[i / ipb], -1);
				int *blocks = (int *)blk2.get();
				blocks[i % ipb] = blk_alloc();
			
				EXT_SAVE_BLK(blk2, indir1[i / ipb], -1);
				EXT_SAVE_BLK(blk1, inode->block[13], -1);
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

				EXT_LOAD_BLK(blk1, inode->block[14], -1);
				int *indir1 = (int *)blk1.get();

				if (!indir1[i / (ipb*ipb)]) {
					indir1[i / (ipb*ipb)] = alloc_indir();
					if (indir1[i / (ipb*ipb)] < 0)
						return -1;
				}

				EXT_LOAD_BLK(blk2, indir1[i / ipb], -1);
				int *indir2 = (int *)blk2.get();

				if (!indir2[(i / ipb) % ipb]) {
					indir2[(i / ipb) % ipb] = alloc_indir();
					if (indir2[(i / ipb) % ipb] < 0)
						return -1;
				}

				EXT_LOAD_BLK(blk3, indir2[(i / ipb) % ipb], -1);
				int *blocks = (int *)blk3.get();
				blocks[i % ipb] = blk_alloc();

				EXT_SAVE_BLK(blk3, indir2[(i / ipb) % ipb], -1);
				EXT_SAVE_BLK(blk2, indir1[i / ipb], -1);
				EXT_SAVE_BLK(blk1, inode->block[13], -1);
			}
			return 0;
		};
		int inode_bsize = roundup_div(inode->size, BLK_SIZE);
		for (int i = 0; i < cnt; i++)
			if (add(inode_bsize + i) < 0)
				return -1;
		return 0;
	}

	int rem_blocks(inode_t *inode, int cnt) {
		auto rem = [this, &inode] (int i) {
			int ipb = BLK_SIZE / sizeof(int);
			if (i < 12) {
				// no indir
				if (free_blk(inode->block[i]))
					return -1;
				inode->block[i] = 0;
			}
			if (12 <= i && i < 12 + ipb)  {
				// one indir
				i -= 12;

				EXT_LOAD_BLK(blk1, inode->block[12], -1);
				int *blocks = (int *)blk1.get();
				if (free_blk(blocks[i]))
					return -1;
				blocks[i] = 0;
				EXT_SAVE_BLK(blk1, inode->block[12], -1);

				if (i == 0) {
					if (free_blk(inode->block[12]))
						return -1;
					inode->block[12] = 0;
				}
			}
			if (12 + ipb <= i && i < 12 + ipb + ipb*ipb) {
				// two indir
				i -= 12 + ipb;

				EXT_LOAD_BLK(blk1, inode->block[13], -1);
				int *indir1 = (int *)blk1.get();

				EXT_LOAD_BLK(blk2, indir1[i / ipb], -1);
				int *blocks = (int *)blk2.get();

				if (free_blk(blocks[i % ipb]))
					return -1;

				blocks[i % ipb] = 0;

				if (i / ipb == 0) {
					if (free_blk(indir1[i / ipb]))
						return -1;
					indir1[i / ipb] = 0;
				}

				EXT_SAVE_BLK(blk2, indir1[i / ipb], -1);
				EXT_SAVE_BLK(blk1, inode->block[13], -1);

				if (i == 0) {
					if (free_blk(inode->block[13]))
						return -1;
					inode->block[13] = 0;
				}
			}
			if (12 + ipb + ipb*ipb <= i &&
					i < 12 + ipb + ipb*ipb + ipb*ipb*ipb)
			{
				// three indir
				i -= 12 + ipb + ipb*ipb;

				EXT_LOAD_BLK(blk1, inode->block[14], -1);
				int *indir1 = (int *)blk1.get();

				EXT_LOAD_BLK(blk2, indir1[i / ipb], -1);
				int *indir2 = (int *)blk2.get();

				EXT_LOAD_BLK(blk3, indir2[(i / ipb) % ipb], -1);
				int *blocks = (int *)blk3.get();

				if (free_blk(blocks[i % ipb]))
					return -1;

				blocks[i % ipb] = 0;
				if ((i / ipb) % ipb == 0) {
					if (free_blk(indir1[(i / ipb) % ipb]))
						return -1;
					indir1[(i / ipb) % ipb] = 0;
				}
				if (i / (ipb*ipb) == 0) {
					if (free_blk(indir2[i / ipb]))
						return -1;
				}

				EXT_SAVE_BLK(blk3, indir2[(i / ipb) % ipb], -1);
				EXT_SAVE_BLK(blk2, indir1[i / ipb], -1);
				EXT_SAVE_BLK(blk1, inode->block[13], -1);

				if (i == 0) {
					if (free_blk(inode->block[14]))
						return -1;
					inode->block[14] = 0;
				}
			}
			return 0;
		};
		int inode_bsize = roundup_div(inode->size, BLK_SIZE);
		for (int i = cnt - 1; i >= 0; i--)
			if (rem(inode_bsize + i) < 0)
				return -1;
		return 0;
	}

	int alloc_ino(int sugested_grp) {
		EXT_LOAD_DESC(sugested_desc, sugested_grp, -1);
		if (sugested_desc.desc->free_ino_cnt != 0) {
			sugested_desc.sect.unload();
			return alloc_ino_in_grp(sugested_grp);
		}
		else {
			sugested_desc.sect.unload();
			for (int i = 0; i < grp_cnt(); i++) {
				EXT_LOAD_DESC(sd_desc, i, -1);
				if (sd_desc.desc->free_ino_cnt != 0) {
					sd_desc.sect.unload();
					return alloc_ino_in_grp(i);
				}
				sd_desc.sect.unload();
			}
		}
		return -1;
	}

	int free_ino(int ino) {
		if (ino < 1)
			return -1;
		int grp = (ino - 1) / sup->ino_per_grp;
		int rel_ino = (ino - 1) % sup->ino_per_grp;
		auto [blk, off] = get_inob(ino);
		if (blk < 0) {
			DBG("Couldn't get inode block and offset: ino: %d", ino);
			return -1;
		}
		EXT_LOAD_BLK(ino_sect, blk, -1);
		auto inode = (inode_t *)(ino_sect.get() + off);
		if (inode->size != 0) {
			if (rem_blocks(inode, roundup_div(inode->size, BLK_SIZE))) 
			{
				DBG("Couldn't remove blocks from inode: %d", ino);
				ino_sect.unload();
				return -1;
			}
		}
		ino_sect.save(true);

		EXT_LOAD_INO_BM(sb_ino, grp, -1);
		sb_ino.bmap.set(rel_ino, false);
		EXT_SAVE_INO_BM(sb_ino, grp, -1);

		EXT_LOAD_DESC(desc, grp, -1)
		desc.desc->free_ino_cnt++;
		EXT_SAVE_DESC(desc, grp, -1);

		sup->free_ino_cnt++;
		return 0;
	}

	/* returns the block that has that inode and it's offset in that block */
	inob_ret_t get_inob(int ino) {
		int grp = (ino - 1) / sup->ino_per_grp;
		int rel_ino = (ino - 1) % sup->ino_per_grp;
		if (rel_ino < 0 || grp < 0)
			return {-1, -1};

		auto desc = load_desc(grp);
		if (!desc.sect.get()) {
			DBG("[ERROR] Couldn't load descriptor: %d", grp);
			return {-1, -1};
		} 
		int blk = desc.desc->ino_table + rel_ino / (BLK_SIZE / sup->ino_size);
		int off = (rel_ino % (BLK_SIZE / sup->ino_size)) * sizeof(inode_t);
		desc.sect.unload();
		return {blk, off};
	}

	int alloc_blk(int sugested_grp) {
		printf("sugested_grp: %d\n", sugested_grp);
		EXT_LOAD_DESC(sugested_desc, sugested_grp, -1);
		if (sugested_desc.desc->free_blk_cnt != 0) {
			sugested_desc.sect.unload();
			return alloc_blk_in_grp(sugested_grp);
		}
		else {
			sugested_desc.sect.unload();
			for (int i = 0; i < grp_cnt(); i++) {
				EXT_LOAD_DESC(desc, i, -1);
				if (desc.desc->free_blk_cnt != 0) {
					desc.sect.unload();
					return alloc_blk_in_grp(i);
				}
				desc.sect.unload();
			}
		}
		return -1;
	}

	int free_blk(int blk) {
		if (blk < 0)
			return -1;

		int grp = blk / grp_bsize();
		int rel_blk = blk - blk_table(grp);

		EXT_LOAD_BLK_BM(sb_blk, grp, -1);
		sb_blk.bmap.set(rel_blk, false);

		EXT_LOAD_DESC(sd_desc, grp, -1);
		sd_desc.desc->free_blk_cnt++;
		EXT_SAVE_DESC(sd_desc, grp, -1);

		EXT_SAVE_BLK_BM(sb_blk, grp, -1);
		sup->free_blk_cnt++;
		return 0;
	}

	int alloc_blk_in_grp(int grp) {
		EXT_LOAD_BLK_BM(sb_blk, grp, -1);

		int rel_blk = sb_blk.bmap.get_first_free();
		if (sb_blk.bmap.get(rel_blk)) {
			DBG("blk already allocated");
			return -1;
		}
		sb_blk.bmap.set(rel_blk, true);

		EXT_LOAD_DESC(sd_desc, grp, -1);
		sd_desc.desc->free_blk_cnt--;
		EXT_SAVE_DESC(sd_desc, grp, -1);
		
		EXT_SAVE_BLK_BM(sb_blk, grp, -1);
		sup->free_blk_cnt--;
		
		printf("add block: %d\n", rel_blk + blk_table(grp));
		return rel_blk + blk_table(grp);
	}

	int alloc_spec_blk(int grp, int rel_blk) {
		EXT_LOAD_BLK_BM(sb_blk, grp, -1);
		if (sb_blk.bmap.get(rel_blk)) {
			DBG("blk already allocated");
			return -1;
		}
		sb_blk.bmap.set(rel_blk, true);

		EXT_LOAD_DESC(sd_desc, grp, -1);
		sd_desc.desc->free_blk_cnt--;
		EXT_SAVE_DESC(sd_desc, grp, -1);

		EXT_SAVE_BLK_BM(sb_blk, grp, -1);
		sup->free_blk_cnt--;
		printf("sepc add block: %d\n", rel_blk + blk_table(grp));
		return rel_blk + blk_table(grp);
	}

	int alloc_ino_in_grp(int grp) {
		EXT_LOAD_INO_BM(sb_ino, grp, -1);
		int rel_ino = sb_ino.bmap.get_first_free();
		sb_ino.bmap.set(rel_ino, true);
		sup->free_ino_cnt--;
		int ino = rel_ino + grp * sup->ino_per_grp + 1;

		EXT_LOAD_DESC(sd_desc, grp, -1);
		sd_desc.desc->free_ino_cnt--;
		EXT_SAVE_DESC(sd_desc, grp, -1);

		EXT_SAVE_INO_BM(sb_ino, grp, -1);
		return ino;
	}

	int fill_ino(int ino, int mode = 0, int gid = 0, int uid = 0)
	{
		auto [index, off] = get_inob(ino);
		EXT_LOAD_BLK(blk, index, -1);
		auto inode = (inode_t *)(blk.get() + off);
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
		EXT_SAVE_BLK(blk, index, -1);
		return 0;
	}

	int get_ino_baddr(int ino) {
		if (ino < 1)
			return -1;
		int grp = (ino - 1) / sup->ino_per_grp;
		int idx = (ino - 1) % sup->ino_per_grp;
		EXT_LOAD_DESC(desc, grp, -1);
		int ret = desc.desc->ino_table + idx / (BLK_SIZE / sup->ino_size);
		desc.sect.unload();
		return ret;
	}

	int blk_table(int grp) {
		EXT_LOAD_DESC(desc, grp, -1);
		int ret = desc.desc->ino_table +
				roundup_div(sup->ino_size * sup->ino_per_grp, BLK_SIZE);
		desc.sect.unload();
		return ret;
	}

	int grp_bsize() {
		return roundup_div(grp_cnt() * 32, BLK_SIZE) +
				3 + sup->ino_per_grp * sup->ino_size / BLK_SIZE +
				sup->blk_per_grp;
	}
};

#endif