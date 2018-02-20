#ifndef IRQ_H
#define IRQ_H

#include "Types.h"

struct registers_irq
{
	u_int_32 ds;                  						// Data segment selector
	u_int_32 edi, esi, ebp, esp, ebx, edx, ecx, eax; 	// Pushed by pusha.
	u_int_32 int_no, err_code;    						// Interrupt number and error code (if applicable)
	u_int_32 eip, cs, eflags, useresp, ss;	 			// Pushed by the processor automatically.

	void dump_all();
};

void register_callback (int intr_number, void (*func)(registers_irq&));
u_int_32 get_callback (int number);

/// this asm("isr_handler") part took me a day to figure it out
void irq_handler (registers_irq regs) asm("irq_handler");

#endif