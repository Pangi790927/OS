#ifndef BRK_ALLOC_H
#define BRK_ALLOC_H

#include "types.h"

void brk_alloc_init(void *start, size_t size);
void *brk_alloc(size_t size);

#endif