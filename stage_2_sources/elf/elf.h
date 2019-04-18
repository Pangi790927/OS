#ifndef ELF_H
#define ELF_H

#include "Types.h"
#include "elf_file_header.h"
#include "elf_prog_header.h"
#include "elf_section_header.h"

namespace elf
{
	using load_fn = int(*)(void *addr, uint32 hdd_addr, uint32 size, void *ctx);

	file_hdr_t load_file_hdr (uint32 hdd_addr, load_fn load, void *ctx);
	prog_hdr_t load_prog_hdr (uint32 hdd_addr, uint32 hdr_size, uint32 index,
			load_fn load, void *ctx);
	sect_hdr_t load_sect_hdr (uint32 hdd_addr, uint32 hdr_size, uint32 index,
			load_fn load, void *ctx);
	int load_prog_in_mem (prog_hdr_t& hdr, load_fn load, void *ctx);
	int load_elf_in_mem (uint32 hdd_addr, load_fn load, void *ctx);
}

#endif