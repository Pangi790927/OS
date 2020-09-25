#ifndef EXT2_H
#define EXT2_H

#include "ext2defs.h"
#include "round_util.h"
#include "bitmap.h"
#include "inodes.h"
#include "dirs.h"
#include "uuid.h"
#include "except.h"


inline uint32_t log2_int(uint32_t num) {
	uint32_t res = 0;
	while (num != 1) {
		res++;
		num >>= 1;
	}
	return res;
}

class Ext2 {
public:
	ExtDev &ext_dev;
	ExtDev::Sector sup_sector;

	ext2_sup_t *sup;
	uint32_t blk_cnt;

	Inodes inodes;
	Dirs dirs;

	Ext2(ExtDev &ext_dev, uint32_t blk_cnt)
	: ext_dev(ext_dev), blk_cnt(blk_cnt),
			inodes(
					ext_dev,
					sup,
					(void *)this,
					load_desc,
					load_ino_bmap,
					load_blk_bmap),
			dirs(inodes)
	{
		DBGSCOPE();
		if (blk_cnt < 64)
			EXCEPTION("I refuse tu use such a small filesystem, go away: %d",
					blk_cnt);
		DBG("blk cnt: %d", blk_cnt)
	}

	~Ext2() {}

	int init() {
		DBGSCOPE();
		DBG("Reading superblock");
		sup_sector = ext_move(ext_dev.get_sect(1));
		sup = (ext2_sup_t *)sup_sector.get();
		if (!sup)
			return -1;
		return 0;
	}

	void uninit() {
		DBGSCOPE();
		sup_sector.unload();	
	}

	int check_fs() {
		DBGSCOPE();
		if (sup->log_blk_size != 0) {
			DBG("Block size must be 1024, if you want more implement it!");
			return -1;
		}
		/* more to do */
		return 0;
	}

	int create_fs() {
		DBGSCOPE();
		memset((void *)sup, 0, sizeof(ext2_sup_t));
		sup_sector.save(false);

		init_per_grp_stats(sup, blk_cnt);

		sup->reserved_blk_cnt = 0;
		sup->free_blk_cnt = sup->blk_cnt;
		sup->free_ino_cnt = sup->ino_cnt;

		sup->first_data_blk = 1;	// allways 1 for us
		sup->log_blk_size = log2_int(BLK_SIZE) - 10;
		sup->log_frag_size = 0;
		sup->frag_per_grp = sup->blk_per_grp;

		sup->mtime = 0;
		sup->wtime = 0;
		sup->mnt_cnt = 0;
		sup->max_mnt_cnt = 0x7fff;

		sup->magic = EXT2_SUPER_MAGIC;
		sup->state = EXT2_VALID_FS;
		sup->errors = EXT2_ERRORS_CONTINUE;

		sup->rev_level = 1;
		sup->minor_rev_level = 0;

		sup->last_check = 0;
		sup->check_interval = 0x7fff'ffff;
		sup->creator_os = EXT2_OS_OS;
		sup->default_resuid = EXT2_DEF_RESUID;
		sup->default_resgid = EXT2_DEF_RESGID;

		/* ext2 revision specific */
		sup->ino_size = EXT2_GOOD_OLD_INODE_SIZE;
		sup->first_ino = EXT2_GOOD_OLD_FIRST_INO;

		/* used for backup */
		sup->blk_grp_nr = sup->first_data_blk;

		sup->feature_compat = 0;
		sup->feature_incompat = 0;
		sup->feature_ro_compat = 0;
		strcpy((char *)sup->volume_name, "os_start_volume");
		create_uuid((char *)sup->uuid, sizeof(sup->uuid));
		sup->algo_bitmap = 0;

		DBG("Init groups");
		if (init_groups() != 0) {
			DBG("Can't init groups");
			return -1;
		}

		DBG("Create reserved inodes");
		if (inodes.alloc_reserved_inodes()) {
			DBG("Can't create reserved inodes");
			return -1;
		}
		if (dirs.init_dir(2)) {
			DBG("Can't init root inode");
			return -1;
		}
		if (dirs.add_file(2, 2, ".")) {
			DBG("Can't add '.' to root inode");
			return -1;
		}
		if (dirs.add_file(2, 2, "..")) {
			DBG("Can't add '..' to root inode");
			return -1;
		}
		if (dirs.init_dir(11)) {
			DBG("Can't init lost+found inode");
			return -1;
		}
		if (dirs.add_file(11, 11, ".")) {
			DBG("Can't add '.' to root inode");
			return -1;
		}
		if (dirs.add_file(11, 2, "..")) {
			DBG("Can't add '..' to root inode");
			return -1;
		}

		return 0;
	}

	int commit_backups() {
		DBGSCOPE();
		if (sup_sector.save(false) != 0) {
			DBG("Failed to commit back superblock");
			return -1;
		}
		for (uint32_t i = 1; i < grp_cnt(); i++) {
			for (uint32_t j = 0; j < desc_bsize(); j++) {
				auto blk_orig = ext_dev.get_sect(1 + j);
				auto blk_back = ext_dev.get_sect(1 + i * grp_bsize() + j);

				if (!blk_orig.get()) {
					DBG("Failed to load orig blk: %d at steps: %d", j, i);
					return -1;
				}

				if (!blk_back.get()) {
					DBG("Failed to load backup blk: %d at step: %d", j, i);
					return -1;
				}

				memcpy(blk_back.get(), blk_orig.get(), BLK_SIZE);

				blk_orig.unload();
				if (blk_back.save(true) != 0) {
					DBG("Failed to save backup blk: %d at step: %d", j, i);
					return -1;
				}
			}
		}

		return 0;
	}

	static SectorDesc load_desc(void *c, int i) {
		return ((Ext2 *)c)->load_desc(i);
	}

	SectorDesc load_desc(int i) {
		SectorDesc ret;
		const int desc_in_blk = BLK_SIZE / sizeof(blk_grp_desc_t);
		const int grp_blk_index = roundup_div(i, desc_in_blk);
		ret.sect = ext_dev.get_sect(2 + grp_blk_index);
		if (!ret.sect.get())
			return ret;
		ret.desc = (blk_grp_desc_t *)ret.sect.get() +
				sizeof(blk_grp_desc_t) * (i % desc_in_blk);
		return ret;
	}

	static SectorBitmap load_ino_bmap(void *c, int i) {
		return ((Ext2 *)c)->load_ino_bmap(i);
	}

	SectorBitmap load_ino_bmap(int i) {
		auto desc = load_desc(i);
		int bmap_ino = desc.desc->ino_bitmap;
		desc.sect.unload();

		SectorBitmap ret;
		ret.sect = ext_dev.get_sect(bmap_ino);
		if (!ret.sect.get())
			return ret;
		ret.bmap = Bitmap(ret.sect.get(), BLK_SIZE);
		return ret;
	}

	static SectorBitmap load_blk_bmap(void *c, int i) {
		return ((Ext2 *)c)->load_blk_bmap(i);
	}

	SectorBitmap load_blk_bmap(int i) {
		auto desc = load_desc(i);
		int bmap_blk = desc.desc->blk_bitmap;
		desc.sect.unload();

		SectorBitmap ret;
		ret.sect = ext_dev.get_sect(bmap_blk);
		if (!ret.sect.get())
			return ret;
		ret.bmap = Bitmap(ret.sect.get(), BLK_SIZE);
		return ret;
	}

	int init_groups() {
		DBGSCOPE();
		/* now we will add in each descriptor the group that it references */
		uint32_t free_ino = sup->ino_cnt;
		uint32_t free_blk = sup->blk_cnt;
		for (uint32_t i = 0; i < grp_cnt(); i++) {
			auto sd = load_desc(i);
			if (!sd.sect.get()) {
				DBG("Couldn't load desc: %d", i);
				sd.sect.unload();
				return -1;
			}
			sd.desc->ino_bitmap = 2 + desc_bsize() + i * grp_bsize();
			sd.desc->blk_bitmap = 3 + desc_bsize() + i * grp_bsize();
			sd.desc->ino_table = 4 + desc_bsize() + i * grp_bsize();
			sd.desc->used_dir_cnt = 0;

			sd.desc->free_blk_cnt = ext_min(free_blk, (uint32_t)BLK_SIZE * 8);
			free_blk -= BLK_SIZE * 8;
			sd.desc->free_ino_cnt = ext_min(free_ino, (uint32_t)BLK_SIZE * 8);
			free_ino -= BLK_SIZE * 8;

			if (sd.sect.save(true) != 0) {
				DBG("Couldn't save desc: %d", i);
				return -1;
			}

			auto bm_ino = load_ino_bmap(i);
			if (!bm_ino.sect.get()) {
				DBG("Couldn't load inode bitmap: %d", i);
				return -1;
			}

			memset((char *)bm_ino.sect.get(), 0, BLK_SIZE);

			if (bm_ino.sect.save(true) != 0) {
				DBG("Couldn't save inode bitmap: %d", i);
				return -1;
			}
			
			auto bm_blk = load_blk_bmap(i);
			if (!bm_blk.sect.get()) {
				DBG("Couldn't load block bitmap: %d", i);
				return -1;
			}

			memset((char *)bm_blk.sect.get(), 0, BLK_SIZE);

			if (bm_blk.sect.save(true) != 0) {
				DBG("Couldn't save inode bitmap: %d", i);
				return -1;
			}
		}
		return 0;
	}

	uint32_t grp_cnt() {
		if (roundup_div(sup->ino_cnt, sup->ino_per_grp) !=
				roundup_div(sup->blk_cnt, sup->blk_per_grp))
		{
			EXCEPTION("grp_cnt generated by ino_cnt and blk_cnt must match");
		}
		return roundup_div(sup->ino_cnt, sup->ino_per_grp);
	}

	/* returns size of group in BLK_SIZE units */
	uint32_t grp_bsize() {
		return 3 + desc_bsize() + sup->ino_per_grp * sup->ino_size / BLK_SIZE +
				sup->blk_per_grp;
	}

	/* returns size of group descriptor array in blocks */
	uint32_t desc_bsize() {
		return roundup_div(grp_cnt() * sizeof(blk_grp_desc_t), BLK_SIZE);
	}

	void init_per_grp_stats(ext2_sup_t *sup, uint32_t blk_cnt) {
		DBGSCOPE();
		/* this funcion only fills those:
			sup->blk_cnt = 0;
			sup->ino_cnt = 0;
			sup->ino_per_grp = 0;
			sup->blk_per_grp = 0;
		*/

		/* to have a reason to create more groups we need to max out the two
		bitmaps at least, the inode bitmap and the block bitmap, +9 comes
		from 4 bitmaps, 2 superblocks 2 group tables and at least some dataa
		in the next group */
		uint32_t min_to_create_more = BLK_SIZE * 8 +
				BLK_SIZE * 8 * INO_SIZE / BLK_SIZE + 9;

		uint32_t ino_per_blk = BLK_SIZE / INO_SIZE;
		if (blk_cnt < min_to_create_more) {
			/* when we can't max out both bitmaps we asume there is one inode
			for every 4 blocks */

			/* superblock, desc grp table, bitmaps */ 
			uint32_t usable_blks_cnt = blk_cnt - 4;

			/* for each inode we add 4 blocks and the block that holds the indes
			we take all the blocks we have left and divide them by this number
			*/
			uint32_t ino_blk_pairs = usable_blks_cnt / (ino_per_blk * 4 + 1);

			sup->blk_cnt = ino_blk_pairs * ino_per_blk * 4;
			sup->ino_cnt = ino_blk_pairs * ino_per_blk;
			sup->blk_per_grp = sup->blk_cnt;
			sup->ino_per_grp = sup->ino_cnt;
		}
		else {
			// this will stay here so I don't have to pull my hair out later
			// wondering what broke
			EXCEPTION("WIP: probably implemented but not tested");
			/* let gc be the group count, if we know we want to have
			BLK_SIZE * 8 blocks/grp and BLK_SIZE * 8 inodes/grp and we know
			that a descriptor uses 32 bytes of memory we will have a total
			memory usage of
				blk_cnt = (BLK_SIZE * 8 + BLK_SIZE * 8 * INO_SIZE / BLK_SIZE +
					3 + gc * 32 / BLK_SIZE) * gc		(1)
			we will make the following notations:
				mem = blk_cnt
				alpha = BLK_SIZE * 8 + BLK_SIZE * 8 * INO_SIZE / BLK_SIZE + 3
				beta = 32 / BLK_SIZE
			after we replace those in (1) we get:
				mem = (alpha + gc * beta) * gc
			or 
				-mem + alpha * gc + beta * gc^2 = 0
			we can solve this to get:
				gc = (-alpha +/- sqrt(alpha^2 - 4 * -mem * beta)) / (2 * beta)
			we can see that alpha^2 - 4 * -mem * beta will be allways positive
			and larger than alpha^2, but we need the nominator to be positive so
			we will chose only the solution
				gc = (-alpha + sqrt(alpha^2 + 4 * mem * beta)) / (2 * beta)
			*/
			double alpha = BLK_SIZE * 8 + BLK_SIZE * 8 * INO_SIZE / BLK_SIZE + 3;
			double beta = 32.0 / BLK_SIZE;
			double mem = blk_cnt;
			double gc = (-alpha + sqrt(alpha * alpha + 4.0 * mem * beta)) /
					(2.0 * beta);

			uint32_t grp_cnt = gc;

			sup->blk_cnt = BLK_SIZE * 8 * grp_cnt;
			sup->ino_cnt = BLK_SIZE * 8 * grp_cnt;
			sup->blk_per_grp = BLK_SIZE * 8;
			sup->ino_per_grp = BLK_SIZE * 8;

			/* we try to find out if we should make another group with less mem
			than a normal group, if this other group would increase our memory
			after the specified limit or it can't hold more than 64 blocks we
			ignore it */
			uint32_t used_blk_cnt =  grp_cnt * (BLK_SIZE * 8 +
				BLK_SIZE * 8 * INO_SIZE / BLK_SIZE + 3) +
				roundup_div(grp_cnt * 32, BLK_SIZE);
			uint32_t added_if_more_grps = grp_cnt * (roundup_div((grp_cnt + 1) *
							32, BLK_SIZE) - roundup_div(grp_cnt * 32,
							BLK_SIZE)) +
					roundup_div((grp_cnt + 1) * 32, BLK_SIZE) + 3;
			if (blk_cnt - used_blk_cnt >= added_if_more_grps + 64)
			{
				grp_cnt++;
				used_blk_cnt += added_if_more_grps;
				
				uint32_t usable_blks_cnt = blk_cnt - used_blk_cnt;
				sup->ino_cnt += ext_min(sup->ino_per_grp, usable_blks_cnt);
				usable_blks_cnt -= ext_min(sup->ino_per_grp, usable_blks_cnt);
				sup->blk_cnt += usable_blks_cnt;

			}
			if (grp_cnt != roundup_div(sup->blk_cnt, sup->blk_per_grp))
				EXCEPTION("Something went wrong in code");
			if (grp_cnt != roundup_div(sup->ino_cnt, sup->ino_per_grp))
				EXCEPTION("Something went wrong in code");
		}
		DBG("resulting grp stats: blk: %d, ino: %d, blk/grp: %d, ino/grp: %d",
				sup->blk_cnt, sup->ino_cnt, sup->blk_per_grp, sup->ino_per_grp);
	}

	// uint64_t blk2faddr(uint32_t blk) {
	// 	return blk * blk_size();
	// }

	// uint64_t blk_size() {
	// 	return 1 << (sup->log_blk_size + 10);
	// }

	// std::string to_string() {
	// 	std::string ret = sformat("%s\n", ext_sup_str(sup));
	// 	ret += sformat("%s\n", ext_grp_table_str(desc_table, grp_cnt()));
	// 	for (int i = 0; i < grp_cnt(); i++) {
	// 		ret += sformat("ino_bitmap[%d]:\n%s\n",
	// 				i, ext_bitmap_str(ino_bitmaps[i]));
	// 		ret += sformat("blk_bitmap[%d]:\n%s\n",
	// 				i, ext_bitmap_str(blk_bitmaps[i]));
	// 	}
	// 	ret += sformat("inodes: %s\n", inodes.to_string().c_str());
	// 	ret += sformat("Reading root inode: \n");
	// 	dirs.listdir("/", [&](auto a) {
	// 		ret += sformat("%s  ", a.name);
	// 	});
	// 	ret += "\n";
	// 	return ret;
	// }
};

#endif