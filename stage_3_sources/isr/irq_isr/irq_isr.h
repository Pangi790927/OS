#ifndef IRQ_ISR_H
#define IRQ_ISR_H

#include "Types.h"

namespace irq_isr
{
	const uint8 PIC_MASTER_OFFSET = 0x20;
	const uint8 PIC_SLAVE_OFFSET = 0x28;

	const uint16 PIC_MASTER_COMM = 0x20;
	const uint16 PIC_MASTER_DATA = 0x21;
	const uint16 PIC_SLAVE_COMM = 0xA0;
	const uint16 PIC_SLAVE_DATA = 0xA1;

	// End Of Interrupt
	const uint8 PIC_EOI = 0x20;
	
	// Interrupt Command Words
	const uint8 ICW1_ICW4_NEEDED = 0x01;
	const uint8 ICW1_INITIALIZATION = 0x10;

	const uint8 ICW4_8086 = 0x01;
	
	void remap (uint8 masterOffset = PIC_MASTER_OFFSET,
			uint8 slaveOffset = PIC_SLAVE_OFFSET);

	void aknowledge_irq_master();
	void aknowledge_irq_slave();

	void sendMasterMask (uint8 mask);
	void sendSlaveMask (uint8 mask);
}

void set_irq_ISR();

void isr_irq_0 () asm("isr_irq_0");
void isr_irq_1 () asm("isr_irq_1");
void isr_irq_2 () asm("isr_irq_2");
void isr_irq_3 () asm("isr_irq_3");
void isr_irq_4 () asm("isr_irq_4");
void isr_irq_5 () asm("isr_irq_5");
void isr_irq_6 () asm("isr_irq_6");
void isr_irq_7 () asm("isr_irq_7");
void isr_irq_8 () asm("isr_irq_8");
void isr_irq_9 () asm("isr_irq_9");
void isr_irq_10 () asm("isr_irq_10");
void isr_irq_11 () asm("isr_irq_11");
void isr_irq_12 () asm("isr_irq_12");
void isr_irq_13 () asm("isr_irq_13");
void isr_irq_14 () asm("isr_irq_14");
void isr_irq_15 () asm("isr_irq_15");

#endif