#ifndef ISR_H
#define ISR_H

#include "Types.h"

struct registers_isr
{
	u_int_32 ds;										// Data segment selector
	u_int_32 edi, esi, ebp, esp, ebx, edx, ecx, eax; 	// Pushed by pusha.
	u_int_32 int_no, err_code;							// Interrupt number and error code (if applicable)
	u_int_32 eip, cs, eflags, useresp, ss;	 			// Pushed by the processor automatically.

	void dump_all();
};

/// this asm("isr_handler") part took me a day to figure it out
void isr_handler (registers_isr regs) asm("isr_handler");

void int13 (registers_isr regs) asm("int13");

#endif