#ifndef STDIO_H
#define STDIO_H

#define LOG(fmt, ...)\
	printf("[%s][line:%d][%s] " fmt "\n",\
			__FILE__, __LINE__, __func__, ##__VA_ARGS__)

void putchar(char c);
void putdec (int number);
void puthex (int number);
void putoct (int number);
void putbin (int number);
void putstr (char *str);
void printf (const char *str);

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
		case 'c': putchar( *((char *)toManage) ); return 1;
		case 's': putstr( *((char **)toManage) ); return 1;

		case 'd': putdec( *((typename IntType<Type>::type *)toManage) ); return 1;
		
		case 'X':
		case 'x': puthex( *((typename IntType<Type>::type *)toManage) ); return 1;
		
		case 'O':
		case 'o': putoct( *((typename IntType<Type>::type *)toManage) ); return 1;
		
		case 'B':
		case 'b': putbin( *((typename IntType<Type>::type *)toManage) ); return 1;

		case 'p': printf("0x"); puthex( *((int *)toManage) ); return 1;
	}
	return 0;
}

template <typename Type, typename... Args>
void printf(const char *str, Type arg, Args... args) {
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
				i += _manage_escape(str + i, &arg);
				wasEscape = true;	
				
				printf(str + i, args...);
			}
		}
		else {
			putchar(str[i]);
		}
		i++;
	}
}

template <typename Type>
void printf(const char *str, Type arg) {
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

				printf(str + i);
			}
		}
		else {
			putchar(str[i]);
		}
		i++;
	}
}

#endif