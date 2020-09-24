#ifndef EXCEPT_H
#define EXCEPT_H

inline const char *backtrace_fn() {
	return "backtrace not yet implemented...";
}

#define EXCEPTION(fmt, ...) \
		{ DBG("EXCEPTED: " fmt, ##__VA_ARGS__);\
		while (true) asm volatile ("nop"); }

#endif