#include "kerndiag.h"
#include "memmanip.h"
#include "string.h"

namespace kdbg
{
	static char *dbg_buff;
	static size_t size = 0;
	static size_t head = 0;
	static bool overflow = false;

	int init (size_t size) {
		head = 0;
		::kdbg::size = size;
		overflow = false;
		dbg_buff = new char[size + 1];
		for (size_t i = 0; i < size; ++i) {
			dbg_buff[i] = '\0';
		}
		return 0;
	}

	void uninit() {
		delete [] dbg_buff;
	}

	void log (const char *srcfile, int line, const char *func,
			const char *fmt, ...)
	{
		std::string log;
		log = std::string()
				+ "[file: " + srcfile + "]"
				+ "[line: " + std::to_string(line) + "]"
				+ "[func: " + func + "]"
				+ " msg: " + fmt + "";
		if (log.size() < size) {
			if (head + log.size() < size) {
				memcpy(dbg_buff + head, log.c_str(), log.size());
				head = head + log.size();
				dbg_buff[head] = '\0';
			}
			else {
				overflow = true;
				memcpy(dbg_buff, log.c_str(), log.size());
				head = log.size();
				dbg_buff[head] = '\0';
			}
		}
#ifdef PRINT_LOG
		kprintf("%s", log.c_str());
#endif
	}

	void panic(const char *srcfile, int line, const char *func,
			const char *reason)
	{
		log(srcfile, line, func, reason);

	}
}