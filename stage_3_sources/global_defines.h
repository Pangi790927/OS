#ifndef GLOBAL_DEFINES_H
#define GLOBAL_DEFINES_H

/* Must be updated here and in kernel_stage_2_load_3.cpp
** also updated in README.md
*/
#define KERNEL_ON_HDD		0x10000

/* Must be updated here and in stage_1_sources/32_protected_mode.asm
** The stack bellow might also need an update
** also updated in README.md
*/
#define K_STACK_START		0x0e00000

/* Must be updated here and be part of K_STACK_START
** also updated in README.md
*/
#define K_INT_STACK_START	0x0700000

/* Must be updated here and in kernel_stage_2_load_3.cpp
** also updated in README.md
*/
#define KERNEL_IN_RAM		0x1000000

/* Must be updated here and not overlap with others
** also updated in README.md
*/
#define HEAP_START			0x3000000	// 48Mb - 64Mb

/* Must be uncommented if the you want MULTI_CORE support
** !!! UNAVAILABLE FOR NOW !!!
*/
// #define MULTI_CORE

#endif