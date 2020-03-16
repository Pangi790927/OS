#ifndef SIMPLE_PRINTF_H
#define SIMPLE_PRINTF_H

// TO DO: move this file and other usual simple stuff in a common area

void putdec (void (*putchar)(char), int number);
void puthex (void (*putchar)(char), int number);
void putoct (void (*putchar)(char), int number);
void putbin (void (*putchar)(char), int number);
void putstr (void (*putchar)(char), char *str);
void printf (void (*putchar)(char), const char *str);

template <typename Type>
class IntType {
public:
	typedef int type;
};

template <>
class IntType <int> {
public:
	typedef int type;
};

template <>
class IntType <unsigned int> {
public:
	typedef unsigned int type;
};

template <>
class IntType <short> {
public:
	typedef short type;
};

template <>
class IntType <unsigned short> {
public:
	typedef unsigned short type;
};

template <>
class IntType <char> {
public:
	typedef char type;
};

template <>
class IntType <unsigned char> {
public:
	typedef unsigned char type;
};

template <typename Type>
int _manage_escape (void (*putchar)(char), const char *str, Type *toManage) {
	switch (str[0]) {
		case 'c': putchar(*((char *)toManage)); return 1;
		case 's': putstr(putchar, *((char **)toManage)); return 1;

		case 'd': putdec(putchar, *((typename IntType<Type>::type *)toManage));
			return 1;
		
		case 'X':
		case 'x': puthex(putchar, *((typename IntType<Type>::type *)toManage));
			return 1;
		
		case 'O':
		case 'o': putoct(putchar, *((typename IntType<Type>::type *)toManage));
			return 1;
		
		case 'B':
		case 'b': putbin(putchar, *((typename IntType<Type>::type *)toManage));
			return 1;

		case 'p': printf(putchar, "0x"); puthex(putchar, *((int *)toManage));
			return 1;
	}
	return 0;
}

template <typename Type, typename... Args>
void printf(void (*putchar)(char), const char *str, Type arg, Args... args) {
	int i = 0;
	bool wasEscape = false; 
	
	while (str[i] && !wasEscape) {
		if (str[i] == '%') {
			i++; // jump over escaper
			if (str[i] == '%') {
				putchar(str[i]);
			}
			else if (str[i]) {
				// this i will be parameter for next call
				i += _manage_escape(putchar, str + i, &arg);
				wasEscape = true;	
				
				printf(putchar, str + i, args...);
			}
		}
		else {
			putchar(str[i]);
		}
		i++;
	}
}

template <typename Type>
void printf(void (*putchar)(char), const char *str, Type arg) {
	int i = 0;
	bool wasEscape = false;
	
	while (str[i] && !wasEscape) {
		if (str[i] == '%') {
			i++; // jump over escaper
			if (str[i] == '%') {
				putchar(str[i]);
			}
			else if (str[i]) {
				i += _manage_escape(str + i, &arg);
				wasEscape = true;

				printf(putchar, str + i);
			}
		}
		else {
			putchar(str[i]);
		}
		i++;
	}
}

#endif