#ifndef SCHEDULER_H
#define SCHEDULER_H

#include "Types.h"
#include "process.h"
#include "global_defines.h"
#include "deque.h"

namespace scheduler
{
	extern Process processVec[MAX_PROCESS_COUNT];
	extern uint32 currentProcess;
	extern uint32 processCount;
	extern std::deque<uint32> readyQue;
	extern std::deque<uint32> waitQue;
	extern uint32 switchCount;

	void init (uint32 kernel_esp, uint32 kernel_eip);
	void update (uint32 interruptPushBase);
	int addProcess (uint32 esp, uint32 eip, uint32 ss, uint32 cs,
			uint32 cr3, uint32 time);
}

#endif