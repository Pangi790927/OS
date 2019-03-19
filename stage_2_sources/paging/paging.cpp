#include "paging.h"
#include "Types.h"
#include "c_asm_func.h"
#include "../stage_3_sources/global_defines.h"
#include "boot_data.h"
#include "stdio.h"

void paging::init_kernel_paging() {
	uint32 *kernel_page_dir = (uint32 *)K_PAGING;
	uint32 *kernel_page_tables = (uint32 *)K_PAGING + 1024;
	const uint32 _4Mib = 1024 * 1024 * 4;
	const uint32 _4Kib = 1024 * 4;
	uint32 kernel_4Mib_count = KERNEL_END / _4Mib + (KERNEL_END % _4Mib != 0);
	uint32 kernel_4Kib_count = kernel_4Mib_count * _4Mib / _4Kib;

	for (uint32 i = 0; i < 1024; i++)
		kernel_page_dir[i] = 0;

	for (uint32 i = 0; i < 1024 * 1024; i++)
		kernel_page_tables[i] = 0;

	/* Those set first 8Mib into the paging directoy */
	kernel_page_dir[0] = READ_WRITE_BIT | PRESENT_BIT | PAGE_SIZE_BIT | USER_BIT
			| (0 * _4Mib);
	kernel_page_dir[1] = READ_WRITE_BIT | PRESENT_BIT | PAGE_SIZE_BIT | USER_BIT 
			| (1 * _4Mib);

	/* Here we set the kernel pages acordignly */
	for (uint32 i = 2; i < kernel_4Mib_count; i++)
		kernel_page_dir[V_KERNEL_BASE / _4Mib + i] = (i * _4Mib) |
				READ_WRITE_BIT | PRESENT_BIT | PAGE_SIZE_BIT | USER_BIT;

	/* Bellow we set the free pages in two stacks, one for 4Mb and one
		for 4Kb ones */
	PhysPages *phys_pages = (PhysPages *)PHYS_PAGES_START;
	phys_pages->init();

	uint32 ram_4Kib_count = boot::get_ram_size() / 1024 / 4;

	/* Here we are adding the free pages after the kernel */
	for (uint32 i = kernel_4Kib_count; i < ram_4Kib_count; i++)
		phys_pages->add_page(i * _4Kib);

	__setCR3((uint32)kernel_page_dir);
	__setCR4(__getCR4() | CR4_PSE_BIT);
	__setCR0(__getCR0() | CR0_PG_BIT | CR0_PE_BIT);
}

/* only those need to be implemented by the second stage */
void PhysPages::init() {
	kb_count = 0;

	for (uint32 i = 0; i < kb_page_count / uint32_bit_count; i++)
		kb_bitmap[i] = 0;
}

void PhysPages::add_page (uint32 address) {
	const uint32 _4Kib = 1024 * 4;

	kb_stack[kb_count++] = address;
	uint32 index = (address / _4Kib);
	kb_bitmap[index / uint32_bit_count] |= 1 << (index % uint32_bit_count);
}