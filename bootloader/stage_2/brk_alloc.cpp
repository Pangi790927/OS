#include "brk_alloc.h"
#include "dbg.h"

static char *brk_start = NULL;
static char *brk_end = NULL;

void brk_alloc_init(void *start, size_t size) {
	DBGSCOPE();
	DBG("start: %x : end %x", start, (uint)start + size);
	brk_start = (char *)start;
	brk_end = brk_start + size;
}

void *brk_alloc(size_t size) {
	if (size == 0) {
		DBG("[ERROR] Size can't be zero");
		return (void *)0;
	}
	if (brk_start + size > brk_end) {
		DBG("[ERROR] No enaugh memory");
		return (void *)0;
	}
	auto ret = brk_start;
	brk_start += size;
	return ret;
}
