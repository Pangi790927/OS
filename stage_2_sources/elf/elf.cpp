#include <initializer_list>

#include "elf.h"
#include "stdio.h"

namespace elf
{
	// static const int sector_size = 512;

	file_hdr_t load_file_hdr (uint32 hdd_addr, load_fn load, void *ctx) {
		file_hdr_t file_hdr;
		if (load(&file_hdr, hdd_addr, sizeof(file_hdr_t), ctx)) {
			uint8 null_hdr[sizeof(file_hdr_t)] = {0};
			return *(file_hdr_t *)null_hdr;
		}
		return file_hdr;
	}

	prog_hdr_t load_prog_hdr (uint32 hdd_addr, uint32 hdr_size, uint32 index,
			load_fn load, void *ctx)
	{
		/* we will let gcc handle this allocation on stack (small hack) */
		prog_hdr_t prog_hdr;
		if (load(&prog_hdr, hdd_addr + hdr_size * index, hdr_size, ctx)) {
			uint8 null_hdr[sizeof(prog_hdr_t)] = {0};
			return *(prog_hdr_t *)null_hdr;
		}
		return prog_hdr;
	}

	sect_hdr_t load_sect_hdr (uint32 hdd_addr, uint32 hdr_size, uint32 index,
			load_fn load, void *ctx)
	{
		sect_hdr_t sect_hdr;
		if (load(&sect_hdr, hdd_addr + hdr_size * index, hdr_size, ctx)) {
			uint8 null_hdr[sizeof(sect_hdr_t)] = {0};
			return *(sect_hdr_t *)null_hdr;
		}
		LOG("vaddr: %x", sect_hdr.vaddr);
		return sect_hdr;	
	}

	int load_elf_in_mem (uint32 hdd_addr, load_fn load, void *ctx) {
		auto elf_hdr = load_file_hdr(hdd_addr, load, ctx);

		LOG("elf magic: %c%c%c%c", elf_hdr.magic[0], elf_hdr.magic[1],
				elf_hdr.magic[2], elf_hdr.magic[3]);

		if (elf_hdr.magic[1] != 'E' || elf_hdr.magic[2] != 'L' ||
				 elf_hdr.magic[3] != 'F')
		{
			return -1;
		}

		LOG("prog_cnt %d", elf_hdr.prog_cnt);
		LOG("prog_off %x", elf_hdr.prog_off);
		LOG("prog_hdr_size %d", elf_hdr.prog_hdr_size);

		auto str_sect_hdr = load_sect_hdr(hdd_addr + elf_hdr.sect_off,
				elf_hdr.sect_hdr_size, elf_hdr.shstrndx, load, ctx);

		char names[str_sect_hdr.size];
		char names_copy[str_sect_hdr.size];
		for (uint32 i = 0; i < str_sect_hdr.size; i++)
			names[i] = names_copy[i] = 0;
		if (load(names, str_sect_hdr.offset + hdd_addr, str_sect_hdr.size,
				ctx))
		{
			LOG("Failed to load string sector");
			return -1;
		}

		bool first_0 = false;
		for (int i = sizeof(names) - 1; i >= 0; i--) {
			names_copy[i] = names[i];
			if (names[i] == 0 && first_0)
				names_copy[i] = ' ';
			if (names[i] == 0)
				first_0 = true;
		}
		LOG("str table: %s", names_copy);

		for (int i = 0; i < elf_hdr.prog_cnt; i++) {
			auto prog_hdr = load_prog_hdr(hdd_addr + elf_hdr.prog_off,
					elf_hdr.prog_hdr_size, i, load, ctx);

			bool of_interest = false;
			for (uint32 j : {PT_LOAD, PT_DYNAMIC, PT_INTERP, PT_NOTE,
					PT_SHLIB, PT_PHDR})
			{
				if (j == prog_hdr.type)
					of_interest = true;
			}

			LOG("-> prog: %d <-", i);
			LOG("vaddr %x, paddr %x, align %d filesz %x",
					prog_hdr.vaddr, prog_hdr.paddr,
					prog_hdr.align, prog_hdr.filesz);
			LOG("memsz %x, type: %x, off %x", prog_hdr.memsz,
					prog_hdr.type, prog_hdr.offset);
			
			if (of_interest) {
				LOG("prog in usefull");
				if (load((uint8 *)prog_hdr.vaddr, prog_hdr.offset + hdd_addr,
						prog_hdr.filesz, ctx))
				{
					return -1;
				}
			}
		}

		LOG("sect_cnt %d", elf_hdr.sect_cnt);
		LOG("sect_off %x", elf_hdr.sect_off);
		LOG("sect_hdr_size %d", elf_hdr.sect_hdr_size);

		for (int i = 0; i < elf_hdr.sect_cnt; i++) {
			LOG("-> sector: %d <-", i);
			auto sect_hdr = load_sect_hdr(hdd_addr + elf_hdr.sect_off,
					elf_hdr.sect_hdr_size, i, load, ctx);

			if (sect_hdr.type == SHT_NULL)
				continue;

			bool of_interest = false;
			for (uint32 j : {SHT_NOBITS})
			{
				if (j == sect_hdr.type)
					of_interest = true;
			}

			LOG("Name: %s", names + sect_hdr.name);
			LOG("flags %b, vaddr %x, align %d namei %x",
					sect_hdr.flags, sect_hdr.vaddr,
					sect_hdr.align, sect_hdr.name);
			LOG("size %x, type: %x, off %x", sect_hdr.size,
					sect_hdr.type, sect_hdr.offset);

			if (of_interest) {
				for (uint32 i = 0; i < sect_hdr.size; i++)
					((uint8 *)(sect_hdr.vaddr))[i] = 0;
				LOG("sector is usefull %x", sect_hdr.size);
			}
		}

		LOG("Load done");
		return 0;
	}
}