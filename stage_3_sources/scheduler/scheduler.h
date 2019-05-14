#ifndef SCHEDULER_H
#define SCHEDULER_H

#include "Types.h"
#include "process.h"
#include "global_defines.h"
#include "deque.h"
#include "vector.h"
#include "klock.h"

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

	enum BLOCK_ENUM {
		NOT_BLOCKED = 0,
		SEMAPHORE,
		READ,
		WRITE,
		ANY
	};

	enum UNBLOCK_ENUM {
		NOT_UNBLOCKED,
		UNBLOCK,
		TIME_UNBLOCK,
	};

	struct time_pid_t {
		uint64 unblock_time;
		uint32 pid;

		time_pid_t (uint64 unblock_time = 0, uint32 pid = 0) 
				: unblock_time(unblock_time), pid(pid) {}

		bool operator > (const time_pid_t& other) const {
			if (unblock_time > other.unblock_time)
				return true;
			else if (unblock_time == other.unblock_time)
				return pid > other.pid;
			return false; 	
		}

		bool operator < (const time_pid_t& other) const {
			if (unblock_time < other.unblock_time)
				return true;
			else if (unblock_time == other.unblock_time)
				return pid < other.pid;
			return false; 	
		}

		bool operator == (const time_pid_t& other) const {
			return unblock_time == other.unblock_time && pid == other.pid;
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
	uint32 block (uint32 pid, int reason, kthread::Lock *lk = NULL,
			uint32 ticks = 0);
	void unblock (uint32 pid, int reason);
	void init (uint32 kernel_esp, uint32 kernel_eip);
	uint32 update (uint32 interruptPushBase);
	uint32 unblock_reason (uint32 pid);
	int addProcess (uint32 esp, uint32 eip, uint32 ss, uint32 cs,
			uint32 cr3, uint32 time);
	std::vector<uint32> active_pids();
}

#endif