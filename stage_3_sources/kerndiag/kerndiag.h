#ifndef KERNDIAG
#define KERNDIAG

#include "Types.h"
#include "snprintf.h"

#define PRINT_LOG
#define BUFF_SIZE 1024

#define KDBG(fmt, ...)\
do {\
	char buff[BUFF_SIZE] = {0};\
	strings::snprintf(sizeof(buff), buff,\
			"[%s][%d][%s()] " fmt "\n",\
			__FILE__, __LINE__, __func__, ##__VA_ARGS__);\
	kdbg::log_str(buff);\
} while (0)

#define PANIC(fmt, ...)\
	do {\
		KDBG(fmt, ##__VA_ARGS__)\
		*(int *)NULL = 122;\
	} while (0)

namespace kdbg
{
	int init();
	void uninit();
	void log_str (const char *str);
}

#endif