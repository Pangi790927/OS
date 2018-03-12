#include "vga_stdio.h"
#include "kstdio.h"

void kclear_screen() {
	VGA::clear_screen();
}

void kputchar(char c) {
	VGA::putchar(c);
}

void kputdec (int number) {
	VGA::putDec(number);	// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void kputhex (int number) {
	VGA::putHex(number);	// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void kputoct (int number) {
	VGA::putOct(number);	// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void kputbin (int number) {
	VGA::putBin(number);	// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void kputstr (char *str) {
	VGA::print((const char *)str);
}

void kprintf (const char *str) {
	int i = 0;

	while (str[i]) {
		kputchar(str[i]);
		i++;
	}
}
