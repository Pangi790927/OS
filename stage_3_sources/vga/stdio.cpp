#include "vga_stdio.h"
#include "stdio.h"

void clear_screen() {
	VGA::clear_screen();
}

void putchar(char c) {
	VGA::putchar(c);
}

void putdec (int number) {
	VGA::putDec(number);	// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void puthex (int number) {
	VGA::putHex(number);	// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void putoct (int number) {
	VGA::putOct(number);	// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void putbin (int number) {
	VGA::putBin(number);	// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void putstr (char *str) {
	VGA::print((const char *)str);
}

void printf (const char *str) {
	int i = 0;

	while (str[i]) {
		putchar(str[i]);
		i++;
	}
}
