#include "Types.h"

void outb (uint16 port, uint8 data) {
    asm volatile ("outb %0, %1" : : "a"(data), "Nd"(port));
}

void outw (uint16 port, uint16 data) {
    asm volatile ("out %%ax, %%dx" : : "a" (data), "d" (port));
}

void outd (uint16 port, uint32 data) {
    asm volatile ( "out %0, %1" : : "a"(data), "Nd"(port) );
}

void inws (uint16 port, uint32 buffer, uint32 count) {
    asm volatile ("cld; rep; insl" : : "D" (buffer), "d" (port), "c" (count));
}

uint8 inb (uint16 port) {
    u_int_8 ret = 0;
    asm volatile ("inb %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

uint16 inw (uint16 port) {
    u_int_16 result = 0;
    asm volatile ("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return  result;
}

uint32 ind (uint16 port) {
    u_int_32 ret = 0;
    asm volatile ("inl %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

void io_wait() {
	// 0x80 is for POST and seems safe for a dumy check
	// does the register need to be zeroed? (question on OSDev)
	asm volatile ("outb %%al, $0x80" : : "a"(0));
}