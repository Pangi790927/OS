#include "irq_isr.h"
#include "Types.h"
#include "c_asm_func.h"
#include "kstdio.h"
#include "idt.h"
#include "isr.h"
#include "gdt.h"
#include "keyboard.h"
#include "scheduler.h"

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

CallbackVector<void(void *), irq_isr::MAX_CBK_COUNT> cbk_vec[16];

volatile static uint64 irq0_count = 0; 

int irq_isr::add_interupt_fn (int int_number, const Callback<fn_type>& cbk) {
	if (int_number < 0 || int_number > 15) {
		kprintf("int_number must be between 0 and 15\n");
		return -1;
	}
	return cbk_vec[int_number].insert(cbk);
}

int irq_isr::remove_interupt_fn(int int_number, const Callback<fn_type>& cbk) {
	if (int_number < 0 || int_number > 15) {
		kprintf("int_number must be between 0 and 15\n");
		return -1;
	}
	cbk_vec[int_number].remove(cbk);
	return 0;
}

static void exec_custom_interupts(int int_number) {
	cbk_vec[int_number].call();
}

uint64 irq_isr::get_irq0_count() {
	return irq0_count;
}

void irq_isr::init(uint8 masterOffset, uint8 slaveOffset) {
	for (int i = 0; i < 16; i++)
		cbk_vec[i] = CallbackVector<fn_type, MAX_CBK_COUNT>();
	remap(masterOffset, slaveOffset);
}

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

uint16 irq_isr::getIrqReg (uint32 ocw3) {
	outb(PIC_MASTER_COMM, ocw3);
    outb(PIC_SLAVE_COMM, ocw3);
    return (inb(PIC_SLAVE_COMM) << 8) | inb(PIC_MASTER_COMM);
}

uint16 irq_isr::getIsr () {
	return getIrqReg(OCW3_READ_ISR);
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

uint32 isr_irq_0 (uint32 base) {
	irq0_count++;
	uint32 esp = scheduler::update(base);
	irq_isr::aknowledge_irq_master();
	return esp;
}

void isr_irq_1 () {
	if (keyboard::checkInit())
		keyboard::irq(inb(keyboard::DATA_PORT));

	exec_custom_interupts(1);
	irq_isr::aknowledge_irq_master();
}

void isr_irq_2 () {
	kprintf("irq 2\n");
	exec_custom_interupts(2);
	irq_isr::aknowledge_irq_master();
}

void isr_irq_3 () {
	kprintf("irq 3\n");
	exec_custom_interupts(3);
	irq_isr::aknowledge_irq_master();
}

void isr_irq_4 () {
	kprintf("irq 4\n");
	exec_custom_interupts(4);
	irq_isr::aknowledge_irq_master();
}

void isr_irq_5 () {
	kprintf("irq 5\n");
	exec_custom_interupts(5);
	irq_isr::aknowledge_irq_master();
}

void isr_irq_6 () {
	kprintf("irq 6\n"); 
	exec_custom_interupts(6);
	irq_isr::aknowledge_irq_master();
}

void isr_irq_7 () {
	uint32 map = irq_isr::getIsr();
	if (!(map & (1 << 7))) {
		kprintf("irq 7 spourious\n");
	}
	else {
		kprintf("irq 7 non spourious\n");
		while (true);
	}
}
void isr_irq_8 () {
	kprintf("irq 8\n");
	exec_custom_interupts(8);
	irq_isr::aknowledge_irq_slave();
}
void isr_irq_9 () {
	kprintf("irq 9\n"); 
	exec_custom_interupts(9);
	irq_isr::aknowledge_irq_slave();
}
void isr_irq_10 () {
	kprintf("irq 10\n"); 
	exec_custom_interupts(10);
	irq_isr::aknowledge_irq_slave();
}
void isr_irq_11 () {
	// kprintf("irq 11\n"); 
	exec_custom_interupts(11);
	irq_isr::aknowledge_irq_slave();
}
void isr_irq_12 () {
	kprintf("irq 12\n"); 
	exec_custom_interupts(12);
	irq_isr::aknowledge_irq_slave();
}
void isr_irq_13 () {
	kprintf("irq 13\n"); 
	exec_custom_interupts(13);
	irq_isr::aknowledge_irq_slave();
}
void isr_irq_14 () {
	kprintf("irq 14\n");
	exec_custom_interupts(14);
	irq_isr::aknowledge_irq_slave();
}
void isr_irq_15 () {
	kprintf("irq 15\n"); 
	exec_custom_interupts(15);
	irq_isr::aknowledge_irq_slave();
}

void set_irq_ISR() {
	uint8 attr = isr::makeAttr(1, 0, 0, isr::INTR_GATE);
	isr::addISR(0x20, irq0, KERNEL_CODE_SEL, attr);
	isr::addISR(0x21, irq1, KERNEL_CODE_SEL, attr);
	isr::addISR(0x22, irq2, KERNEL_CODE_SEL, attr);
	isr::addISR(0x23, irq3, KERNEL_CODE_SEL, attr);
	isr::addISR(0x24, irq4, KERNEL_CODE_SEL, attr);
	isr::addISR(0x25, irq5, KERNEL_CODE_SEL, attr);
	isr::addISR(0x26, irq6, KERNEL_CODE_SEL, attr);
	isr::addISR(0x27, irq7, KERNEL_CODE_SEL, attr);
	isr::addISR(0x28, irq8, KERNEL_CODE_SEL, attr);
	isr::addISR(0x29, irq9, KERNEL_CODE_SEL, attr);
	isr::addISR(0x2a, irq10, KERNEL_CODE_SEL, attr);
	isr::addISR(0x2b, irq11, KERNEL_CODE_SEL, attr);
	isr::addISR(0x2c, irq12, KERNEL_CODE_SEL, attr);
	isr::addISR(0x2d, irq13, KERNEL_CODE_SEL, attr);
	isr::addISR(0x2e, irq14, KERNEL_CODE_SEL, attr);
	isr::addISR(0x2f, irq15, KERNEL_CODE_SEL, attr);
}
