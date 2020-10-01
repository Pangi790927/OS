#ifndef EXCEPT_H
#define EXCEPT_H

#include "extern_asm.h"

struct string_placeholder {
	const char *c_str() {
		return "backtrace not yet implemented...";
	}
};

inline string_placeholder backtrace_fn() {
	return string_placeholder();
}

#define EXCEPTION(fmt, ...) \
{\
	DBG("EXCEPTED: " fmt, ##__VA_ARGS__);\
	dump_regs();\
	while (true) asm volatile ("nop");\
}

#endif