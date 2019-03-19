#ifndef PRIMITIVES_H
#define PRIMITIVES_H

#include "Types.h"

extern uint32 compare_exchange32(uint32 *dest, uint32 *expected, uint32 desired)
		asm("compare_exchange32");

#endif