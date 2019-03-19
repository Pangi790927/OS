#include "kthread.h"
#include "memmanip.h"

namespace kthread
{
	Thread *Thread::caller_thread = 0;
	kthread::Lock Thread::thread_spawn_lock;

	Thread::Thread (const Callback<void(void *)>& cbk, 
			uint32 stack_size) : cbk(cbk)
	{
		thread_spawn_lock.lock();
		caller_thread = this;
		stack = new char [stack_size];
		kprintf("added stack %x\n", (uint32)(stack + stack_size - 1));

		scheduler::addProcess(uint32(stack + stack_size - 1), (uint32)&caller,
			USER_DATA_SEL | 3, USER_CODE_SEL | 3, K_PAGING, 100);
	}

	bool Thread::joinable() {
		return done == true; 
	}

	void Thread::join() {
		delete [] stack; 
		while (done != true)
			asm volatile ("");
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
