#include "ksem.h"
#include "lock_guard.h"
#include "scheduler.h"

namespace kthread
{
	void Sem::init (int initial) {
		val = initial;
		chain_head = NULL;
		chain_tail = NULL;
		lk.init();
	}

	void Sem::signal() {
		std::lock_guard<Lock> guard(lk);
		val++;
		if (chain_tail) {
			/* unblock val threads from the blocked chain */
			int cnt = val;
			for (block_t *it = chain_tail; it && cnt; it = it->next, cnt--) {
				chain_tail = it->next;
				scheduler::unblock(it->pid, scheduler::SEMAPHORE);
				del_blocked(it);
			}

			/* this means we signaled all waiting processes */
			if (!chain_tail)
				chain_head = NULL;
		}
	}

	void Sem::wait() {
		bool done = false;
		while (!done) {
			lk.lock();
			if (!val) {
				uint32 our_pid = scheduler::getPid();
				block_t *new_block = add_blocked(chain_head, our_pid, NULL);
				if (!chain_tail)
					chain_tail = new_block;
				chain_head = new_block;

				/* the scheduler will unlock the lock for us */
				scheduler::block(our_pid, scheduler::SEMAPHORE, &lk);
			}
			else {
				val--;
				done = true;
				lk.unlock();
			}
		}
	}

	bool Sem::try_aquire() {
		std::lock_guard<Lock> guard(lk);
		if (val) {
			val--;
			return true;
		}
		else {
			return false;
		}
	}
}