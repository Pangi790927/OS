#ifndef EXT2DEFS_H
#define EXT2DEFS_H

#define BLK_SIZE 1024

/* I usually don't use defines for naming constants but I'm taking those from
some documentation and look what names they have. I couldn't pass this
oportunity to increase the compatibility with linux */

/* revision */
#define EXT2_GOOD_OLD_REV					0
#define EXT2_DYNAMIC_REV					1 

/* magic */
#define EXT2_SUPER_MAGIC					0xEF53

/* state */
#define EXT2_VALID_FS						1
#define EXT2_ERROR_FS						2

/* errors */
#define EXT2_ERRORS_CONTINUE				1
#define EXT2_ERRORS_RO						2
#define EXT2_ERRORS_PANIC					3

/* creator os */
#define EXT2_OS_LINUX						0
#define EXT2_OS_HURD						1
#define EXT2_OS_MASIX						2
#define EXT2_OS_FREEBSD						3
#define EXT2_OS_LITES						4
#define EXT2_OS_OS							5

/* default uid/gid */
#define EXT2_DEF_RESUID						0
#define EXT2_DEF_RESGID						0

/* first inode */
#define EXT2_GOOD_OLD_FIRST_INO 			11

/* inode size */
#define EXT2_GOOD_OLD_INODE_SIZE			128
#define INO_SIZE							EXT2_GOOD_OLD_INODE_SIZE

#define EXT2_FEATURE_COMPAT_DIR_PREALLOC	0x0001
#define EXT2_FEATURE_COMPAT_IMAGIC_INODES	0x0002
#define EXT3_FEATURE_COMPAT_HAS_JOURNAL		0x0004
#define EXT2_FEATURE_COMPAT_EXT_ATTR		0x0008
#define EXT2_FEATURE_COMPAT_RESIZE_INO		0x0010
#define EXT2_FEATURE_COMPAT_DIR_INDEX		0x0020

#define EXT2_FEATURE_INCOMPAT_COMPRESSION	0x0001
#define EXT2_FEATURE_INCOMPAT_FILETYPE		0x0002
#define EXT3_FEATURE_INCOMPAT_RECOVER		0x0004
#define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008
#define EXT2_FEATURE_INCOMPAT_META_BG		0x0010

#define EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
#define EXT2_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
#define EXT2_FEATURE_RO_COMPAT_BTREE_DIR	0x0004

#define EXT2_LZV1_ALG						0
#define EXT2_LZRW3A_ALG						1
#define EXT2_GZIP_ALG						2
#define EXT2_BZIP2_ALG						3
#define EXT2_LZO_ALG						4

#define EXT2_S_IFSOCK						0xC000 // socket
#define EXT2_S_IFLNK						0xA000 // symbolic link
#define EXT2_S_IFREG						0x8000 // regular file
#define EXT2_S_IFBLK						0x6000 // block device
#define EXT2_S_IFDIR						0x4000 // directory
#define EXT2_S_IFCHR						0x2000 // character device
#define EXT2_S_IFIFO						0x1000 // fifo

#define EXT2_S_IRUSR						0x0100 // user read
#define EXT2_S_IWUSR						0x0080 // user write
#define EXT2_S_IXUSR						0x0040 // user execute
#define EXT2_S_IRGRP						0x0020 // group read
#define EXT2_S_IWGRP						0x0010 // group write
#define EXT2_S_IXGRP						0x0008 // group execute
#define EXT2_S_IROTH						0x0004 // others read
#define EXT2_S_IWOTH						0x0002 // others write
#define EXT2_S_IXOTH						0x0001 // others execute
#define EXT2_S_RMASK						0x01ff // all

#define EXT2_FT_UNKNOWN						0
#define EXT2_FT_REG_FILE					1
#define EXT2_FT_DIR 						2
#define EXT2_FT_CHRDEV 						3
#define EXT2_FT_BLKDEV 						4
#define EXT2_FT_FIFO 						5
#define EXT2_FT_SOCK 						6
#define EXT2_FT_SYMLINK						7

#define EXT2_SECRM_FL						0x00000001 // secure deletion
#define EXT2_UNRM_FL						0x00000002 // record for undelete
#define EXT2_COMPR_FL						0x00000004 // compressed file
#define EXT2_SYNC_FL						0x00000008 // synchronous updates
#define EXT2_IMMUTABLE_FL					0x00000010 // immutable file
#define EXT2_APPEND_FL						0x00000020 // append only
#define EXT2_NODUMP_FL						0x00000040 // do not delete file
#define EXT2_NOATIME_FL						0x00000080 // do not update .i_atime
#define EXT2_DIRTY_FL						0x00000100 // dirty
#define EXT2_COMPRBLK_FL					0x00000200 // compressed blocks
#define EXT2_NOCOMPR_FL						0x00000400 // access raw data
#define EXT2_ECOMPR_FL						0x00000800 // compression error
#define EXT2_BTREE_FL						0x00001000 // b-tree format dir
#define EXT2_INDEX_FL						0x00001000 // Hash indexed dir
#define EXT2_IMAGIC_FL						0x00002000 // ?
#define EXT3_JOURNAL_DATA_FL				0x00004000 // journal file data

struct ext2_sup_t {
	/* main ext2 superblock */
	union {
		struct {
			uint32_t ino_cnt;
			uint32_t blk_cnt;
			uint32_t reserved_blk_cnt;
			uint32_t free_blk_cnt;
			uint32_t free_ino_cnt;
			uint32_t first_data_blk;
			uint32_t log_blk_size;
			uint32_t log_frag_size;
			uint32_t blk_per_grp;
			uint32_t frag_per_grp;
			uint32_t ino_per_grp;
			uint32_t mtime;
			uint32_t wtime;
			uint16_t mnt_cnt;
			uint16_t max_mnt_cnt;
			uint16_t magic;
			uint16_t state;
			uint16_t errors;
			uint16_t minor_rev_level;
			uint32_t last_check;
			uint32_t check_interval;
			uint32_t creator_os;
			uint32_t rev_level;
			uint16_t default_resuid;
			uint16_t default_resgid;

			/* ext2 revision specific */
			uint32_t first_ino;
			uint16_t ino_size;
			uint16_t blk_grp_nr;
			uint32_t feature_compat;
			uint32_t feature_incompat;
			uint32_t feature_ro_compat;
			uint8_t uuid[16];
			uint8_t volume_name[16];
			uint8_t last_mounted[64];
			uint32_t algo_bitmap;

			/* performance hints */
			uint8_t prealloc_blks;
			uint8_t prealloc_dir_blks;
			uint16_t allignment1;

			/* journaling support */
			uint8_t journal_uuid[16];
			uint32_t journal_ino_id;
			uint32_t journal_dev;
			uint32_t last_orphan;

			/* directory indexing support */
			uint32_t hash_seed[4];
			uint8_t default_hash_version;
			uint8_t allignment2;

			/* other options */
			uint32_t default_mount_options;
			uint32_t first_meta_blk_grp;
		} __attribute__((__packed__));
		uint8_t data[1024] = {0};
	};
} __attribute__((__packed__));

struct blk_grp_desc_t {
	uint32_t blk_bitmap = 0;
	uint32_t ino_bitmap = 0;
	uint32_t ino_table = 0;
	uint16_t free_blk_cnt = 0;
	uint16_t free_ino_cnt = 0;
	uint16_t used_dir_cnt = 0;
	uint16_t padd = 0;
	uint8_t reserved[12];
} __attribute__((__packed__));

struct inode_t {
	uint16_t mode;
	uint16_t uid;
	uint32_t size;
	uint32_t atime;
	uint32_t ctime;
	uint32_t mtime;
	uint32_t dtime;
	uint16_t gid;
	uint16_t links_cnt;
	uint32_t bsize;
	uint32_t flags;
	uint8_t osd1[4];
	uint32_t block[15];
	uint32_t generation;
	uint32_t file_acl;
	uint32_t dir_acl;
	uint32_t faddr;
	uint8_t osd2[12];
} __attribute__((__packed__));

struct block_t {
	uint8_t data[BLK_SIZE];
} __attribute__((__packed__));;

struct ext2_indir_t {
	uint32_t block[BLK_SIZE / 4];
} __attribute__((__packed__));

/* name should be 4byte aligned so that dir_entry_t will also be aligned */
struct dir_entry_t {
	uint32_t ino = -1;
	uint16_t next = sizeof(dir_entry_t);
	uint8_t name_len;
	uint8_t file_type;
	uint8_t name[248] = {0};
} __attribute__((__packed__));

#endif