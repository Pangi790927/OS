#ifndef DBG_H
#define DBG_H

#include "except.h"

#define DBG_PRINT(file, line, fcn, fmt, ...) {\
	printf("[%s][line:%d][%s] " fmt "\r\n", file, line, fcn,\
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