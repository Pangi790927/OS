#ifndef ELF_PROG_HEADER_H
#define ELF_PROG_HEADER_H

namespace elf
{
	enum P_TYPE {
		PT_NULL = 0,
		PT_LOAD = 1,
		PT_DYNAMIC = 2,
		PT_INTERP = 3,
		PT_NOTE = 4,
		PT_SHLIB = 5,
		PT_PHDR = 6
	};

	struct __attribute__((__packed__)) prog_hdr_t {
		uint32 type;
		uint32 offset;
		uint32 vaddr;
		uint32 paddr;
		uint32 filesz;
		uint32 memsz;
		uint32 flags;
		uint32 align;
	};
}

#endif