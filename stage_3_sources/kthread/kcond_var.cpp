#include "kcond_var.h"
#include "scheduler.h"
#include "lock_guard.h"

namespace kthread
{
	void CondVar::init() {
		chain_head = NULL;
		chain_tail = NULL;
		lk.init();
	}

	void CondVar::wait (Mutex& mu) {
		wait_for(mu, 0);
	}

	void CondVar::wait_for (Mutex& mu, uint32 ticks) {
		lk.lock();
		uint32 our_pid = scheduler::getPid();
		block_t *new_block = add_blocked(chain_head, our_pid, NULL);
		if (!chain_tail)
			chain_tail = new_block;
		chain_head = new_block;

		/* with the lk we may be in the case in wich we block after
		someone signals us, wich would be bad, but with this mutex
		no one can signal us before we block because lk prevents that */
		mu.unlock();
		
		/* the scheduler will unlock the lock for us */
		uint32 unblock_reason =
				scheduler::block(our_pid, scheduler::SEMAPHORE, &lk, ticks);
		
		/* we need to see why we where unblocked so we can remove our block_t 
		if we were unblocked by a timeout */
		if (unblock_reason == scheduler::TIME_UNBLOCK) {	
			std::lock_guard<Lock> guard(lk);
			if (chain_tail == new_block)
				chain_tail = new_block->next;
			if (chain_head == new_block)
				chain_head = new_block->prev;
			del_blocked(new_block);
		}

		mu.lock();
	}

	void CondVar::notify_one() {
		std::lock_guard<Lock> guard(lk);
		if (chain_tail) {
			/* notify one process */
			block_t *old = chain_tail;
			while (scheduler::unblock_reason(chain_tail->pid) ==
					scheduler::TIME_UNBLOCK)
			{
				chain_tail = chain_tail->next;
			}

			scheduler::unblock(chain_tail->pid, scheduler::SEMAPHORE);
			chain_tail = chain_tail->next;
			del_blocked(old);

			/* this means we signaled all waiting processes */
			if (!chain_tail)
				chain_head = NULL;
		}
	}

	void CondVar::notify_all_unsecure() {
		if (chain_tail) {
			/* notify all processes */
			for (block_t *it = chain_tail; it; it = it->next) {
				while (scheduler::unblock_reason(it->pid) ==
						scheduler::TIME_UNBLOCK && it)
				{
					it = it->next;
				}
				chain_tail = it->next;

				scheduler::unblock(it->pid, scheduler::SEMAPHORE);
				del_blocked(it);
			}

			/* this means we signaled all waiting processes */
			if (!chain_tail)
				chain_head = NULL;
		}
	}

	void CondVar::notify_all() {
		std::lock_guard<Lock> guard(lk);
		notify_all_unsecure();
	}
}