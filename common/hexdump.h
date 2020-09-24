#ifndef HEXDUMP_H
#define HEXDUMP_H

#include <cstdlib>
#include "str_utils.h"

namespace util
{
	inline void hexdump(void *ptr, size_t buflen) {
		unsigned char *buf = (unsigned char*)ptr;
		int i, j;
		std::string last_line;
		bool print_repeat = false;
		for (i=0; i<buflen; i+=16) {
			std::string line;
			std::string index_str = sformat("%06x: ", i);
			for (j=0; j<16; j++) 
				if (i+j < buflen)
					line += sformat("%02x ", buf[i+j]);
				else
					line += sformat("   ");
			line += sformat(" ");
			for (j=0; j<16; j++) 
				if (i+j < buflen)
					line += sformat("%c", isprint(buf[i+j]) ? buf[i+j] : '.');
			std::string result_line = index_str + line + "\n";
			if (line == last_line && i + 16 < buflen) {
				if (!print_repeat) {
					result_line = "...\n";
				}
				else {
					result_line = "";
				}
				print_repeat = true;
			}
			else {
				print_repeat = false;
			}
			last_line = line;
			printf("%s", result_line.c_str());
		}
	}
}

#endif