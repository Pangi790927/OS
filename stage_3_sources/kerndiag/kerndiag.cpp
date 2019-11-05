#include "kerndiag.h"
#include "memmanip.h"
#include "string.h"
#include "serial.h"

namespace kdbg
{
	int init () {
		serial::init();
		return 0;
	}

	void uninit() {
		serial::uninit();
	}

	void log_str (const char *str) {
#ifdef PRINT_LOG
		kprintf("%s", str);
#endif
		serial::sendstr(str);
	}
}