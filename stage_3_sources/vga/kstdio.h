#ifndef KSTDIO_H
#define KSTDIO_H

void kclear_screen();
void kputchar(char c);
void kputdec (int number);
void kputhex (int number);
void kputoct (int number);
void kputbin (int number);
void kputstr (char *str);
void kprintf (const char *str);

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
int _manage_escape (const char *str, Type *toManage) {
	switch (str[0]) {
		case 'c': kputchar( *((char *)toManage) ); return 1;
		case 's': kputstr( *((char **)toManage) ); return 1;

		case 'd': kputdec( *((typename IntType<Type>::type *)toManage) ); return 1;
		
		case 'X':
		case 'x': kputhex( *((typename IntType<Type>::type *)toManage) ); return 1;
		
		case 'O':
		case 'o': kputoct( *((typename IntType<Type>::type *)toManage) ); return 1;
		
		case 'B':
		case 'b': kputbin( *((typename IntType<Type>::type *)toManage) ); return 1;

		case 'p': kprintf("0x"); kputhex( *((int *)toManage) ); return 1;
	}
}

template <typename Type, typename... Args>
void kprintf(const char *str, Type arg, Args... args) {
	int i = 0;
	bool wasEscape = false; 
	
	while (str[i] && !wasEscape) {
		if (str[i] == '%') {
			i++; // jump over escaper
			if (str[i] == '%') {
				kputchar(str[i]);
			}
			else if (str[i]) {
				// this i will be parameter for next call
				i += _manage_escape(str + i, &arg);
				wasEscape = true;	
				
				kprintf(str + i, args...);
			}
		}
		else {
			kputchar(str[i]);
		}
		i++;
	}
}

template <typename Type>
void kprintf(const char *str, Type arg) {
	int i = 0;
	bool wasEscape = false;
	
	while (str[i] && !wasEscape) {
		if (str[i] == '%') {
			i++; // jump over escaper
			if (str[i] == '%') {
				kputchar(str[i]);
			}
			else if (str[i]) {
				i += _manage_escape(str + i, &arg);
				wasEscape = true;

				kprintf(str + i);
			}
		}
		else {
			kputchar(str[i]);
		}
		i++;
	}
}

#endif