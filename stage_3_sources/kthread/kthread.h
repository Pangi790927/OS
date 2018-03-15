#ifndef KTHREAD_H
#define KTHREAD_H

#include "global_defines.h"

extern void multiGetLock (uint32 *lockVar) asm("multiGetLock");
extern int multiTryLock (uint32 *lockVar) asm("multiTryLock");
extern void multiUnlock (uint32 *lockVar) asm("multiUnlock");

extern void singleGetLock (uint32 *lockVar) asm("singleGetLock");
extern int singleTryLock (uint32 *lockVar) asm("singleTryLock");
extern void singleUnlock (uint32 *lockVar) asm("singleUnlock");

namespace kthread
{
	class Lock {
	public:
		uint32 lockVar __attribute__ ((aligned (16)));

		void lock () {
			#ifdef MULTI_CORE
				procGetLock(&lockVar);
			#else
				singleGetLock(&lockVar);
			#endif
		}

		bool try_lock() {
			#ifdef MULTI_CORE
				if (procTryLock(&lockVar))
					return true;
			#else
				if (singleTryLock(&lockVar))
					return true;
			#endif

			return false;
		}

		void unlock() {
			#ifdef MULTI_CORE
				procUnlock(&lockVar);
			#else
				singleUnlock(&lockVar);
			#endif
		}
	};
}

#endif