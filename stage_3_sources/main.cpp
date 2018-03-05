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

	uint8 a[][7] = {
		{0x1, 0x2, 0x00},	// key code
		{0x1, 0x00},
		{0x2, 0x2, 0x00},
		{0x1, 0x00},
		{0x0}
	};	

	printf("sizeof(a) = %d\n", sizeof(a));

	int i = 0, j = 0;
	while (a[i][0] != 0) {
		j = 0;
		while (a[i][j] != 0) {
			printf("%d, ", a[i][j]);
			j++;
		}
		printf("\n");
		i++;
	}
 
	while (true)
		asm volatile("hlt");
	return 0;
}