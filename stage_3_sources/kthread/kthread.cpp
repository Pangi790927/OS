#include "kthread.h"
#include "memmanip.h"
#include "lock_guard.h"

namespace kthread
{
	Thread *Thread::caller_thread = 0;
	kthread::Lock Thread::thread_spawn_lock;

	Thread::Thread (void (*cbk)(void *), void *ctx,
				uint32 stack_size) 
				: Thread(cbk_t<>(cbk, ctx), stack_size) {}

	Thread::Thread (const cbk_t<>& cbk, 
			uint32 stack_size) : cbk(cbk)
	{
		thread_spawn_lock.lock();
		caller_thread = this;
		stack = new char [stack_size];

		scheduler::addProcess(uint32(stack + stack_size - 1), (uint32)&caller,
			KERNEL_DATA_SEL, KERNEL_CODE_SEL, K_PAGING, 10);
	}

	bool Thread::joinable() {
		std::lock_guard<Lock> guard(thread_spawn_lock);
		return !joined;
	}

	void Thread::join() {
		joined = true;
		while (done != true)
			asm volatile ("");

		// what will happen with stack on detach?
		delete [] stack;
	}

	void Thread::caller() {
		Thread& thread = *caller_thread;
		thread_spawn_lock.unlock();
		thread.cbk();
		thread.done = true;
		scheduler::kill(scheduler::getPid());
		while (true)
			asm volatile ("");
	}

	void init() {
		Thread::thread_spawn_lock.init();
	}
}
