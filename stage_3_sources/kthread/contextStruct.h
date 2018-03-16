#ifndef CONTEXT_STRUCT_H
#define CONTEXT_STRUCT_H

namespace kthread
{
	struct ContextStruct {
		uint32 pid;
		uint32 status;	// ready, waiting
		
		uint32 eax;
		uint32 ebx;
		uint32 ecx;
		uint32 edx;
		uint32 esi;
		uint32 edi;
		uint32 ebp;
		uint32 esp;
		uint32 eip;
		uint32 flagsReg;

		uint32 pageBase;
		uint32 handBase;

		uint32 waitingTime;
		uint32 priority;		// irelevant ??
	};
}

#endif