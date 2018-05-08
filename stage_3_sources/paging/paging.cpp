#include "paging.h"
#include "Types.h"
#include "c_asm_func.h"
#include "global_defines.h"
#include "boot_data.h"

namespace paging
{
	const uint32 _4Mib = 1024 * 1024 * 4;
	const uint32 _4Kib = 1024 * 4;

	// physAddr and virtAddress must be 4Kib aligned
	void registerPageK (void *physAddr, void *virtAddress, uint32 *pageDir) {
		if (!(pageDir[(uint32)virtAddress >> 22] & PRESENT_BIT)) {
			pageDir[(uint32)virtAddress >> 22] =
					(uint32)(pageDir + 1024 + ((uint32)virtAddress >> 22)) |
					READ_WRITE_BIT | PRESENT_BIT;
		}
		(pageDir + 1024 + ((uint32)virtAddress >> 22))[(uint32)virtAddress >> 12]
				= ((uint32)physAddr) | READ_WRITE_BIT | PRESENT_BIT;
	}

	void registerPageM (void *physAddr, void *virtAddress, uint32 *pageDir) {
		pageDir[(uint32)virtAddress >> 22] =
				(uint32)physAddr | READ_WRITE_BIT | PAGE_SIZE_BIT | PRESENT_BIT;
	}
}