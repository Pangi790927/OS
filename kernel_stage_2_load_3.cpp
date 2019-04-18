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

int self_check_test_ata (bool is_lba_28);

int kernel_2()
{
	serial::init();

	printf("###################################################"
			"#############################\n");
	printf("Stage 2!\n");

	if (check_A20_on())
		enable_A20();

	paging::init_kernel_paging();
	/* from here onwards we are in a limbo of virtual space and
	indentity mapped pages */

	bool isLba28 = false;
	if (!ata::sendIdentify(0, isLba28, false))
		LOG("Identify Failed");

	if (isLba28)
		LOG("Mode might be unsuported (if CHS)");

#ifdef DBG_DRIVERS
	if (self_check_test_ata(isLba28)) {
		LOG("ATA test failed");
		while (true) {} // panic
	}
#endif // DBG_DRIVERS

	int res = elf::load_elf_in_mem(KERNEL_ON_HDD,
		[](void *addr, uint32 hdd_addr, uint32 size, void *ctx) {
			if (!ata::read(addr, hdd_addr, size, 0, *(bool *)ctx))
				return -1;

			return 0;
		},
		&isLba28);

	if (res) {
		LOG("Loading kernel in memory failed!");
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

int self_check_test_ata (bool is_lba_28) {
	uint8 data[512 * 5];
	auto clear_data = [&]() {
		for (uint32 i = 0; i < sizeof(data); i++)
			data[i] = 0;
	};

	clear_data();
	for (uint32 voff = 0; voff < 512; voff++) {
		LOG("Testing at voff: %d", voff);
		for (uint32 start = 0; start < 1024; start += 64) {
			LOG("Start: %d", start);
			for (uint32 end = start; end < 1024; end += 64) {
				uint32 size = end - start;
				if (!ata::read(data + voff, 512 + start, size, 0, is_lba_28))
				{
					LOG("Failed to read from hdd");
					return -1;
				}

				uint32 non_zero = 0;
				for (uint32 i = 0; i < sizeof(data); i++) {
					if (data[i])
						non_zero++;
				}
				if (non_zero != size) {
					LOG("Tested with: voff %d, start %d, end %d",
						voff, start, end);
					LOG("Expected %d non_zero, got %d", size, non_zero);
					LOG("String in data: %s", (char *)(data + voff));
					return -1;
				}
				clear_data();
			}
		}
	}
	return 0;
}