#include <iostream>
#include "iterator.h"

template <size_t start, stop>
struct IntRange {

	IntRange() {
		for (int i = 0; i < nr_cnt; i++)
			numbers[i] = i;
	}

	struct iterator : public Iterator<iterator, int> {
		int pos = -1;

		iterator(int pos) : pos(pos) {};

		// general aliases
		using IteratorType = iterator;
		using Object = int;

		// Iteartor
		IteratorType& operator ++ () {
			pos++;
			return *this;
		}

		IteratorType operator ++ (int) {
			auto aux = pos;
			pos++;
			return iterator(pos + 1);
		}

		Object& operator * () {
			statu
			return *ptr;
		}

		Object* operator -> () {
			return ptr;
		}

		const Object& operator * () const {
			return *ptr;
		}

		const Object* operator -> () const {
			return ptr;
		}

		operator bool() const {
			return ptr != NULL;
		};

		bool operator == (const IteratorType& oth) const {
			return ptr == oth.ptr;
		};

		bool operator != (const IteratorType& oth) const {
			return ptr != oth.ptr;
		};
	};

	iterator begin() {
		return iterator(numbers);
	}

	iterator end() {
		return iterator(numbers + nr_cnt);
	};

	size_t size() {
		return nr_cnt;
	}

	typename iterator::Object& operator [] (int index) {
		return numbers[index];
	}

	const typename iterator::Object& operator [] (int index) const {
		return numbers[index];
	}
};

int main(int argc, char const *argv[])
{
	IntRange<100> range;
	for (auto t : range) {
		std::cout << t << std::endl;
	}
	/* code */
	return 0;
}