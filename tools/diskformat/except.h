#ifndef DEBUG_H
#define DEBUG_H

#include <execinfo.h>
#include <exception>
#include "demangle.h"

std::string backtrace_fn() {
	void *array[32];
	size_t size = backtrace(array, sizeof(array));
	auto symb = backtrace_symbols(array, size);

	std::string res;
	for (int i = 0; i < size; i++) {
		char *name = symb[i];
		while (*name && *name != '(')
			name++;
		if (*name)
			name++;
		std::string sname = name;
		sname = sname.substr(0, sname.find('+'));
		if (sname.find(')') != std::string::npos)
			sname = "__unknown__";
		res = res + "fn: " + demangle(sname) + "\n";
	}
	return res;
}

#define EXCEPTION(fmt, ...) \
	throw (std::runtime_error([&](const char *func){\
		char buff[1024] = {0};\
		auto res = backtrace_fn();\
		sprintf(buff, "[file: %s][func: %s][code_line: %d] " fmt "\nbt:\n%s",\
				__FILE__, func, __LINE__, ##__VA_ARGS__,\
				res.c_str());\
		return std::string(buff);\
	}(__func__).c_str()))

#endif
