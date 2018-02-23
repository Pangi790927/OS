/// entry point of stage 2
#include "stdio.h"
#include "pci.h"
#include "ata_driver.h"

int kernel_2() asm("kernel_2");

extern int check_A20_on() asm("check_A20_on");
extern void enable_A20() asm("enable_A20");

#define xstr(a) str(a)
#define str(a) #a

#define RAM_LOCATION 0x1000000
#define HDD_LOCATION 0x8000					// must be multiple of 512
#define SECTOR_COUNT (1 * 2024)				// * 512 is the byte count				
#define ASM_COMMAND "call " xstr(RAM_LOCATION)

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

	// using disk 0
	if (!ata::lba28Read((void *)RAM_LOCATION, HDD_LOCATION / 512, SECTOR_COUNT, 0))
		printf("Read Failed\n");
	
	for (int j = 0; j < 16; j++) {
		for (int i = 0; i < 16; i++) {
			printf("%x ", *((uint16 *)RAM_LOCATION + i + j * 16));
		}
		printf("\n");
	}

	printf("Data: %s\n", (void *)RAM_LOCATION);

	asm volatile (ASM_COMMAND);

	while (true) {
		;				// you know it by now, never getting out
	}
	return 0;
}