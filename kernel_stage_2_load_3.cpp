/// entry point of stage 2
#include "stdio.h"

int kernel_2() asm("kernel_2");

int kernel_2()
{
	clear_screen();
	printf("Hello world!\n");

	while (true) {
		;				// you know it by now, never getting out 	
	}
	return 0;
}