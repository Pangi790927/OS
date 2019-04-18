#ifndef KERN_ELF_H
#define KERN_ELF_H

#include "elf.h"
#include "string.h"

namespace elf
{
	int store_kern_info (uint32 hdd_addr, load_fn load, void *ctx);
	int init_kinfo();
	void release_info();
	std::string kto_str();
	file_hdr_t &kern_file_hdr();
	prog_hdr_t &kern_prog_hdr (int index);
	sect_hdr_t &kern_sect_hdr (int index);
}

#endif
