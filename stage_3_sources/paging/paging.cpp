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

	// TO DO: CHECK IF PAGE CAN BE TAKEN
	// physAddr and virtAddress must be 4Kib aligned
	void registerPageK (void *physAddr, void *virtAddress, uint32 *pd,
			uint32 ptFlags, uint32 pdFlags)
	{
		PhysPages *phys_pages = (PhysPages *)V_PHYS_PAGES_START;
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

		(void)phys_pages;
		phys_pages->remove_page((uint32)physAddr);
	}

	void adKernelToPd (uint32 *pd) {
		uint32 kernel_4Mib_count = KERNEL_END / _4Mib + 
				(KERNEL_END % _4Mib != 0);
		
		pd[0] = READ_WRITE_BIT | PRESENT_BIT | 
				PAGE_SIZE_BIT | USER_BIT | (0 * _4Mib);
		pd[1] = READ_WRITE_BIT | PRESENT_BIT |
				PAGE_SIZE_BIT | USER_BIT | (1 * _4Mib);

		/* Here we set the kernel pages acordignly */
		for (uint32 i = 2; i < kernel_4Mib_count; i++)
			pd[V_KERNEL_BASE / _4Mib + i] = (i * _4Mib) |
					READ_WRITE_BIT | PRESENT_BIT | PAGE_SIZE_BIT | USER_BIT;
	}

	/* 4Mb pages are used only for mapping kernel pages */

	// // physAddr and virtAddress must be 4Mib aligned
	// void registerPageM (void *physAddr, void *virtAddress, uint32 *pd,
	// 		uint32 flags)
	// {
	// 	// bits xxxx xxxx xx | 0000 0000 00 | 0000 0000 0000 
	// 	// 		pd index		pt index
	// 	uint32 pdIndex = (uint32)virtAddress >> 22;

	// 	pd[pdIndex] = ((uint32)physAddr & 0xffc00000) | (flags & 0xfff);
	// 	loadCr3(pd);

	// 	phys_pages->remove_mb_page(physAddr);
	// }

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

/* Only those need to be implemented by the third stage */
void PhysPages::add_page (uint32 address) {
	// we asume the page was not already there
	// the user must check it
	kb_stack[kb_count++] = address;
	uint32 index = (address / paging::_4Kib);
	kb_bitmap[index / uint32_bit_count] |= 1 << (index % uint32_bit_count);
}

void PhysPages::remove_page (uint32 address) {
	uint32 index = (address / paging::_4Kib);
	kb_bitmap[index / uint32_bit_count] &= ~(1 << (index % uint32_bit_count));
}

uint32 PhysPages::pop_page() {
	if (kb_count <= 0)
		return NULL;

	uint32 address = kb_stack[kb_count--];
	uint32 index = (address / paging::_4Kib);

	// we pop pages till we get a reall
	while (!(kb_bitmap[index / uint32_bit_count] &
			(1 << (index % uint32_bit_count))))
	{
		if (kb_count <= 0)
			return NULL;

		address = kb_stack[kb_count--];
		index = kb_stack[kb_count--];
	}

	return address;
}
