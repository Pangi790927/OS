#ifndef INTERVAL_MAP_H
#define INTERVAL_MAP_H

#include <functional>
#include <map>
#include <vector>

/* structure that holds intervals, it only holds disjunct intervals, when
a new interval is inserted it is merged with any overlapping intervals and
only the result is kept. Information is kept only on the starting end of the
interval and is merged with the supplied function in case of overlaps */
/* internaly it holds intervals by it's heads where (i, +) means that an
interval starts at i, inclusive and (j, -) means that an interval ends at j,
exclusive, i < j, if i >= j no interval will be inserted */
template <typename T>
class IntervalMap {
public:
	struct IntEnd {
		uint32_t index = 0;
		char dir = '+';

		bool operator < (const IntEnd& b) const {
			/* observe that the case (i, '+') && (i, '+') as well as the '-'
			counterpart doesn't make sense */
			return index < b.index ? true :
					index > b.index ? false :
					dir == '-' && b.dir == '+' ? true : false;
		}

		bool operator == (const IntEnd& b) const {
			return !((*this) < b || b < (*this));
		}

		bool operator <= (const IntEnd& b) const {
			return (*this) < b || (*this) == b;
		}
	};

	using Map = std::map<IntEnd, T>;
	using Iter = typename Map::iterator;
	std::function<void(T& keep, const T& oth)> merge_fn;
	Map intervals;

	IntervalMap() {}
	IntervalMap(const std::function<void(T& keep, const T& oth)> &merge_fn)
	: merge_fn(merge_fn) {}

	void clear() {
		intervals.clear();
	}

	bool insert(uint32_t start, uint32_t end, T&& t) {
		return insert(start, end, t);
	}

	bool insert(uint32_t start, uint32_t end, T& t) {
		if (start >= end)
			return false;
		auto l = IntEnd{start, '+'}; 
		auto r = IntEnd{end, '-'};
		bool done = false;
		while (!done) {
			Iter it;
			done = true;
			it = intervals.lower_bound(l);
			if (it != intervals.end() && it->first.dir == '+' &&
					it->first < r)
			{
				auto [ll, rr] = intersect(l, r, it, t);
				l = ll;
				r = rr;
				done = false;
			}
			if (it != intervals.end() && it->first.dir == '-') {
				auto [ll, rr] = intersect(l, r, it, t);
				l = ll;
				r = rr;
				done = false;
			}
		}
		intervals[l] = t;
		intervals[r];
		return true;
	}

	auto intersect(const IntEnd &l, const IntEnd &r, Iter &it, T& t) {
		IntEnd ll;
		IntEnd rr;
		if (it->first.dir == '+') {
			ll = it->first;
			rr = std::next(it)->first;
			merge_fn(t, it->second);
			intervals.erase(std::next(it));
		}
		else {
			ll = std::prev(it)->first;
			rr = it->first;
			merge_fn(t, std::prev(it)->second);
			intervals.erase(std::prev(it));
		}
		intervals.erase(it);
		return std::tuple(std::min(l, ll), std::max(r, rr));
	}

	auto begin() {
		return intervals.begin();
	}

	auto end() {
		return intervals.end();
	}

	template <typename Fn>
	void iterate(Fn&& fn) {
		for (auto &&[k, v] : intervals) {
			if (k.dir == '+') {
				fn(v);
			}
		}
	}
};

#endif