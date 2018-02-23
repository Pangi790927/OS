#include "stdio.h"

int kernel_3() asm("kernel_3");
int main();

int kernel_3()
{
	main();
	return 0;
}