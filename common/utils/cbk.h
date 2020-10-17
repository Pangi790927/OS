#ifndef CBK_H
#define CBK_H

#include "dbg.h"

struct cbk_t {
	void *fn = NULL;
	void *ctx = NULL;

	/* 	all callbacks are required to return an int
		when a callback is called it's ctx isn't known */
	template <typename fn_type, typename ...Args>
	int call(Args&& ...args) {
		return (fn_type(fn))(ctx, args...);
	}
};

#endif
