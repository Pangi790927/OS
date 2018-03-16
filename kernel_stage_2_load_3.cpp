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
#define HDD_LOCATION 0x10000				// must be multiple of 512 : ker3 at 0x10000
#define KER_SECTOR_COUNT (1 * 2024)				// * 512 is the byte count	
#define ASM_COMMAND "call " xstr(RAM_LOCATION)

int kernel_2()
{
	bool isLba28 = false;
	clear_screen();
	printf("Stage 2!\n");

	if (check_A20_on())
		enable_A20();

	// pci::printBusses();
	if (!ata::sendIdentify(0, isLba28, false))
		printf("Identify Failed\n");

	// using disk 0 in both cases
	if (!isLba28) {
		printf("Mode might be unsuported (if CHS)\n");
		if (!ata::lba48Read((void *)RAM_LOCATION, HDD_LOCATION / 512,
				KER_SECTOR_COUNT, 0))
			printf("Read Failed\n");
		else
			printf("Done Reading\n");
	}
	else {
		if (!ata::lba28Read((void *)RAM_LOCATION, HDD_LOCATION / 512,
				KER_SECTOR_COUNT, 0))
			printf("Read Failed\n");
		else
			printf("Done Reading\n");
	}

	// for (int j = 0; j < 16; j++) {
	// 	for (int i = 0; i < 16; i++) {
	// 		printf("%x ", *((uint16 *)RAM_LOCATION + i + j * 16));
	// 	}
	// 	printf("\n");
	// }

	// printf("Data: %s\n", (void *)RAM_LOCATION);

	asm volatile (ASM_COMMAND);

	while (true) {
		;				// you know it by now, never getting out
	}
	return 0;
}