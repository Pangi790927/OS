#ifndef PAGING_H
#define PAGING_H

#include "Types.h"

// Kernel paging:
// 0:0xc0000000 
// | 0xc0000000:inf the kernel
// 
// kernel: 
// 0:1M kernel stack 
// | 1M:a kernel code 
// | a:b kernel data, paging, page management, process data
// | heap

// Program paging:
// 0:16M paging, buffers, program data
// | 16M:32M code
// | 32M:48M stack
// | 48M:0xc0000000 heap
// | 0xc0000000:inf the kernel

// to reload the kernel page you can find it at adrress a
// a will be anounced

// 		No memory will be allocated from the begining
// the paging will allocate mostly the paging directory,
// because the kernell will be loaded as 4M chunks,
// and some pages from the paging space itself
// 		The rest of the pages will not be loaded and when a
// page fault occours the pages will be loaded, added to the
// kernell page memory and the program execution will continue
// unaware of this fact

struct PageDir {
	uint32 
};

#endif