#ifndef KMUTEX_H
#define KMUTEX_H

#include "ksem.h"

namespace kthread
{
	struct Mutex {
		kthread::Sem sem;

		void init();
		void lock();
		void unlock();
		bool try_lock();
	};
}

#endif