#include <initializer_list>

#include "elf.h"
#include "kstdio.h"

namespace elf
{
	static const int sector_size = 512;

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
		return sect_hdr;	
	}

	int load_elf_in_mem (uint32 hdd_addr, load_fn load, void *ctx) {
		(void)hdd_addr;
		(void)load;
		(void)ctx;

		auto elf_hdr = load_file_hdr(hdd_addr, load, ctx);

		kprintf("elf magic: %c%c%c%c\n", elf_hdr.magic[0], elf_hdr.magic[1],
				elf_hdr.magic[2], elf_hdr.magic[3]);

		if (elf_hdr.magic[1] != 'E' || elf_hdr.magic[2] != 'L' ||
				 elf_hdr.magic[3] != 'F')
		{
			return -1;
		}

		kprintf("prog_cnt %d\n", elf_hdr.prog_cnt);
		kprintf("prog_off %x\n", elf_hdr.prog_off);
		kprintf("prog_hdr_size %d\n", elf_hdr.prog_hdr_size);

		for (int i = 0; i < elf_hdr.prog_cnt; i++) {
			auto prog_hdr = load_prog_hdr(hdd_addr + elf_hdr.prog_off,
					elf_hdr.prog_hdr_size, i, load, ctx);

			bool of_interest = false;
			for (uint32 j : {PT_NULL, PT_LOAD, PT_DYNAMIC, PT_INTERP, PT_NOTE,
					PT_SHLIB, PT_PHDR})
			{
				if (j == prog_hdr.type)
					of_interest = true;
			}

			if (of_interest) {
				kprintf("--------------------------------------------------\n");
				kprintf("prog hdr %d: vaddr %x, paddr %x, align %d filesz %d\n",
						i, prog_hdr.vaddr, prog_hdr.paddr,
						prog_hdr.align, prog_hdr.filesz);
				kprintf("memsz %d, type: %x\n", prog_hdr.memsz,
						prog_hdr.type);
				if (load((uint8 *)prog_hdr.vaddr, prog_hdr.offset + hdd_addr,
						prog_hdr.filesz, ctx))
				{
					return -1;
				}
			}
		}

		return 0;
	}
}