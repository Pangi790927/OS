
#ifndef ROUNDUP_DIV
#define ROUNDUP_DIV

inline uint32_t roundup_div(uint32_t value, uint32_t round) {
	return value / round + !!(value % round);
}

inline uint32_t roundup(uint32_t value, uint32_t round) {
	return roundup_div(value, round) * round;
}

#endif