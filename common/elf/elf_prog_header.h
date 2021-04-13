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
		uint32_t type;
		uint32_t offset;
		uint32_t vaddr;
		uint32_t paddr;
		uint32_t filesz;
		uint32_t memsz;
		uint32_t flags;
		uint32_t align;
	};
}

#endif