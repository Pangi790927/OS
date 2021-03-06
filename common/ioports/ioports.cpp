#include "ioports.h"

void outb (uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" : : "a"(data), "Nd"(port));
}

void outw (uint16_t port, uint16_t data) {
    asm volatile ("out %%ax, %%dx" : : "a" (data), "d" (port));
}

void outl (uint16_t port, uint32_t data) {
    asm volatile ( "out %0, %1" : : "a"(data), "Nd"(port) );
}

uint8_t inb (uint16_t port) {
    uint8_t ret = 0;
    asm volatile ("inb %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

uint16_t inw (uint16_t port) {
    uint16_t ret = 0;
    asm volatile ("in %%dx, %%ax" : "=a" (ret) : "d" (port));
    return  ret;
}

uint32_t inl (uint16_t port) {
    uint32_t ret = 0;
    asm volatile ("inl %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

void io_wait() {
	// 0x80 is for POST and seems safe for a dumy check
	// does the register need to be zeroed? (question on OSDev)
	asm volatile ("outb %%al, $0x80" : : "a"(0));
}