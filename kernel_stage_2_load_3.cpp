/// entry point of stage 2
#include "stdio.h"
#include "pci.h"
#include "ata_driver.h"
#include "paging.h"
#include "../stage_3_sources/global_defines.h"
#include "c_asm_func.h"

int kernel_2() asm("kernel_2");

extern int check_A20_on() asm("check_A20_on");
extern void enable_A20() asm("enable_A20");

#define xstr(a) str(a)
#define str(a) #a

#define KER_SECTOR_COUNT (1 * 2024)					// * 512 is the byte count	
#define ASM_COMMAND "call " xstr(V_KERNEL_START)

int kernel_2()
{
	bool isLba28 = false;
	clear_screen();
	printf("Stage 2!\n");

	if (check_A20_on())
		enable_A20();

	if (!ata::sendIdentify(0, isLba28, false))
		printf("Identify Failed\n");

	// using disk 0 in both cases
	if (!isLba28) {
		printf("Mode might be unsuported (if CHS)\n");
		if (!ata::lba48Read((void *)KERNEL_START, KERNEL_ON_HDD / 512,
				KER_SECTOR_COUNT, 0))
			printf("Read Failed\n");
		else
			printf("Done Reading\n");
	}
	else {
		if (!ata::lba28Read((void *)KERNEL_START, KERNEL_ON_HDD / 512,
				KER_SECTOR_COUNT, 0))
			printf("Read Failed\n");
		else
			printf("Done Reading\n");
	}
	paging::init_kernel_paging();

	// if (__isCpuidSuported()) {
	// 	char vendorName[13];

	// 	__getCpuidVendor(vendorName);
	// 	vendorName[12] = 0;
	// 	printf("%s\n", vendorName);

	// 	uint32 features[2];
	// 	__getCpuidFeatures(features);

	// 	printf("edx: %b\n", features[0]);
	// 	printf("ecx: %b\n", features[1]);
	// }

	// printf("cr0: %x\n", __getCR0());
	// printf("cr3: %x\n", __getCR3());
	// printf("cr4: %x\n", __getCR4());
	// printf("-------------------\n");
	// printf("%b\n", paging::PAGE_SIZE_BIT);
	// printf("%b\n", paging::READ_WRITE_BIT);
	// printf("%b\n", paging::PRESENT_BIT);
	// for (int i = 0; i < 1024; i++) {
	// 	if (*((uint32 *)K_PAGING + i) != 0)
	// 		printf("%d: %x :: %x\n", i, i * 4 * 1024 * 1024 / 256,
	// 				*((uint32 *)K_PAGING + i) & ~0xfff);
	// }
	// for (int i = 0; i < 1024; i++) {
	// 	if (*((uint32 *)K_PAGING + 1024 + i) != 0)
	// 		printf("%d: %x :: %x\n", i, i * 4 * 1024,
	// 				*((uint32 *)K_PAGING + 1024 + i) & ~0xfff);
	// }
	// printf("Data: %s\n", (void *)V_KERNEL_IN_RAM);
	// while (  true);

	asm volatile (ASM_COMMAND);
	while (true) {
		;				// you know it by now, never getting out
	}

	return 0;
}