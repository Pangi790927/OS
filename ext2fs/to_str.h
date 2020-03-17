#ifndef TO_STR_H
#define TO_STR_H

#include <vector>
#include <string>
#include <cstring>

#include "bitmap.h"
#include "str_utils.h"

std::string mbr_part_str(mbr_part_t& part) {
	return sformat(R"(
	partition{
		bit-field: %x,
		sig1:      %x,
		sig2:      %x,
		sys_id:    %x
	}
	)",
		part.bit_field,
		part.sig1,
		part.sig2,
		part.sys_id
	);
}

std::string mbr_str (mbr_hdr_t& mbr_hdr) {
	return sformat(R"(
mbr_hdr {
	disk-sig:   %x,
	boot-sig:   %x,
	part1:      %s,
	part2:      %s,
	part3:      %s,
	part4:      %s,
}
	)",
		mbr_hdr.disk_sig,
		mbr_hdr.boot_sig,
		mbr_part_str(mbr_hdr.part1),
		mbr_part_str(mbr_hdr.part2),
		mbr_part_str(mbr_hdr.part3),
		mbr_part_str(mbr_hdr.part4)
	);
}

std::string gpt_str(gpt_hdr_t& gpt_hdr) {
	return sformat(R"(
gpt_hdr {
	sig:        %c%c%c%c%c%c%c%c,
	rev:        %d,
	hdr_sz:     %d,
	hdr_crc:    %x,
	curr_lba:   %d,
	backup:     %d,
	first:      %d,
	last:       %d,
	part_arr:   %d,
	part_cnt:   %d
	part_sz:    %d,
	part_crc:   %x,
}
	)", 
		gpt_hdr.sig[0], gpt_hdr.sig[1], gpt_hdr.sig[2], gpt_hdr.sig[3],
		gpt_hdr.sig[4], gpt_hdr.sig[5], gpt_hdr.sig[6], gpt_hdr.sig[7],
		gpt_hdr.rev,
		gpt_hdr.hdr_sz,
		gpt_hdr.hdr_crc,
		gpt_hdr.curr_lba,
		gpt_hdr.backup_lba,
		gpt_hdr.first_part_lba,
		gpt_hdr.last_part_lba,
		gpt_hdr.part_arr_lba,
		gpt_hdr.part_cnt,
		gpt_hdr.part_sz,
		gpt_hdr.part_crc
	);
}

std::string uuid_str(uint8_t *uuid, int len = 16) {
	std::string ret;
	static const char digits[] = "0123456789abcdef";
	for (int i = 0; i < len; i++) {
		ret += std::string(1, digits[(uuid[i] >> 0) & 0xf]);
		ret += std::string(1, digits[(uuid[i] >> 4) & 0xf]);
	}
	return ret;
}

std::string part_arr_str(uint8_t *arr, int part_cnt, int part_sz) {
	std::string ret = "{";
	for (int i = 0; i < part_cnt; i++) {
		auto part = *(gpt_part_t *)arr;
		char name[73]{0};
		memcpy(name, part.name, 72);
		if (uuid_str(part.type_guid) == "0000""0000""0000""0000"
				"0000""0000""0000""0000")
			continue;
		ret += sformat(R"(
	partition: %d{
		type_guid: %s,
		uniq_guid: %s,
		flags:     %x,
		first_lba: %d,
		last_lba:  %d,
		name:      %s
	},
		)",
			i,
			uuid_str(part.type_guid),
			uuid_str(part.uniq_guid),
			part.flags,
			part.first_lba,
			part.last_lba,
			name
		);
		arr += part_sz;
	}
	ret += "}";
	return ret;
}

std::string ext_sup_str(ext2_sup_t *sup) {
	if (!sup)
		return "[null]";
	return sformat(
		"superblk: [\n\tino_cnt %d,\n\tblk_cnt %d,\n\tfree_blk_cnt %d,"
		"\n\tfree_ino_cnt %d,"
		"\n\tfirst_data_blk %d,\n\tlog_blk_size %d, \n\tlog_frag_size %d, "
		"\n\tblk_per_grp %d,\n\tino_per_grp %d,\n\tmagic %x,\n\tfirst_ino %d,"
		"\n\tino_size %d,\n\tblk_grp_nr %d,\n\tvolume_name %s\n]",
		sup->ino_cnt, sup->blk_cnt, sup->free_blk_cnt, sup->free_ino_cnt,
		sup->first_data_blk, sup->log_blk_size, sup->log_frag_size,
		sup->blk_per_grp, sup->ino_per_grp, sup->magic, sup->first_ino,
		sup->ino_size, sup->blk_grp_nr, sup->volume_name
	);
}

std::string ext_ino_str(inode_t *ino) {
	/* TO DO */
	if (!ino)
		return "[null]";
	return sformat(
		"inode: [mode %x, uid %x, size %d, gid %x, "
		"links_cnt %d, bsize %d, "
		"flags %x, generation %x, file_acl %x, dir_acl %x,"
		"\n\tblock: [0:%d, 1:%d, 2:%d, 3:%d, 4:%d, 5:%d, 6:%d, 7:%d, 8:%d, "
		"9:%d, 10:%d, 11:%d, 12:%d, 13:%d, 14:%d]\n",
		ino->mode, ino->uid, ino->size, ino->gid, ino->links_cnt, ino->bsize,
		ino->flags, ino->generation, ino->file_acl, ino->dir_acl,
		ino->block[0], ino->block[1], ino->block[2], ino->block[3],
		ino->block[4], ino->block[5], ino->block[6], ino->block[7],
		ino->block[8], ino->block[9], ino->block[10], ino->block[11],
		ino->block[12], ino->block[13], ino->block[14]
	);
}

std::string ext_indir_str(ext2_indir_t *indir) {
	if (!indir)
		return "[null]";
	std::string ret;
	uint32_t per_line = 16;
	for (int i = 0; i < sizeof(indir->block) / per_line; i++) {
		for (int i = 0; i < per_line; i++) {
			ret += sformat("%d:%d, ", i, indir->block[i]);
		}
		ret += "\t\n";
	}
	return ret;
}

std::string ext_grp_str(blk_grp_desc_t *gdesc) {
	if (!gdesc)
		return "[null]";
	return sformat(
		"gdesc: [\n\tblk_bitmap %d,\n\tino_bitmap %d,\n\tino_table %d,"
		"\n\tfree_blk_cnt %d,\n\tfree_ino_cnt %d,\n\tused_dir_cnt %d\n]",
		gdesc->blk_bitmap, gdesc->ino_bitmap, gdesc->ino_table,
		gdesc->free_blk_cnt, gdesc->free_ino_cnt, gdesc->used_dir_cnt
	);
}

std::string ext_grp_table_str(blk_grp_desc_t *gdesc, int num) {
	/* TO DO */
	std::string res = "grp_desc_table: \n";
	for (int i = 0; i < num; i++) {
		res += ext_grp_str(gdesc);
		gdesc += 1;
	}
	return res;
}

std::string ext_bitmap_str(const Bitmap& bitmap) {
	std::string ret;
	bool last_line = true;
	for (int i = 0; i < bitmap.byte_cnt * 8;) {
		std::string line = sformat("%4d:    ", i);
		bool new_line = false;
		for (int j = 0; j < 8; j++) {
			for (int k = 0; k < 8; k++) {
				line += sformat("%c", i < bitmap.byte_cnt * 8 ?
						(bitmap.get(i) ? '1' : '0') : '.');
				if (i < bitmap.byte_cnt * 8 && bitmap.get(i) != 0)
					new_line = true;
				i++;
			}
			line += sformat("%c", j != 7 ? '\'' : '\n');
		}
		if (new_line || last_line)
			ret += new_line ? line : "...\n";
		last_line = new_line;
	}
	return ret;
}

std::string ext_dir_str(dir_entry_t *dirent) {
	if (!dirent)
		return "[null]";
	return sformat(
		"dir: [\n\tino %d,\n\tnext %d,\n\tname_len %d,\n\tfile_type %d,"
		"\n\tname %s\n]",
		dirent->ino, dirent->next, dirent->name_len, dirent->file_type,
		dirent->name
	);
}

#endif