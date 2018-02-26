#include "stdio.h"
#include "isr.h"
#include "error_isr.h"
#include "irq_isr.h"
#include "pit.h"

int main()
{
	clear_screen();
	printf("Stage 3\n");

	asm volatile ("cli");
		set_error_ISR();
		set_irq_ISR();
		
		idt::loadIDT();
		
		irq_isr::remap();
		irq_isr::sendMasterMask(0xfe);
		irq_isr::sendSlaveMask(0xff);
		
		pit::initDefault(1000);
	asm volatile ("sti");
	
	// asm volatile ("int $0x22");
	// asm volatile ("int $0x23");
	// asm volatile ("int $0x2f");
	// asm volatile ("int $0x2f");

	// volatile int a = 0;
	// volatile int b = 123;
	// volatile int c = b / a;

	while (true)
		asm volatile("hlt");
	return 0;
}