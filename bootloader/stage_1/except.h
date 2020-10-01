#ifndef EXCEPT_H
#define EXCEPT_H

struct string_placeholder {
	const char *c_str() {
		return "backtrace not yet implemented...";
	}
};

inline string_placeholder backtrace_fn() {
	return string_placeholder();
}

#define EXCEPTION(fmt, ...) \
		{ DBG("EXCEPTED: " fmt, ##__VA_ARGS__);\
		while (true) asm volatile ("nop"); }

#endif