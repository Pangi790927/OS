#ifndef RAMSIZE_H
#define RAMSIZE_H

#include "types.h"

struct ramsize_t {
	uint16_t ax; // kbytes under 16M
	uint16_t bx; // 64k blocks after 16M
} __attribute__((__packed__));

#endif
