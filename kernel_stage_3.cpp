#include "stdio.h"

int kernel_3() asm("kernel_3");


/// entry point of stage 3 
int kernel_3()
{
	clear_screen();
	printf("Stage 3\n");
	/* code */
	return 0;
}