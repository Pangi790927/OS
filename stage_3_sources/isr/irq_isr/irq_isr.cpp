#include "irq_isr.h"
#include "Types.h"
#include "c_asm_func.h"
#include "kstdio.h"
#include "idt.h"
#include "isr.h"
#include "global_defines.h"

#include "keyboard.h"

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
	static int time = 0;
	time++;
	// printf("irq 0, time: %d\n", time++);
	irq_isr::aknowledge_irq_master();
}

void isr_irq_1 () {
	// printf("irq 1\n");
	if (keyboard::checkInit())
		keyboard::irq(inb(keyboard::DATA_PORT));
	// printf("%d\n", result);
	irq_isr::aknowledge_irq_master();
}

void isr_irq_2 () {kprintf("irq 2\n");}

void isr_irq_3 () {
	kprintf("irq 3\n");
	irq_isr::aknowledge_irq_master();
}

void isr_irq_4 () {kprintf("irq 4\n");}
void isr_irq_5 () {kprintf("irq 5\n");}
void isr_irq_6 () {kprintf("irq 6\n");}
void isr_irq_7 () {kprintf("irq 7\n");}
void isr_irq_8 () {kprintf("irq 8\n");}
void isr_irq_9 () {kprintf("irq 9\n");}
void isr_irq_10 () {kprintf("irq 10\n");}
void isr_irq_11 () {kprintf("irq 11\n");}
void isr_irq_12 () {kprintf("irq 12\n");}
void isr_irq_13 () {kprintf("irq 13\n");}
void isr_irq_14 () {kprintf("irq 14\n");}
void isr_irq_15 () {kprintf("irq 15\n");}

void set_irq_ISR() {
	uint8 attr = isr::makeAttr(1, 0, 0, isr::INTR_GATE);
	isr::addISR(0x20, irq0, CODE_SEL, attr);
	isr::addISR(0x21, irq1, CODE_SEL, attr);
	isr::addISR(0x22, irq2, CODE_SEL, attr);
	isr::addISR(0x23, irq3, CODE_SEL, attr);
	isr::addISR(0x24, irq4, CODE_SEL, attr);
	isr::addISR(0x25, irq5, CODE_SEL, attr);
	isr::addISR(0x26, irq6, CODE_SEL, attr);
	isr::addISR(0x27, irq7, CODE_SEL, attr);
	isr::addISR(0x28, irq8, CODE_SEL, attr);
	isr::addISR(0x29, irq9, CODE_SEL, attr);
	isr::addISR(0x2a, irq10, CODE_SEL, attr);
	isr::addISR(0x2b, irq11, CODE_SEL, attr);
	isr::addISR(0x2c, irq12, CODE_SEL, attr);
	isr::addISR(0x2d, irq13, CODE_SEL, attr);
	isr::addISR(0x2e, irq14, CODE_SEL, attr);
	isr::addISR(0x2f, irq15, CODE_SEL, attr);
}
