#include "simple_printf.h"

static char _digits[] = "0123456789abcdef";

static void print (void (* putchar)(char), const char *str) {
	for (int i = 0; str[i]; i++)
		putchar(str[i]);
}

static void _put_nbr_base_rec (void (* putchar)(char), int number, int base) {
	if (number) {
		_put_nbr_base_rec(putchar, number / base, base);
		putchar(_digits[number % base]);
	}
}

static void _put_nbr_base (void (* putchar)(char), 
		unsigned int number, int base, bool unsign = false)
{
	if ((number & 0x80000000) && !unsign)
		putchar('-');
	
	if (!number)
		putchar(_digits[0]);
	else {
		if ((number & 0x80000000) && !unsign) {
			_put_nbr_base_rec(putchar, (int)number / base * -1, base);
			putchar(_digits[((int)number * -1) % base]);
		}	
		else {
			_put_nbr_base_rec(putchar, number / base, base);
			putchar(_digits[number % base]);
		}
	}
}

static void putHex (void (* putchar)(char), int number) {
	_put_nbr_base(putchar, number, 16, true);
}

static void putDec (void (* putchar)(char), int number) {
	_put_nbr_base(putchar, number, 10);
}

static void putOct (void (* putchar)(char), int number) {
	_put_nbr_base(putchar, number, 8);
}

static void putBin (void (* putchar)(char), int number) {
	unsigned int nb = number;
	unsigned int mask = 0x8000'0000;

	int i = 0;
	while (mask) {
		if (mask & nb)
			putchar(_digits[1]);
		else
			putchar(_digits[0]);
		mask = (mask >> 1);
		if ((++i) % 8 == 0 && i != 32)
			putchar('\'');
	}
}

void putdec (void (* putchar)(char), int number) {
	putDec(putchar, number);
	// inhanced capabilities of vga to print numbers ... nah, joking
	// I'm to lazy to implement it now
}

void puthex (void (* putchar)(char), int number) {
	putHex(putchar, number);
	// inhanced capabilities of vga to print numbers ... nah, joking
	// I'm to lazy to implement it now
}

void putoct (void (* putchar)(char), int number) {
	putOct(putchar, number);
	// inhanced capabilities of vga to print numbers ... nah, joking
	// I'm to lazy to implement it now
}

void putbin (void (* putchar)(char), int number) {
	putBin(putchar, number);
	// inhanced capabilities of vga to print numbers ... nah, joking
	// I'm to lazy to implement it now
}

void putstr (void (* putchar)(char), char *str) {
	print(putchar, (const char *)str);
}

void printf (void (* putchar)(char), const char *str) {
	int i = 0;

	while (str[i]) {
		putchar(str[i]);
		i++;
	}
}
