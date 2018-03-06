#include "stdio.h"
#include "isr.h"
#include "error_isr.h"
#include "irq_isr.h"
#include "pit.h"
#include "memmanip.h"
#include "global_defines.h"

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

	memmanip::init((void *)HEAP_START);

	char *a = new char [1001];
 	
	float f = 32.132;

	for (int i = 0; i < 1000; i++)
		a[i] = '0' + i % 10;
	a[1000] = '\0';
	printf("%s\n", a);

	memmanip::printMemory();
	free(a);
	memmanip::printMemory();

	while (true)
		asm volatile("hlt");
	return 0;
}