#ifndef NETUTILS_H
#define NETUTILS_H

#include "Types.h"
#include "string.h"

namespace net {

	inline uint16 checksum (uint8 *buff, uint16 len) {
		uint32 sum = 0;

		if (len & 1) {
			sum += buff[len - 1] << 8;
			len--;
		}
		for (int i = 0; i < len; i += 2)
			sum += (buff[i] << 8) + buff[i + 1];
		while (sum >> 16)
			sum = (sum & 0xFFFF) + (sum >> 16);

		sum = ~sum;
		return sum;
	}

	inline std::string ip_to_str(uint32 ip) {
		std::string ret;

		ret += std::to_string((ip & 0x000000ff) >> 0);
		ret += ".";
		ret += std::to_string((ip & 0x0000ff00) >> 8);
		ret += ".";
		ret += std::to_string((ip & 0x00ff0000) >> 16);
		ret += ".";
		ret += std::to_string((ip & 0xff000000) >> 24);

		return ret;
	}

	inline uint32 str_to_ip (const std::string& str_ip) {
		uint32 ip = 0;
		uint32 i = 0;
		
		ip = (uint32)atoi(str_ip.c_str() + i) << 0;
		while (str_ip.c_str()[i++] != '.' && i < str_ip.size())
			;
		ip |= (uint32)atoi(str_ip.c_str() + i) << 8;
		while (str_ip.c_str()[i++] != '.' && i < str_ip.size())
			;
		ip |= (uint32)atoi(str_ip.c_str() + i) << 16;
		while (str_ip.c_str()[i++] != '.' && i < str_ip.size())
			;
		ip |= (uint32)atoi(str_ip.c_str() + i) << 24;

		return ip;
	}

	inline constexpr uint16 hton16 (uint16 val) {
		return		((val & 0x00ff) << 8)
				|	((val & 0xff00) >> 8);
	}

	inline constexpr uint32 hton32 (uint32 val) {
		return		((val & 0x000000ff) << 24)
				|	((val & 0xff000000) >> 24)
				|	((val & 0x0000ff00) << 8)
				|	((val & 0x00ff0000) >> 8);
	}

	inline constexpr uint64 hton64 (uint64 val) {
		return		((val & 0x00000000000000ff) << 56)
				|	((val & 0xff00000000000000) >> 56)
				|	((val & 0x000000000000ff00) << 40)
				|	((val & 0x00ff000000000000) >> 40)
				|	((val & 0x0000000000ff0000) << 24)
				|	((val & 0x0000ff0000000000) >> 24)
				|	((val & 0x00000000ff000000) << 8)
				|	((val & 0x000000ff00000000) >> 8);
	}

	inline constexpr uint16 ntoh16 (uint16 val) {
		return hton16(val);
	}

	inline constexpr uint32 ntoh32 (uint32 val) {
		return hton32(val);
	}

	inline constexpr uint64 ntoh64 (uint64 val) {
		return hton64(val);
	}

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