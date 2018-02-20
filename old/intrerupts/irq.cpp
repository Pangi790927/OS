#include "irq.h"
#include "stdio.h"

#include "ProgramableIntreruptControler.h"

void registers_irq::dump_all() {
	printf("INT nr: %d, err: %d\n", int_no, err_code);
	printf("Data Seg: %p\n", ds);
	printf("Registers pusha:\nedi:%x esi:%x ebp:%x esp:%x ebx:%x edx:%x ecx:%x eax:%x\n", 
			edi, esi, ebp, esp, ebx, edx, ecx, eax);
	printf("Registers cpu push:\neip:%x  cs:%x efl:%x usp:%x  ss:%x\n", 
			eip, cs, eflags, useresp, ss);
}

void (*callback[16])(registers_irq& regs);

u_int_32 get_callback (int number) {
	return (u_int_32)(callback[number]);
}

void register_callback (int intr_number, void (*func)(registers_irq&)) {
	callback[intr_number] = func;
}

void irq_handler (registers_irq regs) {
	int irq_no = regs.int_no - 32;

	PIC::endOfInterrupt(irq_no);

	if (callback[irq_no]) {
		callback[irq_no](regs);
	}
}