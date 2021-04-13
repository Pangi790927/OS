
int kernel1() asm("kernel1");
int kernel1() {
	return 0;
}

/* 	1. Figure out how to load and run this kernel from the bootloader
	2. Figure out how to organize virtual addresses better
	3. Start kernel2
	4. Add kernel modules in stage2. Add some drivers.
	5. Do usermode processes
	6. Implement UI
*/