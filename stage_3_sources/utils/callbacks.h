#ifndef CALLBACKS_H
#define CALLBACKS_H

#include <type_traits>
#include "Types.h"
#include "kstdio.h"

template <typename FuncType>
struct Callback {
	FuncType *func = NULL;
	void *ctx = NULL;

	Callback() {}
	Callback (FuncType *func, void *ctx = NULL) : func(func), ctx(ctx) {}
	Callback (const FuncType& func, void *ctx = NULL) : func(&func), ctx(ctx) {}

	template <typename ...Args, typename RetType = 
			std::invoke_result_t<FuncType, Args..., void *>>
	std::invoke_result_t<FuncType, Args..., void *>
	operator () (Args&& ...args) {
		if constexpr (std::is_same_v<RetType, void>)
		{
			if (!func)
				kprintf("Calling unitialized function!!!!!");
			func(args..., ctx);
		}
		else {
			if (!func)
				kprintf("Calling unitialized function!!!!!");
			return func(args..., ctx);
		}
	}

	template <typename ...Args, typename RetType =
			std::invoke_result_t<FuncType, Args...>>
	std::invoke_result_t<FuncType, Args...>
	operator () (Args&& ...args) {
		if constexpr (std::is_same_v<RetType, void>)
		{
			if (!func)
				kprintf("Calling unitialized function!!!!!");
			func(args...);
		}
		else {
			if (!func)
				kprintf("Calling unitialized function!!!!!");
			return func(args...);
		}
	}

	template <typename OthFunc>
	operator Callback<OthFunc>() {
		return Callback<OthFunc>((OthFunc *)func, ctx);
	}

	void reset (FuncType *func = NULL, void *ctx= NULL) {
		this->func = func;
		this->ctx = ctx;
	}

	operator uint32() const {
		return (uint32)func;
	}

	bool operator == (const Callback& other) const {
		return other.func == func && other.ctx == ctx;
	}
};

template <typename FuncType, int max_size, int defrag = -1>
struct CallbackVector {
	Callback<FuncType> cbks[max_size] = {0};
	int size = 0;
	int count = 0;
	int last_defrag = 0;

	template <typename ...Args>
	void call (Args&&... args) {
		int call_count = 0;
		for (int i = 0; i < size; ++i) {
			if (call_count == count)
				break;
			if (cbks[i])
				cbks[i](args...);
		}
	}

	void defrag_apply (bool force = false) {
		if (count == size)
			return ;

		if (force || last_defrag == -1)
			return ;

		if (force || last_defrag != 0) {
			last_defrag--;
			return ;
		}

		last_defrag = defrag;

		int last_empty = -1;
		for (int i = 0; i < size; i++) {
			if (cbks[i] && last_empty != -1) {
				cbks[last_empty] = cbks[i];
				cbks[i].reset();
				last_empty++;
			}
			if (last_empty == -1 && !cbks[i])
				last_empty = i;
		}
		count = size = last_empty;
	}

	int insert (const Callback<FuncType>& cbk) {
		if (has_cbk(cbk))
			return -1;
		if (count == size) {
			if (size == max_size)
				return -1;
			cbks[size++] = cbk;
			count++;
			return 0;
		}
		else {
			for (int i = 0; i < size; i++) {
				if (!cbks[i]) {
					cbks[i] = cbk;
					count++;
					defrag_apply();
					return 0;
				}
			}
		}
		return -1;
	}

	void remove (const Callback<FuncType>& cbk) {
		for (int i = 0; i < size; i++) {
			if (cbk == cbks[i]) {
				cbks[i].reset(NULL);
				defrag_apply();
			}
		}
	}

	bool has_cbk (const Callback<FuncType>& cbk) {
		for (int i = 0; i < size; i++)
			if (cbks[i] == cbk)
				return true;
		return false;
	}

	bool has_func (FuncType *func) {
		for (int i = 0; i < size; i++)
			if (cbks[i].func == func)
				return true;
		return false;
	}

};

#endif