#ifndef KCOND_VAR_H
#define KCOND_VAR_H

#include "kblock.h"
#include "kmutex.h"

namespace kthread
{
	struct CondVar {
		block_t *chain_head;
		block_t *chain_tail;
		Lock lk;

		void init();
		void wait (Mutex &mu);
		void wait_for (Mutex& mu, uint32 ticks);
		void notify_one();
		void notify_all();

		private:
		void notify_all_unsecure();
	};
}

#endif