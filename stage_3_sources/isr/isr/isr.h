#ifndef ISR_H
#define ISR_H

#include "Types.h"
#include "idt.h"

namespace isr
{
	const uint8 TASK_GATE = 0x5;
	const uint8 INTR_GATE = 0xE;	// for 32 bit system 
	const uint8 TRAP_GATE = 0xF;	// for 32 bit system

	struct interrupt_frame
	{
	    uint16 ip;
	    uint16 cs;
	    uint16 flags;
	    uint16 sp;
	    uint16 ss;
	};

	uint8 makeAttr (uint8 present, uint8 dpl, uint8 seg, uint8 gate);
	void addISR (int id, void (*isr_func)(), uint16 selector, uint8 attr);}

#endif