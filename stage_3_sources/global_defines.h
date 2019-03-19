#ifndef GLOBAL_DEFINES_H
#define GLOBAL_DEFINES_H

#include "Types.h"

/* Must be updated here and in kernel_stage_2_load_3.cpp
** also updated in README.md
*/
#define KERNEL_ON_HDD		0x10000

/* Must be updated here
** Must be 4MiB aligned
*/
#define V_KERNEL_BASE		0xc0000000

/* Must be updated here and in kernel_stage_3_start.asm
** The stack bellow might also need an update
** also updated in README.md
*/
#define K_STACK_START		0x0e00000
#define V_K_STACK_START		(K_STACK_START + V_KERNEL_BASE)

/* Must be updated here and be part of K_STACK_START
** also updated in README.md
*/
#define K_INT_STACK_START	0x0a00000
#define V_K_INT_STACK_START	(K_INT_STACK_START + V_KERNEL_BASE)

/* Must be updated here 
** also updated in README.md
** linker should be updated with the virtual memory
*/
#define KERNEL_START		0x01000000
#define V_KERNEL_START		(0xc1000000)

/* Must be updated here
** also updated in README.md
*/
#define K_PAGING			0x100000

/* Must be updated here
** also updated in README.md
*/
#define PHYS_PAGES_START	0x2000000
#define V_PHYS_PAGES_START	(PHYS_PAGES_START + V_KERNEL_BASE)

/* Must be updated here and not overlap with others
** also updated in README.md
*/
#define HEAP_START			0x3000000	// 48Mb - 64Mb
#define V_HEAP_START		(HEAP_START + V_KERNEL_BASE)

/* Must be updated here
** also updated in README.md
*/
#define KERNEL_END			0x4000000
#define V_KERNEL_END		(KERNEL_END + V_KERNEL_BASE)

/* Must be uncommented if the you want MULTI_CORE support
** !!! UNAVAILABLE FOR NOW !!!
*/
// #define MULTI_CORE

/* Must be updated here
*/
#define V_NET_MEM_BASE		V_KERNEL_END
#define V_NET_MEM_BASE_END	V_NET_MEM_BASE + 0x20000

/* Must be updated here in README and in kernel_stage_1.asm
*/
#define RAM_SIZE_LOCATION	0x00000500
#define V_RAM_SIZE_LOCATION	(RAM_SIZE_LOCATION + V_KERNEL_BASE)

/* Must be updated here
*/
#define MAX_PROCESS_COUNT	8000

/* Structure that holds physical pages info */
struct PhysPages {
	/*	The way it works:
			You have all mb pages in the mb stack and what remains in kb
			When you want a kb page you pop it from the kb stack. If the
				stack is empty you pop a page from the mb stack and add all
				1000 pages to the kb stack and pop it afterwards
			If you want a mb page you pop it
			Additionaly, if the page you pop is already in use you pop another
			one. You remember what pages are in use in a bitmap. Whenever you
			give back a page you set it in the bitmap
	*/

	static const uint32 kb_page_count = 1024 * 1024;
	static const uint32 uint32_bit_count = sizeof(uint32) * 8;

	uint32 kb_count;
	uint32 kb_bitmap[kb_page_count / uint32_bit_count];
	uint32 kb_stack[kb_page_count];

	void init();
	void add_page (uint32 address);
	void remove_page (uint32 address);
	uint32 pop_page();
};

#endif