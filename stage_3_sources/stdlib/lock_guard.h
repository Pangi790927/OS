#ifndef LOCK_GUARD_H
#define LOCK_GUARD_H

namespace std
{
	template <typename Lockable>
	struct lock_guard {
		Lockable &lock;

		lock_guard (Lockable& lock) : lock(lock) {
			lock.lock();
		}

		~lock_guard () {
			lock.unlock();
		}
	};
}

#endif