#ifndef KSEM_H
#define KSEM_H

#include "klock.h"
#include "kblock.h"

namespace kthread
{
	struct Sem {
		int val;
		block_t *chain_head;
		block_t *chain_tail;
		Lock lk;

		/* add sched block, and unblock on reason */
		void init (int initial);
		void signal();
		void wait();
		bool try_aquire();
	};
}

#endif