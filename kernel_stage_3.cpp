#include "kstdio.h"
#include "c_asm_func.h"

int kernel_3() asm("kernel_3");
int main();

int kernel_3()
{
	main();

	while (true)
		asm volatile ("hlt");
	return 0;
}