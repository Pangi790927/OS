#ifndef SCHEDULER_H
#define SCHEDULER_H

#include "Types.h"
#include "process.h"
#include "global_defines.h"
#include "deque.h"

namespace scheduler
{
	class ProcessIdQue {
	public:
		uint32 que[MAX_PROCESS_COUNT];
		int start;
		int end;
		size_t size;

		ProcessIdQue() : start(0), end(0), size(0) {}

		void push_back (uint32 id) {
			que[start] = id;
			start--;
			size++;
			if (start < 0) {
				start = MAX_PROCESS_COUNT - 1;
			}
		}

		void pop_front () {
			end--;
			size--;
			if (end < 0) {
				end = MAX_PROCESS_COUNT - 1;
			}
		}

		uint32 front() {
			return que[end];
		}
	};

	extern Process proc_vec[MAX_PROCESS_COUNT];
	extern uint32 curr_pid;
	extern uint32 proc_cnt;
	extern ProcessIdQue ready_que;
	extern ProcessIdQue wait_que;
	extern uint32 switch_cnt;

	void kill (uint32 pid);
	void yield();
	uint32 getPid();
	void init (uint32 kernel_esp, uint32 kernel_eip);
	uint32 update (uint32 interruptPushBase);
	int addProcess (uint32 esp, uint32 eip, uint32 ss, uint32 cs,
			uint32 cr3, uint32 time);
}

#endif