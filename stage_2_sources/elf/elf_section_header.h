#ifndef ELF_SECTION_HEADER_H
#define ELF_SECTION_HEADER_H

namespace elf
{
	enum S_TYPE {
		SHT_NULL          = 0x0,     // Section header table entry unused
		SHT_PROGBITS      = 0x1,     // Program data
		SHT_SYMTAB        = 0x2,     // Symbol table
		SHT_STRTAB        = 0x3,     // String table
		SHT_RELA          = 0x4,     // Relocation entries with addends
		SHT_HASH          = 0x5,     // Symbol hash table
		SHT_DYNAMIC       = 0x6,     // Dynamic linking information
		SHT_NOTE          = 0x7,     // Notes
		SHT_NOBITS        = 0x8,     // Program space with no data (bss)
		SHT_REL           = 0x9,     // Relocation entries, no addends
		SHT_SHLIB         = 0x0A,    // Reserved
		SHT_DYNSYM        = 0x0B,    // Dynamic linker symbol table
		SHT_INIT_ARRAY    = 0x0E,    // Array of constructors
		SHT_FINI_ARRAY    = 0x0F,    // Array of destructors
		SHT_PREINIT_ARRAY = 0x10,    // Array of pre-constructors
		SHT_GROUP         = 0x11,    // Section group
		SHT_SYMTAB_SHNDX  = 0x12,    // Extended section indices
		SHT_NUM           = 0x13,    // Number of defined types
	};

	struct __attribute__((__packed__)) sect_hdr_t {
		uint32 name;
		uint32 type;
		uint32 flags;
		uint32 vaddr;
		uint32 offset;
		uint32 size;
		uint32 link;
		uint32 info;
		uint32 align;
		uint32 entsize;
	};
}

#endif
