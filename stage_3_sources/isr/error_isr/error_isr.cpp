#include "error_isr.h"
#include "kstdio.h"
#include "idt.h"
#include "isr.h"
#include "global_defines.h"

extern void error_isr0 () asm("error_isr0");
extern void error_isr1 () asm("error_isr1");
extern void error_isr2 () asm("error_isr2");
extern void error_isr3 () asm("error_isr3");
extern void error_isr4 () asm("error_isr4");
extern void error_isr5 () asm("error_isr5");
extern void error_isr6 () asm("error_isr6");
extern void error_isr7 () asm("error_isr7");
extern void error_isr8 () asm("error_isr8");
extern void error_isr9 () asm("error_isr9");
extern void error_isr10() asm("error_isr10");
extern void error_isr11() asm("error_isr11");
extern void error_isr12() asm("error_isr12");
extern void error_isr13() asm("error_isr13");
extern void error_isr14() asm("error_isr14");
extern void error_isr15() asm("error_isr15");
extern void error_isr16() asm("error_isr16");
extern void error_isr17() asm("error_isr17");
extern void error_isr18() asm("error_isr18");
extern void error_isr19() asm("error_isr19");
extern void error_isr20() asm("error_isr20");
extern void error_isr21() asm("error_isr21");
extern void error_isr22() asm("error_isr22");
extern void error_isr23() asm("error_isr23");
extern void error_isr24() asm("error_isr24");
extern void error_isr25() asm("error_isr25");
extern void error_isr26() asm("error_isr26");
extern void error_isr27() asm("error_isr27");
extern void error_isr28() asm("error_isr28");
extern void error_isr29() asm("error_isr29");
extern void error_isr30() asm("error_isr30");
extern void error_isr31() asm("error_isr31");

void isr_error_handler (err_reg_isr regs) {
	kprintf("Interrupt occoured and entered generic handler\n");
}

void isr_error_0 (err_reg_isr regs) {kprintf("Interrupt 0 ...\n");}
void isr_error_1 (err_reg_isr regs) {kprintf("Interrupt 1 ...\n");}
void isr_error_2 (err_reg_isr regs) {kprintf("Interrupt 2 ...\n");}
void isr_error_3 (err_reg_isr regs) {kprintf("Interrupt 3 ...\n");}
void isr_error_4 (err_reg_isr regs) {kprintf("Interrupt 4 ...\n");}
void isr_error_5 (err_reg_isr regs) {kprintf("Interrupt 5 ...\n");}
void isr_error_6 (err_reg_isr regs) {
	static bool flag = false;
	if (!flag) {
		kprintf("Interrupt 6 ...\n");
		flag = true;
	}
}
void isr_error_7 (err_reg_isr regs) {kprintf("Interrupt 7 ...\n");}
void isr_error_8 (err_reg_isr regs) {kprintf("Interrupt 8 ...\n");}
void isr_error_9 (err_reg_isr regs) {kprintf("Interrupt 9 ...\n");}
void isr_error_10 (err_reg_isr regs) {kprintf("Interrupt 10 ...\n");}
void isr_error_11 (err_reg_isr regs) {kprintf("Interrupt 11 ...\n");}
void isr_error_12 (err_reg_isr regs) {kprintf("Interrupt 12 ...\n");}
void isr_error_13 (err_reg_isr regs) {kprintf("Interrupt 13 ...\n");}
void isr_error_14 (err_reg_isr regs) {kprintf("Interrupt 14 ...\n");}
void isr_error_16 (err_reg_isr regs) {kprintf("Interrupt 16 ...\n");}
void isr_error_17 (err_reg_isr regs) {kprintf("Interrupt 17 ...\n");}
void isr_error_18 (err_reg_isr regs) {kprintf("Interrupt 18 ...\n");}
void isr_error_19 (err_reg_isr regs) {kprintf("Interrupt 19 ...\n");}
void isr_error_20 (err_reg_isr regs) {kprintf("Interrupt 20 ...\n");}
void isr_error_30 (err_reg_isr regs) {kprintf("Interrupt 30 ...\n");}

void set_error_ISR() {
	uint8 attr = isr::makeAttr(1, 0, 0, isr::INTR_GATE);
	isr::addISR(0, error_isr0, CODE_SEL, attr);
	isr::addISR(1, error_isr1, CODE_SEL, attr);
	isr::addISR(2, error_isr2, CODE_SEL, attr);
	isr::addISR(3, error_isr3, CODE_SEL, attr);
	isr::addISR(4, error_isr4, CODE_SEL, attr);
	isr::addISR(5, error_isr5, CODE_SEL, attr);
	isr::addISR(6, error_isr6, CODE_SEL, attr);
	isr::addISR(7, error_isr7, CODE_SEL, attr);
	isr::addISR(8, error_isr8, CODE_SEL, attr);
	isr::addISR(9, error_isr9, CODE_SEL, attr);
	isr::addISR(10, error_isr10, CODE_SEL, attr);
	isr::addISR(11, error_isr11, CODE_SEL, attr);
	isr::addISR(12, error_isr12, CODE_SEL, attr);
	isr::addISR(13, error_isr13, CODE_SEL, attr);
	isr::addISR(14, error_isr14, CODE_SEL, attr);
	isr::addISR(15, error_isr15, CODE_SEL, attr);
	isr::addISR(16, error_isr16, CODE_SEL, attr);
	isr::addISR(17, error_isr17, CODE_SEL, attr);
	isr::addISR(18, error_isr18, CODE_SEL, attr);
	isr::addISR(19, error_isr19, CODE_SEL, attr);
	isr::addISR(20, error_isr20, CODE_SEL, attr);
	isr::addISR(21, error_isr21, CODE_SEL, attr);
	isr::addISR(22, error_isr22, CODE_SEL, attr);
	isr::addISR(23, error_isr23, CODE_SEL, attr);
	isr::addISR(24, error_isr24, CODE_SEL, attr);
	isr::addISR(25, error_isr25, CODE_SEL, attr);
	isr::addISR(26, error_isr26, CODE_SEL, attr);
	isr::addISR(27, error_isr27, CODE_SEL, attr);
	isr::addISR(28, error_isr28, CODE_SEL, attr);
	isr::addISR(29, error_isr29, CODE_SEL, attr);
	isr::addISR(30, error_isr30, CODE_SEL, attr);
	isr::addISR(31, error_isr31, CODE_SEL, attr);
}