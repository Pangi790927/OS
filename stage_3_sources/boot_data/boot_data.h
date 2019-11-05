#ifndef BOOT_DATA_H
#define BOOT_DATA_H

#include "Types.h"

namespace boot
{
	uint32 get_ram_size();
	uint16 get_vesa_modes_cnt();
	uint16 get_vesa_curr_mode();
	void *get_vesa_info_ptr();
}

#endif