#ifndef ERROR_ISR_H
#define ERROR_ISR_H

#include "Types.h"

struct err_reg_isr
{
	uint32 int_no;									// interr no
	uint32 err_code;								// err code
	uint32 eip, cs, eflags, useresp, ss;	 		// Pushed by interrupt
};

// will add all error isr to the idt table
void set_error_ISR();

// generic handler
void isr_error_handler (err_reg_isr regs) asm("isr_error_handler");	

void isr_error_0 (err_reg_isr regs) asm("isr_error_0");
void isr_error_1 (err_reg_isr regs) asm("isr_error_1");
void isr_error_2 (err_reg_isr regs) asm("isr_error_2");
void isr_error_3 (err_reg_isr regs) asm("isr_error_3");
void isr_error_4 (err_reg_isr regs) asm("isr_error_4");
void isr_error_5 (err_reg_isr regs) asm("isr_error_5");
void isr_error_6 (err_reg_isr regs) asm("isr_error_6");
void isr_error_7 (err_reg_isr regs) asm("isr_error_7");
void isr_error_8 (err_reg_isr regs) asm("isr_error_8");
void isr_error_9 (err_reg_isr regs) asm("isr_error_9");
void isr_error_10 (err_reg_isr regs) asm("isr_error_10");
void isr_error_11 (err_reg_isr regs) asm("isr_error_11");
void isr_error_12 (err_reg_isr regs) asm("isr_error_12");
void isr_error_13 (err_reg_isr regs) asm("isr_error_13");
void isr_error_14 (err_reg_isr regs) asm("isr_error_14");
void isr_error_16 (err_reg_isr regs) asm("isr_error_16");
void isr_error_17 (err_reg_isr regs) asm("isr_error_17");
void isr_error_18 (err_reg_isr regs) asm("isr_error_18");
void isr_error_19 (err_reg_isr regs) asm("isr_error_19");
void isr_error_20 (err_reg_isr regs) asm("isr_error_20");
void isr_error_30 (err_reg_isr regs) asm("isr_error_30");

#endif