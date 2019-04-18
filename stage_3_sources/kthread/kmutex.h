#ifndef KMUTEX_H
#define KMUTEX_H

#include "klock.h"

namespace kthread
{
	struct Mutex {
		kthread::Lock lk;

		void init();
		void lock();
		void unlock();
		bool try_lock();
	};
}

#endif