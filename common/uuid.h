#ifndef UUID_H
#define UUID_H

#include <ctime>
#include "stdlib.h"

inline void create_uuid(char *data, uint32_t len) {
	ksrand(875);
	for (uint32_t i = 0; i < len; i++)
		data[i] = krand();
}

#endif