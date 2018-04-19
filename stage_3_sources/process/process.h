#ifndef PROCESS_H
#define PROCESS_H

#include "Types.h"

struct ProcessRegs {
	uint32 eax, ecx, edx, ebx, ebp, esi, edi;
	uint32 eip, cs, eflags, esp, ss;						// interrupt regs
	uint32 cr3;												// paging regs
};

class Process : public ProcessRegs {
public:
	uint32 pid;
	int timeLeft;
	uint32 timeGiven;
	uint32 dead;
};

#endif