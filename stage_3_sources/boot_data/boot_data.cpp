#include "boot_data.h"
#include "global_defines.h"

namespace boot
{
	uint32 get_ram_size() {
		uint32 result = 0;

		result += *(uint16 *)RAM_SIZE_LOCATION;
		result += *((uint16 *)RAM_SIZE_LOCATION + 1) * 64;
		result *= 1024;
		return result;
	}

	uint16 get_vesa_modes_cnt() {
		return *(uint16 *)VESA_MODES_LOC;
	}
	
	uint16 get_vesa_curr_mode() {
		return *(uint16 *)VESA_CURR_MODE;
	}

	void *get_vesa_info_ptr() {
		return (void *)VESA_INFO_LOC;
	}

}