#ifndef DBG_H
#define DBG_H

#include "rmode.h"
#include "serial.h"
#include "simple_printf.h"
#include "except.h"

inline uint16_t (*intern_putchar) (uint16_t) = &bios_putchr;

#define VGA_PRINTF(fmt, ...) printf([](char c){ intern_putchar(c); },\
		fmt, ##__VA_ARGS__);

#define SERIAL_PRINTF(fmt, ...) printf(serial::sendchr, fmt, ##__VA_ARGS__);

#define DBG_PRINT(file, line, fcn, fmt, ...) {\
	VGA_PRINTF("[%s][line:%d][%s] " fmt "\r\n", file, line, fcn,\
			##__VA_ARGS__);\
	SERIAL_PRINTF("[%s][line:%d][%s] " fmt "\r\n", file, line, fcn,\
			##__VA_ARGS__);\
}

#define DBG(fmt, ...) DBG_PRINT(__FILE__, __LINE__, __func__, fmt,\
		##__VA_ARGS__)

#define DBGSCOPE() DbgScope dbg_scope(__FILE__, __LINE__, __func__);

struct DbgScope {
	const char *file;
	int line;
	const char *fcn;

	DbgScope(const char *file, int line, const char *fcn)
	: file(file), line(line), fcn(fcn)
	{
		DBG_PRINT(file, line, fcn, " -->");
	}
	~DbgScope() {
		DBG_PRINT(file, line, fcn, " <--");
	}
};


#endif