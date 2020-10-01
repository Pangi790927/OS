#ifndef SIMPLE_PRINTF_H
#define SIMPLE_PRINTF_H

// TO DO: move this file and other usual simple stuff in a common area

#include "types.h"

struct PrintfArg {
	uint64_t v;

	PrintfArg(void *arg) : v((uint64_t)arg) {}
	PrintfArg(const void *arg) : v((uint64_t)arg) {}
	PrintfArg(int arg) : v(arg) {}
	PrintfArg(unsigned int arg) : v(arg) {}
	PrintfArg(uint64_t arg) : v(arg) {}
};

void printf(void (*putchar)(char), const char *str,
	PrintfArg arg1 = 0,
	PrintfArg arg2 = 0,
	PrintfArg arg3 = 0,
	PrintfArg arg4 = 0,
	PrintfArg arg5 = 0,
	PrintfArg arg6 = 0,
	PrintfArg arg7 = 0,
	PrintfArg arg8 = 0,
	PrintfArg arg9 = 0,
	PrintfArg arg10 = 0,
	PrintfArg arg11 = 0
	// PrintfArg arg12 = 0,
	// PrintfArg arg13 = 0,
	// PrintfArg arg14 = 0,
	// PrintfArg arg15 = 0,
	// PrintfArg arg16 = 0
);

#endif