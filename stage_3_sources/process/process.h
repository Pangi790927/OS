#ifndef PROCESS_H
#define PROCESS_H

#include "Types.h"

struct __attribute__((__packed__)) task_stack_t
{
	uint32 edi;
	uint32 esi;
	uint32 ebp;
	uint32 esp;		// this is the esp before pushad in interupt
	
	uint32 ebx;
	uint32 edx;
	uint32 ecx;
	uint32 eax;

	uint32 it_eip;		// this is the interruped task eip
	uint32 it_cs;		// this is the interruped task cs
	uint32 it_flags;	// this is the interruped task flags
	uint32 it_esp;		// this is the interruped task esp (if aplicable)
	uint32 it_ss;		// this is the interruped task ss (if aplicable)
};

struct ProcessRegs {
	uint32 eax, ecx, edx, ebx, ebp, esi, edi;
	uint32 eip, cs, eflags, esp, ss;						// interrupt regs
	uint32 cr3;												// paging regs
};

class Process : public ProcessRegs {
public:
	uint32 pid;
	int time_left;
	uint32 time_given;
	uint32 dead;
	uint32 priv_level;
	task_stack_t stack;
};

#endif