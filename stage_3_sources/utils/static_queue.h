#ifndef STATIC_QUEUE_H
#define STATIC_QUEUE_H

template <typename Type, int max_size = 256>
struct static_queue_t {
	Type null;
	Type data[max_size];
	int start = 0;
	int stop = 0;
	int cnt = 0;

	void push(Type arg) {
		if (cnt == max_size)
			pop();
		data[stop] = arg;
		cnt++;
		stop = (stop + 1) % max_size;
	}

	void pop() {
		if (cnt) {
			cnt--;
			start = (start + 1) % max_size;
		}
	}

	Type& top() {
		if (cnt)
			return data[start];
		return null;
	}

	int size() {
		return cnt;
	}
};

#endif