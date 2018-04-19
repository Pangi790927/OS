#include "paging.h"
#include "Types.h"
#include "c_asm_func.h"
#include "../stage_3_sources/global_defines.h"
#include "boot_data.h"
#include "stdio.h"

void paging::init_kernel_paging() {
	uint32 *kernel_page_dir = (uint32 *)K_PAGING;
	uint32 *kernel_page_tables = (uint32 *)K_PAGING + 1024;
	uint32 _4Mib = 1024 * 1024 * 4;
	uint32 _4Kib = 1024 * 4;
	uint32 kernel_4Mib_count = KERNEL_END / _4Mib + (KERNEL_END % _4Mib != 0);
	// uint32 kernel_4Kib_count = KERNEL_END / _4Kib + (KERNEL_END % _4Kib != 0);

	for (uint32 i = 0; i < 1024; i++)
		kernel_page_dir[i] = 0;

	for (uint32 i = 0; i < 1024 * 1024; i++)
		kernel_page_tables[i] = 0;

	kernel_page_dir[0] = READ_WRITE_BIT | PRESENT_BIT | PAGE_SIZE_BIT | USER_BIT
			| (0 * _4Mib);
	kernel_page_dir[1] = READ_WRITE_BIT | PRESENT_BIT | PAGE_SIZE_BIT | USER_BIT 
			| (1 * _4Mib);
	for (uint32 i = 2; i < kernel_4Mib_count; i++)
		kernel_page_dir[V_KERNEL_BASE / _4Mib + i] = (i * _4Mib) |
				READ_WRITE_BIT | PRESENT_BIT | PAGE_SIZE_BIT | USER_BIT;

	uint32 &count_4MiB = *((uint32 *)PHYS_PAGES_START + 0);
	uint32 &count_4KiB = *((uint32 *)PHYS_PAGES_START + 1);
	uint32 *stack_4MiB = (uint32 *)PHYS_PAGES_START + 2;
	uint32 *stack_4KiB = (uint32 *)PHYS_PAGES_START + 2 + 1024;

	uint32 ram_4Mib_count = boot::get_ram_size() / 1024 / 1024 / 4;
	uint32 ram_4Kib_count = boot::get_ram_size() / 1024 / 1024 / 4;

	uint32 _4Mib_space_in_4Kib = kernel_4Mib_count * 1024 +
			(ram_4Mib_count - kernel_4Mib_count) / 2 * 1024;

	for (uint32 i = kernel_4Mib_count; i < (ram_4Mib_count - kernel_4Mib_count) / 2; i++)
		stack_4MiB[count_4MiB++] = i * _4Mib;

	for (uint32 i = _4Mib_space_in_4Kib; i < ram_4Kib_count; i++)
		stack_4KiB[count_4KiB++] = i * _4Kib;

	__setCR3((uint32)kernel_page_dir);
	__setCR4(__getCR4() | CR4_PSE_BIT);
	__setCR0(__getCR0() | CR0_PG_BIT | CR0_PE_BIT);
}
