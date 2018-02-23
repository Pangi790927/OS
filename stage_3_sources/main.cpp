#include "stdio.h"
#include "isr.h"
#include "error_isr.h"

int main()
{
	clear_screen();
	printf("Stage 3\n");

	asm volatile ("cli");
	set_error_ISR();
	idt::loadIDT();
	asm volatile ("sti");

	while (true)
		asm volatile("");
	return 0;
}