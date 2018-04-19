#ifndef PAIR_H
#define PAIR_H

#include "utility.h"

namespace std
{
	template <typename FirstType, typename SecondType>
	class pair {
	public:
		FirstType first;
		SecondType second;

		pair() {}
		pair (const FirstType& first, const SecondType& second)
		: first(first), second(second) {}
		pair (const FirstType&& first, const SecondType&& second)
		: first(std::move(first)), second(std::move(second)) {}

		pair (const pair& other)
		: first(other.first), second(other.second) {}
		pair (const pair&& other)
		: first(std::move(other.first)), second(std::move(other.second)) {}

		pair& operator = (const pair& other) {
			first = other.first;
			second = other.second;
			return (*this);
		}

		pair& operator = (const pair&& other) {
			first = std::move(other.first);
			second = std::move(other.second);
			return (*this);
		}

		bool operator == (const pair& other) {
			return (first == other.first) && (second == other.second);
		}

		bool operator != (const pair& other) {
			return !((*this) == other);
		}

		bool operator < (const pair& other) {
			return first < other.first
					|| (!(other.first < first) && second < other.second);
		}

		bool operator > (const pair& other) {
			return (other < (*this));
		}

		bool operator <= (const pair& other) {
			return !(other < (*this));
		}

		bool operator >= (const pair& other) {
			return !((*this) < other);
		}
	};
}

#endif