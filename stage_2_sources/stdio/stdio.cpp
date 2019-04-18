#include "stdio.h"
#include "serial.h"

static char _digits[] = "0123456789abcdef";

void putchar(char c) {
	serial::sendchr(c);
}

static void print (const char *str) {
	for (int i = 0; str[i]; i++)
		putchar(str[i]);
}

static void _put_nbr_base_rec (int number, int base) {
	if (number) {
		_put_nbr_base_rec(number / base, base);
		putchar(_digits[number % base]);
	}
}

static void _put_nbr_base (unsigned int number, int base,
		bool unsign = false)
{
	if ((number & 0x80000000) && !unsign)
		putchar('-');
	
	if (!number)
		putchar(_digits[0]);
	else {
		if ((number & 0x80000000) && !unsign) {
			_put_nbr_base_rec((int)number / base * -1, base);
			putchar(_digits[((int)number * -1) % base]);
		}	
		else {
			_put_nbr_base_rec(number / base, base);
			putchar(_digits[number % base]);
		}
	}
}

static void putHex (int number) {
	_put_nbr_base(number, 16, true);
}

static void putDec (int number) {
	_put_nbr_base(number, 10);
}

static void putOct (int number) {
	_put_nbr_base(number, 8);
}

static void putBin (int number) {
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

void putdec (int number) {
	putDec(number);			// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void puthex (int number) {
	putHex(number);			// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void putoct (int number) {
	putOct(number);	// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void putbin (int number) {
	putBin(number);			// inhanced capabilities of vga to print numbers ... nah, joking
							// I'm to lazy to implement it now
}

void putstr (char *str) {
	print((const char *)str);
}

void printf (const char *str) {
	int i = 0;

	while (str[i]) {
		putchar(str[i]);
		i++;
	}
}
