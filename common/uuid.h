#ifndef UUID_H
#define UUID_H

#include <ctime>
#include "stdlib.h"

inline void create_uuid(char *data, uint32_t len) {
	ksrand(time(0));
	for (int i = 0; i < len; i++)
		data[i] = krand();
}

#endif