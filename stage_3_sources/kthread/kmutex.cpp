#include "kmutex.h"

namespace kthread
{
	void Mutex::init() {
		sem.init(1);
	}

	void Mutex::lock () {
		sem.wait();
	}

	bool Mutex::try_lock() {
		return sem.try_aquire();
	}

	void Mutex::unlock() {
		sem.signal();
	}
}