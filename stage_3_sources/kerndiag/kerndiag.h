#ifndef KERNDIAG
#define KERNDIAG

#include "Types.h"

#define PRINT_LOG

#define KLOG(fmt, ...)\
		kdbg::log(__FILE__, __LINE__, __PRETTY_FUNCTION__\
				, fmt ##__VA_ARGS__)

#define PANIC(reason)\
		panic(__FILE__, __LINE__, __PRETTY_FUNCTION__, reason)

namespace kdbg
{
	int init (size_t size = 1024 * 32);
	void uninit();
	void log (const char *srcfile, int line, const char *func,
			const char *fmt, ...);
	void panic(const char *srcfile, int line, const char *func,
			const char *reason);
}

#endif