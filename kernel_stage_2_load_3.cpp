/// entry point of stage 2
#include "stdio.h"
#include "pci.h"
#include "ata_driver.h"

int kernel_2() asm("kernel_2");

extern int check_A20_on() asm("check_A20_on");
extern void enable_A20() asm("enable_A20");

int kernel_2()
{
	if (check_A20_on())
		enable_A20();

	bool isLba28;
	clear_screen();
	printf("Hello world!\n");

	// pci::printBusses();
	ata::sendIdentify(0, isLba28, false);

	if (!isLba28) 
		printf("Mode might be unsuported\n");

	// 0x1000000 is the location in ram
	// 0x8000 is the location on disk
	// 64 * 2024 * 512 = 64M
	// using disk 0
	if (!ata::lba28Read((void *)0x1000000, 0x8000 / 512, 64 * 2048, 0))
		printf("Read Failed\n");
	
	for (int j = 0; j < 16; j++) {
		for (int i = 0; i < 16; i++) {
			printf("%x ", *((uint16 *)0x1000000 + i + j * 16));
		}
		printf("\n");
	}

	printf("Data: %s\n", (void *)0x1000000);

	asm volatile ("call 0x1000000");

	while (true) {
		;				// you know it by now, never getting out
	}
	return 0;
}