/// entry point of stage 2
#include "stdio.h"
#include "pci.h"
#include "ata_driver.h"
#include "paging.h"
#include "../stage_3_sources/global_defines.h"
#include "c_asm_func.h"
#include "elf.h"
#include "serial.h"

int kernel_2() asm("kernel_2");

extern int check_A20_on() asm("check_A20_on");
extern void enable_A20() asm("enable_A20");

#define KERN_SIZE (4096 * 512)

using lba_read_t = decltype(&ata::lba48Read);
using stage3_entry_t = int (*)(void);

int kernel_2()
{
	serial::init();
	serial::sendstr((char *)"first serial comm from os\n");

	clear_screen();
	printf("Stage 2!\n");

	if (check_A20_on())
		enable_A20();

	paging::init_kernel_paging();
	/* from here onwards we are in a limbo of virtual space and
	indentity mapped pages */

	bool isLba28 = false;
	if (!ata::sendIdentify(0, isLba28, false))
		printf("Identify Failed\n");

	if (isLba28)
		printf("Mode might be unsuported (if CHS)\n");

	// int res = elf::load_elf_in_mem(KERNEL_ON_HDD,
	// 	[](void *addr, uint32 hdd_addr, uint32 size, void *ctx) {
	// 		if (!ata::read(addr, hdd_addr, size, 0, *(bool *)ctx))
	// 			return -1;

	// 		return 0;
	// 	},
	// 	&isLba28);

	// if (res) {
	// 	printf("Loading kernel in memory failed!\n");
	// 	while (true) {}
	// }

	if (!ata::read((uint8 *)V_KERNEL_START, KERNEL_ON_HDD, KERN_SIZE, 0, isLba28))
	{
		printf("Loading kernel in memory failed!\n");
		while (true) {}
	}

	stage3_entry_t stage3_entry = (stage3_entry_t)V_KERNEL_START;
	stage3_entry();

	/* you know it by now, never getting out */
	while (true)
		{}


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

	return 0;
}