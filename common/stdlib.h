#ifndef STDLIB_H
#define STDLIB_H

static unsigned short lfsr = 0xACE1u;
static unsigned bit;

inline void ksrand(unsigned b) {
	lfsr = 0xACE1u;
	bit = b;
}

inline unsigned krand() {
	bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ) & 1;
	return lfsr =  (lfsr >> 1) | (bit << 15);
}

#endif
