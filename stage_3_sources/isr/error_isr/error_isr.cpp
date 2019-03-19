#include "error_isr.h"
#include "kstdio.h"
#include "idt.h"
#include "isr.h"
#include "gdt.h"
#include "c_asm_func.h"

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

static void report_error (err_reg_isr& regs, bool block);

void isr_error_handler (err_reg_isr regs) {
	(void)regs;
	kprintf("Interrupt occoured and entered generic handler\n");
}

void isr_error_0 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_1 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_2 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_3 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_4 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_5 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_6 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_7 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_8 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_9 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_10 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_11 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_12 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_13 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_14 (err_reg_isr regs) {
	report_error(regs, false);
	kprintf("cr2: 0x%x\n", __getCR2());
	while (true)
		asm volatile ("");
}

void isr_error_16 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_17 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_18 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_19 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_20 (err_reg_isr regs) {
	report_error(regs, true);
}

void isr_error_30 (err_reg_isr regs) {
	report_error(regs, true);
}

void set_error_ISR() {
	uint8 attr = isr::makeAttr(1, 0, 0, isr::INTR_GATE);
	isr::addISR(0, error_isr0, KERNEL_CODE_SEL, attr);
	isr::addISR(1, error_isr1, KERNEL_CODE_SEL, attr);
	isr::addISR(2, error_isr2, KERNEL_CODE_SEL, attr);
	isr::addISR(3, error_isr3, KERNEL_CODE_SEL, attr);
	isr::addISR(4, error_isr4, KERNEL_CODE_SEL, attr);
	isr::addISR(5, error_isr5, KERNEL_CODE_SEL, attr);
	isr::addISR(6, error_isr6, KERNEL_CODE_SEL, attr);
	isr::addISR(7, error_isr7, KERNEL_CODE_SEL, attr);
	isr::addISR(8, error_isr8, KERNEL_CODE_SEL, attr);
	isr::addISR(9, error_isr9, KERNEL_CODE_SEL, attr);
	isr::addISR(10, error_isr10, KERNEL_CODE_SEL, attr);
	isr::addISR(11, error_isr11, KERNEL_CODE_SEL, attr);
	isr::addISR(12, error_isr12, KERNEL_CODE_SEL, attr);
	isr::addISR(13, error_isr13, KERNEL_CODE_SEL, attr);
	isr::addISR(14, error_isr14, KERNEL_CODE_SEL, attr);
	isr::addISR(15, error_isr15, KERNEL_CODE_SEL, attr);
	isr::addISR(16, error_isr16, KERNEL_CODE_SEL, attr);
	isr::addISR(17, error_isr17, KERNEL_CODE_SEL, attr);
	isr::addISR(18, error_isr18, KERNEL_CODE_SEL, attr);
	isr::addISR(19, error_isr19, KERNEL_CODE_SEL, attr);
	isr::addISR(20, error_isr20, KERNEL_CODE_SEL, attr);
	isr::addISR(21, error_isr21, KERNEL_CODE_SEL, attr);
	isr::addISR(22, error_isr22, KERNEL_CODE_SEL, attr);
	isr::addISR(23, error_isr23, KERNEL_CODE_SEL, attr);
	isr::addISR(24, error_isr24, KERNEL_CODE_SEL, attr);
	isr::addISR(25, error_isr25, KERNEL_CODE_SEL, attr);
	isr::addISR(26, error_isr26, KERNEL_CODE_SEL, attr);
	isr::addISR(27, error_isr27, KERNEL_CODE_SEL, attr);
	isr::addISR(28, error_isr28, KERNEL_CODE_SEL, attr);
	isr::addISR(29, error_isr29, KERNEL_CODE_SEL, attr);
	isr::addISR(30, error_isr30, KERNEL_CODE_SEL, attr);
	isr::addISR(31, error_isr31, KERNEL_CODE_SEL, attr);
}

static const char *error_to_str[] = {
	"Divide by zero",
	"Debug",
	"Non-maskable Interrupt",
	"Breakpoint",
	"Overflow",
	"Bound Range Exceeded",
	"Invalid Opcode",
	"Device Not Available",
	"Double Fault",
	"Coprocessor Segment Overrun",
	"Invalid TSS",
	"Segment Not Present",
	"Stack-Segment Fault",
	"General Protection Fault",
	"Page Fault",
	"Reserved",
	"x87 Floating-Point Exception",
	"Alignment Check",
	"Machine Check",
	"SIMD Floating-Point Exception",
	"Virtualization Exception",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Security Exception",
	"Reserved"
};

void report_error (err_reg_isr& regs, bool block) {
	kprintf("Received error: %s, [%d, err code: 0x%x]\n",
			error_to_str[regs.int_no], regs.int_no, regs.err_code);
	kprintf("esp: %x, eip: %x\n", regs.esp, regs.eip);
	// kprintf("other regs ....")
	while (block)
		asm volatile ("");
}
