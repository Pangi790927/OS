#include "Types.h"

struct div_res_t {
	uint64 res;
	uint64 rem;
};

div_res_t divmod(uint64 a, uint64 b) {
	if (b == 0) {
		/* I should panic here or something, not ignore it, but it happens that
		this operation is used indirectly in the code that prints panics so...*/
		return { .res = 0, .rem = 0 };
	}

	uint64 it = 63;
	uint64 bpow = b;
	while (bpow >> 1) {
		it--;
		bpow >>= 1;
	}

	uint64 res = 0;
	uint64 rem = a;
	while (true) {
		if (rem >= (1ULL << it) * b) {
			rem -= (1ULL << it) * b;
			res += (1ULL << it);
		}
		if (it-- == 0)
			break;
	}

	return { .res = res, .rem = rem };
}

extern "C" unsigned long __udivdi3 (unsigned long a, unsigned long b) {
	return divmod(a, b).res;
}

extern "C" unsigned long __umoddi3 (unsigned long a, unsigned long b) {
	return divmod(a, b).rem;
}

extern "C" unsigned long __udivmoddi4 (unsigned long a, unsigned long b, 
		unsigned long *c)
{
	auto ret = divmod(a, b);
	*c = ret.rem;
	return ret.res;
}
