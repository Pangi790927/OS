#include "kmutex.h"
#include "klock.h"
#include "scheduler.h"

namespace kthread
{
	void Mutex::init() {
		lk.init();
	}

	void Mutex::lock () {
		while (!lk.try_lock())
			scheduler::yield();
	}

	bool Mutex::try_lock() {
		return lk.try_lock();
	}

	void Mutex::unlock() {
		lk.unlock();
	}
}