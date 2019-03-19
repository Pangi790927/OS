#ifndef KLOCK_H
#define KLOCK_H

#include "global_defines.h"

namespace kthread
{
	class Lock {
	public:
		uint32 lockVar __attribute__ ((aligned (16)));

		void init();
		void lock ();
		bool try_lock();
		void unlock();
	};
}

#endif