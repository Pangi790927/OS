#ifndef MUTEX_H
#define MUTEX_H

#include "kthread.h"

namespace std
{
	class mutex {
	public:
		kthread::Lock lockVar;

		mutex() {};

		mutex(const mutex& other) = delete;
		mutex(const mutex&& other) = delete;
		mutex& operator = (const mutex& other) = delete;
		mutex& operator = (const mutex&& other) = delete;

		void lock () {
			lockVar.lock();
		}

		bool try_lock() {
			return lockVar.try_lock();
		}

		void unlock() {
			lockVar.unlock();
		}
	};
}

#endif