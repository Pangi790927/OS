#include "irq_isr.h"
#include "Types.h"
#include "c_asm_func.h"
#include "stdio.h"
#include "idt.h"
#include "isr.h"
#include "global_defines.h"

extern void irq0 () asm ("irq0");
extern void irq1 () asm ("irq1");
extern void irq2 () asm ("irq2");
extern void irq3 () asm ("irq3");
extern void irq4 () asm ("irq4");
extern void irq5 () asm ("irq5");
extern void irq6 () asm ("irq6");
extern void irq7 () asm ("irq7");
extern void irq8 () asm ("irq8");
extern void irq9 () asm ("irq9");
extern void irq10 () asm ("irq10");
extern void irq11 () asm ("irq11");
extern void irq12 () asm ("irq12");
extern void irq13 () asm ("irq13");
extern void irq14 () asm ("irq14");
extern void irq15 () asm ("irq15");

void irq_isr::remap (uint8 masterOffset, uint8 slaveOffset) {
	uint8 masterMask = inb(PIC_MASTER_DATA);
	uint8 slaveMask = inb(PIC_SLAVE_DATA);

	// ICW1
	outb(PIC_MASTER_COMM, ICW1_INITIALIZATION | ICW1_ICW4_NEEDED);
	io_wait();
	outb(PIC_SLAVE_COMM, ICW1_INITIALIZATION | ICW1_ICW4_NEEDED);
	io_wait();

	// ICW2: PIC vector offset
	outb(PIC_MASTER_DATA, masterOffset);
	io_wait();
	outb(PIC_SLAVE_DATA, slaveOffset);
	io_wait();

	// ICW3: Master PIC vector offset
	outb(PIC_MASTER_DATA, 4);
	io_wait();
	outb(PIC_SLAVE_DATA, 2);
	io_wait();

	// ICW4
	outb(PIC_MASTER_DATA, ICW4_8086);
	io_wait();
	outb(PIC_SLAVE_DATA, ICW4_8086);
	io_wait();

	// restore saved masks
	outb(PIC_MASTER_DATA, masterMask);
	outb(PIC_SLAVE_DATA, slaveMask);
}

void irq_isr::sendMasterMask (uint8 mask) {
	outb(PIC_MASTER_DATA, mask);
}

void irq_isr::sendSlaveMask (uint8 mask) {
	outb(PIC_SLAVE_DATA, mask);
}

void irq_isr::aknowledge_irq_master() {
	outb(PIC_MASTER_COMM, PIC_EOI);
}

void irq_isr::aknowledge_irq_slave() {
	outb(PIC_SLAVE_COMM, PIC_EOI);
	outb(PIC_MASTER_COMM, PIC_EOI);
}

void isr_irq_0 () {
	printf("irq 0\n");
	irq_isr::aknowledge_irq_master();
}

void isr_irq_1 () {printf("irq 1\n");}
void isr_irq_2 () {printf("irq 2\n");}

void isr_irq_3 () {
	printf("irq 3\n");
	irq_isr::aknowledge_irq_master();
}

void isr_irq_4 () {printf("irq 4\n");}
void isr_irq_5 () {printf("irq 5\n");}
void isr_irq_6 () {printf("irq 6\n");}
void isr_irq_7 () {printf("irq 7\n");}
void isr_irq_8 () {printf("irq 8\n");}
void isr_irq_9 () {printf("irq 9\n");}
void isr_irq_10 () {printf("irq 10\n");}
void isr_irq_11 () {printf("irq 11\n");}
void isr_irq_12 () {printf("irq 12\n");}
void isr_irq_13 () {printf("irq 13\n");}
void isr_irq_14 () {printf("irq 14\n");}
void isr_irq_15 () {printf("irq 15\n");}

void set_irq_ISR() {
	uint8 attr = isr::makeAttr(1, 0, 0, isr::INTR_GATE);
	isr::addISR(0x20, isr_irq_0, CODE_SEL, attr);
	isr::addISR(0x21, isr_irq_1, CODE_SEL, attr);
	isr::addISR(0x22, isr_irq_2, CODE_SEL, attr);
	isr::addISR(0x23, isr_irq_3, CODE_SEL, attr);
	isr::addISR(0x24, isr_irq_4, CODE_SEL, attr);
	isr::addISR(0x25, isr_irq_5, CODE_SEL, attr);
	isr::addISR(0x26, isr_irq_6, CODE_SEL, attr);
	isr::addISR(0x27, isr_irq_7, CODE_SEL, attr);
	isr::addISR(0x28, isr_irq_8, CODE_SEL, attr);
	isr::addISR(0x29, isr_irq_9, CODE_SEL, attr);
	isr::addISR(0x2a, isr_irq_10, CODE_SEL, attr);
	isr::addISR(0x2b, isr_irq_11, CODE_SEL, attr);
	isr::addISR(0x2c, isr_irq_12, CODE_SEL, attr);
	isr::addISR(0x2d, isr_irq_13, CODE_SEL, attr);
	isr::addISR(0x2e, isr_irq_14, CODE_SEL, attr);
	isr::addISR(0x2f, isr_irq_15, CODE_SEL, attr);
}
