#include "kern_elf.h"
#include "ata_driver.h"
#include "global_defines.h"
#include "kstdio.h"

namespace elf
{
	static uint8 file_hdr[sizeof(file_hdr_t)] = {0};
	static prog_hdr_t *prog_hdrs = NULL;
	static sect_hdr_t *sect_hdrs = NULL;

	int store_kern_info (uint32 hdd_addr, load_fn load, void *ctx) {		
		auto &file_hdr = kern_file_hdr() = load_file_hdr(hdd_addr, load, ctx);

		if (file_hdr.magic[1] != 'E' || file_hdr.magic[2] != 'L' ||
				file_hdr.magic[3] != 'F')
			return -1;

		prog_hdrs = new prog_hdr_t[file_hdr.prog_cnt];
		if (!prog_hdrs)
			return -1;

		sect_hdrs = new sect_hdr_t[file_hdr.sect_cnt];
		if (!sect_hdrs) 
			return -1;

		for (int i = 0; i < file_hdr.prog_cnt; i++)
			prog_hdrs[i] = load_prog_hdr(hdd_addr + file_hdr.prog_off,
					file_hdr.prog_hdr_size, i, load, ctx);

		for (int i = 0; i < file_hdr.sect_cnt; i++)
			sect_hdrs[i] = load_sect_hdr(hdd_addr + file_hdr.sect_off,
					file_hdr.sect_hdr_size, i, load, ctx);

		return 0;
	}

	int init_kinfo() {
		int res = elf::store_kern_info(KERNEL_ON_HDD,
			[](void *addr, uint32 hdd_addr, uint32 size, void *ctx) {
				(void)ctx;
				if (!ata::read(addr, hdd_addr, size, 0))
					return -1;

				return 0;
			}, NULL);

		if (res) {
			kprintf("Loading kernel elf file in memory failed!\n");
			return -1;
		}
		return 0;
	}

	void release_info() {
		if (prog_hdrs) {
			delete [] prog_hdrs;
			prog_hdrs = NULL;
		}
		if (sect_hdrs) {
			delete [] sect_hdrs;
			sect_hdrs = NULL;
		}
	}

	std::string kto_str() {
		std::string ret_str;
		auto &file_hdr = kern_file_hdr();

		ret_str += file_hdr.magic[0];
		ret_str += file_hdr.magic[1];
		ret_str += file_hdr.magic[2];
		ret_str += file_hdr.magic[3];

		kprintf("%c%c%c%c\n", file_hdr.magic[0], file_hdr.magic[1],
				file_hdr.magic[2], file_hdr.magic[3]);

		return ret_str;
	}

	file_hdr_t &kern_file_hdr() {
		return *(file_hdr_t *)file_hdr;
	}

	prog_hdr_t &kern_prog_hdr (int index) {
		if (index >= 0 && index < kern_file_hdr().prog_cnt)
			return prog_hdrs[index];

		/* no way to detect the error without throwing an exception */
		/* we can't throw exceptions yet */
		return prog_hdrs[0];
	}

	sect_hdr_t &kern_sect_hdr (int index) {
		if (index >= 0 && index < kern_file_hdr().sect_cnt)
			return sect_hdrs[index];
		/* no way to detect the error without throwing an exception */
		/* we can't throw exceptions yet */
		return sect_hdrs[0];
	}
}