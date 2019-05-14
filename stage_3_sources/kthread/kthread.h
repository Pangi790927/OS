#ifndef KTHREAD_H
#define KTHREAD_H

#include "callbacks.h"
#include "scheduler.h"
#include "klock.h"
#include "atomic32.h"
#include "gdt.h"

namespace kthread
{
	void init();

	class Thread {
	public:
		static const uint32 DEFAULT_STACK_SIZE = 65536;
		char *stack;
		cbk_t<void(void *)> cbk;
		Atomic32 done = false;
		Atomic32 joined = false;

		Thread (const cbk_t<>& cbk,
				uint32 stack_size = DEFAULT_STACK_SIZE);
		Thread (void (*)(void *), void *ctx = NULL,
				uint32 stack_size = DEFAULT_STACK_SIZE);
		bool joinable();
		void join();

		static kthread::Lock thread_spawn_lock;
		static Thread *caller_thread;
		static void caller ();
	};
}

#endif