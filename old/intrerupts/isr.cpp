#include "isr.h"
#include "stdio.h"

void registers_isr::dump_all() {
	printf("INT nr: %d, err: %d\n", int_no, err_code);
	printf("Data Seg: %p\n", ds);
	printf("Registers pusha:\nedi:%x esi:%x ebp:%x esp:%x ebx:%x edx:%x ecx:%x eax:%x\n", 
			edi, esi, ebp, esp, ebx, edx, ecx, eax);
	printf("Registers cpu push:\neip:%x  cs:%x efl:%x usp:%x  ss:%x\n", 
			eip, cs, eflags, useresp, ss);
}

void isr_handler (registers_isr regs) {
	printf("ISR no: %d, err: %d\n", regs.int_no, regs.err_code);
}

void int13 (registers_isr regs) {
	regs.dump_all();
	printf("ERROR: hex: %x, bin: %b, E: %b, TLT: %b, Sel: %x\n",
			regs.err_code, regs.err_code, 
			regs.err_code & 0b1, (regs.err_code >> 1) & 0b11, (regs.err_code >> 3) & 0b1111111111111);
}