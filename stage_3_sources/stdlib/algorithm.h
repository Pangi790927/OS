#ifndef ALGORITHM_H
#define ALGORITHM_H

namespace std
{
	template <typename Type>
	static constexpr Type max (Type a, Type b) {
		return a > b ? a : b;
	}

	template <typename Type>
	static constexpr Type min (Type a, Type b) {
		return a < b ? a : b;
	}
}

#endif