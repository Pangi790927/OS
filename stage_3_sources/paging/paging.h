#ifndef PAGING_H
#define PAGING_H

#include "Types.h"

// Kernel paging:
// 0:0xc0000000 
// | 0xc0000000:inf the kernel

// For programs code:
// 		No memory will be allocated from the begining
// the paging will allocate mostly the paging directory,
// because the kernell will be loaded as 4M chunks,
// and some pages from the paging space itself
// 		The rest of the pages will not be loaded and when a
// page fault occours the pages will be loaded, added to the
// kernell page memory and the program execution will continue
// unaware of this fact

namespace paging
{
	const uint32 CR0_PG_BIT = 0x80000000;
	const uint32 CR0_PE_BIT = 0x00000001;
	const uint32 CR4_PSE_BIT = 0x00000010;

	const uint32 PAGE_SIZE_BIT =		0b10000000;
	const uint32 ACCESSED_BIT =			0b100000;
	const uint32 CACHE_DISABLE_BIT =	0b10000;
	const uint32 WRITE_THROUGH_BIT =	0b1000;
	const uint32 USER_BIT =				0b100;
	const uint32 READ_WRITE_BIT =		0b10;
	const uint32 PRESENT_BIT =			0b1;

	void registerPageK (void *physAddr, void *virtAddress, uint32 *pd,
				uint32 ptFlags = READ_WRITE_BIT | PRESENT_BIT | USER_BIT,
				uint32 pdFlags = READ_WRITE_BIT | PRESENT_BIT | USER_BIT);
	void adKernelToPd (uint32 *pd);
	void printPD (uint32 *pd);
	void printPT (uint32 *pd, uint32 index);
	void loadCr3 (void *cr3);
	uint32 addr2phy (uint32 virtual_addr, uint32 *pd);
}

#endif