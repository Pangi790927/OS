#ifndef ELF_FILE_HEADER_H
#define ELF_FILE_HEADER_H

namespace elf
{
	enum E_TYPE {
		ET_NONE = 0x00,
		ET_REL = 0x01,	
		ET_EXEC = 0x02,
		ET_DYN = 0x03,
		ET_CORE = 0x04,
		ET_LOOS = 0xfe00,
		ET_HIOS = 0xfeff,
		ET_LOPROC = 0xff00,
		ET_HIPROC = 0xffff 	
	};

	struct __attribute__((__packed__)) file_hdr_t {
		uint8_t magic[4];
		uint8_t bit_format;
		uint8_t endianess;
		uint8_t ver;
		uint8_t os_abi;
		uint8_t abi_ver;
		uint8_t pad[7];
		uint16_t type;
		uint16_t machine;
		uint32_t ver2;
		uint32_t entry;
		uint32_t prog_off;
		uint32_t sect_off;
		uint32_t flags;
		uint16_t elf_hdr_size;
		uint16_t prog_hdr_size;
		uint16_t prog_cnt;
		uint16_t sect_hdr_size;
		uint16_t sect_cnt;
		uint16_t shstrndx;
	};
}

#endif