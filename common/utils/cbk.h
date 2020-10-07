#ifndef CBK_H
#define CBK_H

struct cbk_t {
	void *fn;
	void *ctx;

	/* 	all callbacks are required to return an int
		when a callback is called it's ctx isn't known */
	template <typename ...Args>
	int operator () (void *ctx, Args&& ...args) {
		using fn_t = int (*)(void *, Args...);
		return fn_t(fn)(ctx, args ...);
	}
};

#endif
