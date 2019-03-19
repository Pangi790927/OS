#include "klock.h"
#include "kstdio.h"
#include "primitives.h"

namespace kthread
{
	void Lock::init() {
		lockVar = 0;
	}

	void Lock::lock () {
		uint32 expected = 0;
		while (!compare_exchange32(&lockVar, &expected, 1)) {
			if (expected == 0)
				kprintf("(panic) spooky stuf\n");
			expected = 0;
			asm volatile ("pause");
		}
	}

	bool Lock::try_lock() {
		uint32 expected = 0;
		return compare_exchange32(&lockVar, &expected, 1);
	}

	void Lock::unlock() {
		uint32 expected = 1;
		if (!compare_exchange32(&lockVar, &expected, 0)) {
			kprintf("(panic) unlock failed, time to cry\n");
		}
	}
}