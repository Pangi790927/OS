#ifndef NETUTILS_H
#define NETUTILS_H

namespace net {
	/* Computes the directional distance between left and right modulo mod.
	If mod is 0 the number is modulo 2^32.
	An example:
		0 1 2 3 4 5 6 7 8 9
		    r   l
	Here left is 4 and right is 2 the direction distance between left and
	right is 8 which is equal to (r + 10) - l so by cycling when we get to
	10 we need to take 8 steps to get from left to right. So we are actually
	computing the minimum positive x such that (l + x) % mod == r
	*/
	inline uint32 mdist (uint32 left, uint32 right, uint32 mod = 0) {
		if (left == right)
			return 0;
		if (left < right)
			return right - left;
		else {
			if (mod == 0)
				return right - left;
			else
				return right + mod - left;
		}
	}

	inline uint32 madd (uint32 value, uint32 to_add, uint32 mod = 0) {
		if (!mod)
			return value + to_add;
		if (to_add >= mod)
			to_add = to_add % mod;

		if (to_add > mod - 1 - value)
			return to_add + value - mod;
		else
			return value + to_add;
	}

	inline uint32 msub (uint32 value, uint32 to_sub, uint32 mod = 0) {
		if (!mod)
			return value - to_sub;
		if (to_sub >= mod)
			to_sub = to_sub % mod;
		if (value < to_sub)
			return mod + value - to_sub;
		else
			return value - to_sub;
	}

	inline void minc (uint32 &value, uint32 mod = 0) {
		if (value == mod - 1 && mod)
			value = 0;
		else
			value = value + 1;
	}

	inline void mdec (uint32 &value, uint32 mod = 0) {
		if (value == 0 && mod)
			value = mod - 1;
		else
			value = value - 1;
	}
}

#endif