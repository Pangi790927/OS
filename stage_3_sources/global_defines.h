#ifndef GLOBAL_DEFINES_H
#define GLOBAL_DEFINES_H

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

#endif