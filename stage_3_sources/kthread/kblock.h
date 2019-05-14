#ifndef KBLOCK_H
#define KBLOCK_H

#include "Types.h"
#include "klock.h"

namespace kthread
{
	struct block_t {
		block_t *next;
		block_t *prev;
		uint32 pid;
		void *data;
	};

	void init_block();
	block_t *add_blocked (block_t *prev, uint32 pid, void *data);
	void del_blocked (block_t *block);
}

#endif