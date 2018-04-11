#include "paging.h"
#include "Types.h"
#include "c_asm_func.h"
#include "global_defines.h"

void paging::init_kernel_paging() {
	uint32 *kernel_page_dir = (uint32 *)K_PAGING;
	uint32 *kernel_page_tables = (uint32 *)K_PAGING + 1024;
	uint32 _4Mib = 1024 * 1024 * 4;
	uint32 kernel_4Mib_count = KERNEL_END / _4Mib + KERNEL_END % _4Mib != 0;

	for (uint32 i = 0; i < 1024; i++)
		kernel_page_dir[i] = 0;

	for (uint32 i = 0; i < 1024 * 1024; i++)
		kernel_page_tables[i] = 0;

	for (uint32 i = 0; i < kernel_4Mib_count; i++) {
		kernel_page_dir[V_KERNEL_START / _4Mib + i] = (i * _4Mib) |
				READ_WRITE_BIT | PRESENT_BIT | PAGE_SIZE_BIT;
	}

	uint32 &count_4MiB = *((uint32 *)PHYS_PAGES_START + 0);
	uint32 &count_4KiB = *((uint32 *)PHYS_PAGES_START + 1);
	uint32 *stack_4MiB = (uint32 *)PHYS_PAGES_START + 2;
	uint32 *stack_4KiB = (uint32 *)PHYS_PAGES_START + 2 + 1024;

	// for (int i = KERNEL_END / _4Mib; i < )

	// TO DO: Fill the two stacks

	__setCR3((uint32)kernel_page_dir);
	__setCR0(__getCR0() | CR0_PG_BIT | CR0_PE_BIT);
	__setCR4(__getCR4() | CR4_PSE_BIT);
}