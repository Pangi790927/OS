#include "kblock.h"
#include "global_defines.h"
#include "lock_guard.h"

namespace kthread
{
	static block_t blocks[MAX_PROCESS_COUNT];
	static int block_idx[MAX_PROCESS_COUNT] = {0};
	static int last_block_idx = 0;
	static int head = -1;
	static Lock lk;

	static int get_idx (block_t *block) {
		return ((uint8 *)block - (uint8 *)blocks) / sizeof(block_t);
	}

	void init_block() {
		lk.init();
	}

	block_t *add_blocked (block_t *prev, uint32 pid, void *data) {
		std::lock_guard<Lock> guard(lk);

		block_t *new_block = NULL;

		if (head != -1) {
			new_block = &blocks[block_idx[head]];
			head--;
		}
		else {
			new_block = &blocks[last_block_idx];
			last_block_idx++;
		}

		new_block->data = data;
		new_block->pid = pid;

		new_block->next = prev ? prev->next : NULL;
		new_block->prev = prev;
		if (prev)
			prev->next = new_block;
		if (new_block->next)
			new_block->next->prev = new_block;

		return new_block;
	}

	void del_blocked (block_t *block) {
		std::lock_guard<Lock> guard(lk);

		if (!block)
			return ;

		head++;
		block_idx[head] = get_idx(block);

		if (block->prev)
			block->prev->next = block->next;
		if (block->next)
			block->next->prev = block->prev;
	}
}