#ifndef EXT2_H
#define EXT2_H

#include <cmath>
#include "ext2defs.h"
#include "ext2dev.h"
#include "round_util.h"
#include "bitmap.h"
#include "inodes.h"
#include "dirs.h"
#include "to_str.h"
#include "uuid.h"
#include "hexdump.h"

inline uint32_t log2_int(uint32_t num) {
	uint32_t res = 0;
	while (num != 1) {
		res++;
		num >>= 1;
	}
	return res;
}

struct lazy_commit_t {
	void *from = NULL;
	uint64_t faddr = 0;
	uint64_t size = 0;
};

class Ext2 {
public:
	Ext2Dev ext2dev;
	ext2_sup_t *sup;
	blk_grp_desc_t *desc_table;
	uint32_t blk_cnt;
	Inodes inodes;
	Dirs dirs;
	std::vector<Bitmap> ino_bitmaps;
	std::vector<Bitmap> blk_bitmaps;
	std::vector<lazy_commit_t> lazy_commit;

	Ext2(Dev &dev, uint32_t sect_start, uint32_t sect_cnt)
	: blk_cnt(sect_cnt / (BLK_SIZE / SECTOR_SZ)),
			ext2dev(dev, sect_start, sect_cnt),
			inodes(ext2dev, ino_bitmaps, blk_bitmaps, sup, desc_table),
			dirs(inodes)
	{
		if (blk_cnt < 64)
			EXCEPTION("I refuse tu use such a small filesystem, go away: %d",
					blk_cnt);
	}

	~Ext2() {
		commit_backups();
	}

	int create_fs() {
		printf("Reading superblock\n");
		sup = ext2dev.load<ext2_sup_t>(1024, sizeof(ext2_sup_t));
		if (!sup)
			return -1;
		memset((void *)sup, 0, sizeof(ext2_sup_t));

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

		printf("Init groups\n");
		init_groups();
		printf("Load bitmaps\n");
		load_bitmaps(true);
		register_backups();

		printf("Create reserved inodes\n");
		if (inodes.alloc_reserved_inodes()) {
			printf("Can't create reserved inodes\n");
			return -1;
		}
		if (dirs.add_file(2, 2, ".", EXT2_FT_DIR)) {
			printf("Can't add '.' to root inode\n");
			return -1;
		}
		if (dirs.add_file(2, 2, "..", EXT2_FT_DIR)) {
			printf("Can't add '..' to root inode\n");
			return -1;
		}

		return 0;
	}

	void read_fs() {
		/* because this is fairly complex we will asume the easiest to
		read/write file system. That means:
			- BLK_CNT allways 1024
			- all groups have a backup
		*/
		sup = ext2dev.load<ext2_sup_t>(blk2faddr(1), sizeof(ext2_sup_t));
		desc_table = ext2dev.load<blk_grp_desc_t>(blk2faddr(2),
						sizeof(blk_grp_desc_t) * grp_cnt());
		load_bitmaps(false);
		register_backups();
	}

	void register_backups() {
		/* we will schedule all superblocks for a later commit to file */
		for (int i = 0; i < grp_cnt(); i++)
			lazy_commit.push_back({
				.from = sup,
				.faddr = blk2faddr(1 + i * grp_bsize()),
				.size = sizeof(ext2_sup_t)
			});

		/* we will register all desc table backups for a later commit */
		for (int i = 0; i < grp_cnt(); i++)
			lazy_commit.push_back({
				.from = desc_table,
				.faddr = blk2faddr(2 + i * grp_bsize()),
				.size = sizeof(blk_grp_desc_t) * grp_cnt()
			});
	}

	void commit_backups() {
		for (auto &&lc : lazy_commit)
			ext2dev.write(lc.from, lc.faddr, lc.size);
	}

	void init_groups() {
		// we know that if we are building this fs first descriptor table will
		// be at block 2
		desc_table = ext2dev.load<blk_grp_desc_t>(blk2faddr(2),
						sizeof(blk_grp_desc_t) * grp_cnt());

		

		/* now we will add in each descriptor the group that it references */
		uint32_t free_ino = sup->ino_cnt;
		uint32_t free_blk = sup->blk_cnt;
		for (int i = 0; i < grp_cnt(); i++) {
			desc_table[i].ino_bitmap = 2 + desc_bsize() + i * grp_bsize();
			desc_table[i].blk_bitmap = 3 + desc_bsize() + i * grp_bsize();
			desc_table[i].ino_table = 4 + desc_bsize() + i * grp_bsize();
			desc_table[i].used_dir_cnt = 0;

			desc_table[i].free_blk_cnt = 
					std::min(free_blk, (uint32_t)BLK_SIZE * 8);
			free_blk -= BLK_SIZE * 8;
			desc_table[i].free_ino_cnt = 
					std::min(free_ino, (uint32_t)BLK_SIZE * 8);
			free_ino -= BLK_SIZE * 8;
		}
	}

	void load_bitmaps(bool commit) {
		for (int i = 0; i < grp_cnt(); i++) {
			uint8_t *ino = ext2dev.load<uint8_t>(
					blk2faddr(desc_table[i].ino_bitmap), BLK_SIZE);
			uint8_t *blk = ext2dev.load<uint8_t>(
					blk2faddr(desc_table[i].blk_bitmap), BLK_SIZE);
			memset((char *)ino, 0, BLK_SIZE);
			memset((char *)blk, 0, BLK_SIZE);
			ino_bitmaps.emplace_back(ino, BLK_SIZE);
			blk_bitmaps.emplace_back(blk, BLK_SIZE);
			if (commit) {
				lazy_commit.push_back({
					.from = ino,
					.faddr = blk2faddr(desc_table[i].ino_bitmap),
					.size = BLK_SIZE
				});
				lazy_commit.push_back({
					.from = blk,
					.faddr = blk2faddr(desc_table[i].blk_bitmap),
					.size = BLK_SIZE
				});
			}
		}
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
		return roundup_div(grp_cnt() * 32, BLK_SIZE);
	}

	void init_per_grp_stats(ext2_sup_t *sup, uint32_t blk_cnt) {
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
				sup->ino_cnt += std::min(sup->ino_per_grp, usable_blks_cnt);
				usable_blks_cnt -= std::min(sup->ino_per_grp, usable_blks_cnt);
				sup->blk_cnt += usable_blks_cnt;

			}
			if (grp_cnt != roundup_div(sup->blk_cnt, sup->blk_per_grp))
				EXCEPTION("Something went wrong in code");
			if (grp_cnt != roundup_div(sup->ino_cnt, sup->ino_per_grp))
				EXCEPTION("Something went wrong in code");
		}
	}

	uint64_t blk2faddr(uint32_t blk) {
		return blk * blk_size();
	}

	uint64_t blk_size() {
		return 1 << (sup->log_blk_size + 10);
	}

	std::string to_string() {
		std::string ret = sformat("%s\n", ext_sup_str(sup));
		ret += sformat("%s\n", ext_grp_table_str(desc_table, grp_cnt()));
		for (int i = 0; i < grp_cnt(); i++) {
			ret += sformat("ino_bitmap[%d]:\n%s\n",
					i, ext_bitmap_str(ino_bitmaps[i]));
			ret += sformat("blk_bitmap[%d]:\n%s\n",
					i, ext_bitmap_str(blk_bitmaps[i]));
		}
		ret += sformat("inodes: %s\n", inodes.to_string().c_str());
		ret += sformat("Reading root inode: \n");
		dirs.listdir("/", [&](auto a) {
			ret += sformat("%s  ", a.name);
		});
		ret += "\n";
		return ret;
	}
};

#endif