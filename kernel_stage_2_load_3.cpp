/// entry point of stage 2
#include "stdio.h"
#include "pci.h"
#include "ata_driver.h"

int kernel_2() asm("kernel_2");

int kernel_2()
{
	bool isLba28;
	clear_screen();
	printf("Hello world!\n");

	// pci::printBusses();
	ata::sendIdentify(0, isLba28, false);

	if (!isLba28) 
		printf("Mode might be unsuported\n");

	// 0xa000 is the location in ram
	// 0x8000 is the location on disk
	// 32 * 512 = 16k
	// using disk 0
	if (!ata::lba28Read((void *)0xa000, 0x8000 / 512, 32, 0))
		printf("Read Failed\n");
	for (int j = 0; j < 16; j++) {
		for (int i = 0; i < 16; i++) {
			printf("%x ", *((uint16 *)0xa000 + i + j * 16));
		}
		printf("\n");
	}

	printf("Data: %s\n", (void *)0xa000);

	asm volatile ("call 0xa000");

	while (true) {
		;				// you know it by now, never getting out
	}
	return 0;
}