#include "paging.h"
#include "Types.h"
#include "c_asm_func.h"
#include "global_defines.h"
#include "boot_data.h"
#include "kiostream.h"

namespace paging
{
	const uint32 _4Mib = 1024 * 1024 * 4;
	const uint32 _4Kib = 1024 * 4;

	// physAddr and virtAddress must be 4Kib aligned
	void registerPageK (void *physAddr, void *virtAddress, uint32 *pd,
			uint32 ptFlags, uint32 pdFlags)
	{
		// bits xxxx xxxx xx | xxxx xxxx xx | 0000 0000 0000 
		// 		pd index		pt index
		uint32 pdIndex = (uint32)virtAddress >> 22;
		uint32 ptIndex = ((uint32)virtAddress >> 12) & 0x3ff;
		bool needReloadCr3 = false;

		uint32 *pt = pd + 1024 + pdIndex * 0x400;

		if ((pt[pdIndex] & PRESENT_BIT) == 0) {
			pd[pdIndex] = (uint32)pt | (pdFlags & 0x3fffff);
			needReloadCr3 = true;
		}

		pt[ptIndex] = ((uint32)physAddr & 0xfffff000) | (ptFlags & 0xfff);
		if (needReloadCr3)
			loadCr3(pd);
		else
			__invlpg((uint32)virtAddress);
	}

	// physAddr and virtAddress must be 4Mib aligned
	void registerPageM (void *physAddr, void *virtAddress, uint32 *pd,
			uint32 flags)
	{
		// bits xxxx xxxx xx | 0000 0000 00 | 0000 0000 0000 
		// 		pd index		pt index
		uint32 pdIndex = (uint32)virtAddress >> 22;

		pd[pdIndex] = ((uint32)physAddr & 0xffc00000) | (flags & 0xfff);
		loadCr3(pd);
	}

	void printPD (uint32 *pd) {
		for (int i = 0; i < 1024; i++) {
			if (pd[i] & PRESENT_BIT) {
				if (pd[i] & PAGE_SIZE_BIT)
					kprintf("@");
				else
					kprintf("#");
			}
			else
				kprintf(".");
			if ((i + 1) % 64 == 0)
				kprintf("\n");
		}
		kprintf("\n");
	}

	void printPT (uint32 *pd, uint32 index) {
		uint32 *pt = pd + 1024 + index * 0x400;
		kprintf("virt:: start: %x stop: %x\n",
			index * _4Mib, (index + 1) * _4Mib - 1);
		for (int i = 0; i < 1024; i++) {
			if (pt[i] & PRESENT_BIT)
				kprintf("#");
			else
				kprintf(".");
			if ((i + 1) % 64 == 0)
				kprintf("\n");
		}
		kprintf("\n");
	}

	void loadCr3 (void *cr3) {
		__setCR3((uint32)cr3);
	}
}