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
}