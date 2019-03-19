#ifndef KTHREAD_H
#define KTHREAD_H

#include "callbacks.h"
#include "scheduler.h"
#include "klock.h"
#include "gdt.h"

namespace kthread
{
	void init();

	class Thread {
	public:
		static const uint32 DEFAULT_STACK_SIZE = 65536;
		char *stack;
		Callback<void(void *)> cbk;
		bool done = false; // must be replace with an atomic var

		Thread (const Callback<void(void *)>& cbk,
				uint32 stac_size = DEFAULT_STACK_SIZE);
		bool joinable();
		void join();

		static kthread::Lock thread_spawn_lock;
		static Thread *caller_thread;
		static void caller ();
	};
}

#endif