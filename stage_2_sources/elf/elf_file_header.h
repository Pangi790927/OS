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
		uint8 magic[4];
		uint8 bit_format;
		uint8 endianess;
		uint8 ver;
		uint8 os_abi;
		uint8 abi_ver;
		uint8 pad[7];
		uint16 type;
		uint16 machine;
		uint32 ver2;
		uint32 entry;
		uint32 prog_off;
		uint32 sect_off;
		uint32 flags;
		uint16 elf_hdr_size;
		uint16 prog_hdr_size;
		uint16 prog_cnt;
		uint16 sect_hdr_size;
		uint16 sect_cnt;
		uint16 shstrndx;
	};
}

#endif