#include "rmode.h"
#include "vesa_bios.h"

uint16_t vesa_info_get(vesa_info_t *addr) {
	uint16_t err = 0;
	register uint16_t ax asm ("ax") = 0x4F00;
	register uint16_t di asm ("di") = OFF(addr);
	uint16_t out = 0;
	asm volatile (
		"movl %1, %%es \n\t"
		"int $0x10 \n\t"
		"mov %%ax, %0" : "=rm" (out) : "rm" (SEG(addr)), "r" (ax), "r" (di));
	if (out != 0x004f)
		return out;
	return err;
}

uint16_t vesa_mode_get(vesa_mode_buff_t *addr, uint16_t mode) {
	uint16_t err = 0;
	register uint16_t ax asm ("ax") = 0x4F01;
	register uint16_t di asm ("di") = (uint16_t)OFF(addr);
	register uint16_t cx asm ("cx") = mode;
	uint16_t out = 0;
	asm volatile (
		"movl %1, %%es \n\t"
		"int $0x10 \n\t"
		"mov %%ax, %0" : "=rm" (out) : "rm" (SEG(addr)),
				"r" (ax), "r" (di), "r" (cx));
	if (out != 0x004f)
		return out;
	return err;
}

uint16_t vesa_mode_set(uint16_t mode, bool use_lfb) {
	uint16_t err = 0;
	uint16_t final_mode = (mode & 0x1ff) | (use_lfb ? 0x4000 : 0x0);
	register uint16_t ax asm ("ax") = 0x4F02;
	register uint16_t bx asm ("bx") = final_mode;
	uint16_t out = 0;
	asm volatile (
		"int $0x10 \n\t"
		"mov %%ax, %0" : "=rm" (out) : "r" (ax), "r" (bx));
	if (out != 0x004f)
		return out;
	return err;
}
