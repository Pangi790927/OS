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

static void putdec (void (* putchar)(char), int number) {
	putDec(putchar, number);
	// inhanced capabilities of vga to print numbers ... nah, joking
	// I'm to lazy to implement it now
}

static void puthex (void (* putchar)(char), int number) {
	putHex(putchar, number);
	// inhanced capabilities of vga to print numbers ... nah, joking
	// I'm to lazy to implement it now
}

static void putoct (void (* putchar)(char), int number) {
	putOct(putchar, number);
	// inhanced capabilities of vga to print numbers ... nah, joking
	// I'm to lazy to implement it now
}

static void putbin (void (* putchar)(char), int number) {
	putBin(putchar, number);
	// inhanced capabilities of vga to print numbers ... nah, joking
	// I'm to lazy to implement it now
}

static void putstr (void (* putchar)(char), const char *str) {
	print(putchar, (const char *)str);
}

static void printf_ (void (* putchar)(char), const char *str) {
	int i = 0;

	while (str[i]) {
		putchar(str[i]);
		i++;
	}
}
int _manage_escape (void (*putchar)(char), const char *str, const uint64_t& v) {
	switch (str[0]) {
		case 'c': putchar((char)v); return 1;
		case 's': putstr(putchar, (char *)v); return 1;

		case 'i':
		case 'd': putdec(putchar, (int)v); return 1;

		case 'X':
		case 'x': printf_(putchar, "0x"); puthex(putchar, (unsigned int)v);
			return 1;
		
		case 'O':
		case 'o': putoct(putchar, (unsigned int)v); return 1;
		
		case 'B':
		case 'b': putbin(putchar, (unsigned int)v); return 1;

		case 'p': printf_(putchar, "0x"); puthex(putchar, (unsigned int)v);
			return 1;
	}
	return 0;
}

template <typename Type, typename... Args>
void printf_(void (*putchar)(char), const char *str, Type arg, Args... args) {
	int i = 0;
	bool wasEscape = false; 
	
	putstr(putchar, "");
	while (str[i] && !wasEscape) {
		if (str[i] == '%') {
			i++; // jump over escaper
			if (str[i] == '%') {
				putchar(str[i]);
			}
			else if (str[i]) {
				// this i will be parameter for next call
				i += _manage_escape(putchar, str + i, arg);
				wasEscape = true;	
				
				printf_(putchar, str + i, args...);
			}
		}
		else {
			putchar(str[i]);
		}
		i++;
	}
	putstr(putchar, "");
}

template <typename Type>
void printf_(void (*putchar)(char), const char *str, Type arg) {
	int i = 0;
	bool wasEscape = false;
	
	putstr(putchar, "");
	while (str[i] && !wasEscape) {
		if (str[i] == '%') {
			i++; // jump over escaper
			if (str[i] == '%') {
				putchar(str[i]);
			}
			else if (str[i]) {
				i += _manage_escape(putchar, str + i, arg);
				wasEscape = true;

				printf_(putchar, str + i);
			}
		}
		else {
			putchar(str[i]);
		}
		i++;
	}

	// TO DO: fix strange bug, for some reason those random putstr's are needed 
	putstr(putchar, "");
}

int count_args(const char *str) {
	int cnt = 0;
	int i = 0;
	while (str[i]) {
		if (str[i] == '%') {
			if (str[i + 1] == '%')
				i++;
			else
				cnt++;
		}
		i++;
	}
	return cnt;
}

void printf(void (*putchar)(char), const char *str,
	PrintfArg a1,
	PrintfArg a2,
	PrintfArg a3,
	PrintfArg a4,
	PrintfArg a5,
	PrintfArg a6,
	PrintfArg a7,
	PrintfArg a8,
	PrintfArg a9,
	PrintfArg a10,
	PrintfArg a11
	// PrintfArg a12
	// PrintfArg a13,
	// PrintfArg a14,
	// PrintfArg a15,
	// PrintfArg a16
)
{
	putstr(putchar, "");
	switch (count_args(str)) {
		case 0 : printf_(putchar, str);
			break;
		case 1 : printf_(putchar, str, a1.v);
			break;
		case 2 : printf_(putchar, str, a1.v, a2.v);
			break;
		case 3 : printf_(putchar, str, a1.v, a2.v, a3.v);
			break;
		case 4 : printf_(putchar, str, a1.v, a2.v, a3.v, a4.v);
			break;
		case 5 : printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v);
			break;
		case 6 : printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
				a6.v);
			break;
		case 7 : printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
				a6.v, a7.v);
			break;
		case 8 : printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
				a6.v, a7.v, a8.v);
			break;
		case 9 : printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
				a6.v, a7.v, a8.v, a9.v);
			break;
		case 10: printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
				a6.v, a7.v, a8.v, a9.v, a10.v);
			break;
		case 11: printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
				a6.v, a7.v, a8.v, a9.v, a10.v, a11.v);
			break;
		// case 12: printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
		// 		a6.v, a7.v, a8.v, a9.v, a10.v, a11.v, a12.v);
		// 	break;
		// case 13: printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
		// 		a6.v, a7.v, a8.v, a9.v, a10.v, a11.v, a12.v, a13.v);
		// 	break;
		// case 14: printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
		// 		a6.v, a7.v, a8.v, a9.v, a10.v, a11.v, a12.v, a13.v, a14.v);
		// 	break;
		// case 15: printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
		// 		a6.v, a7.v, a8.v, a9.v, a10.v, a11.v, a12.v, a13.v, a14.v,
		// 		a15.v);
		// 	break;
		// case 16: printf_(putchar, str, a1.v, a2.v, a3.v, a4.v, a5.v,
		// 		a6.v, a7.v, a8.v, a9.v, a10.v, a11.v, a12.v, a13.v, a14.v,
		// 		a15.v, a16.v);
			break;
		default:
			putstr(putchar, "[err: too many arguments]");
			putstr(putchar, str);
			break;
	}
	putstr(putchar, "");
}