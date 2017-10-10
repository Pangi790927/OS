#include "Types.h"

void port_byte_out(u_int_16 port, u_int_8 val)
{
    asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port) );
    /* There's an outb %al, $imm8  encoding, for compile-time constant port numbers that fit in 8b.  (N constraint).
     * Wider immediate constants would be truncated at assemble-time (e.g. "i" constraint).
     * The  outb  %al, %dx  encoding is the only option for all other cases.
     * %1 expands to %dx because  port  is a uint16_t.  %w1 could be used if we had the port number a wider C type */
}

u_int_32 port_dword_in (u_int_16 port) {
    u_int_32 ret = 0;
    asm volatile ("inl %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

void port_dword_out (u_int_16 port, u_int_32 data) {
    asm volatile ( "out %0, %1" : : "a"(data), "Nd"(port) );
}

u_int_8 port_byte_in(u_int_16 port)
{
    u_int_8 ret = 0;
    asm volatile ( "inb %1, %0"
                   : "=a"(ret)
                   : "Nd"(port) );
    return ret;
}

u_int_16 port_word_in(u_int_16 port) {
	u_int_16 result = 0;
	asm volatile ("in %%dx, %%ax" : "=a" (result) : "d" (port));
	return  result;
}

void port_word_out(u_int_16 port, u_int_16 data) {
	asm volatile ("out %%ax, %%dx" : :"a" (data), "d" (port));
}

void port_words_in (u_int_16 port, u_int_32 buffer, u_int_32 count) {
    asm volatile ("cld; rep; insl" :: "D" (buffer), "d" (port), "c" (count));
}

void io_wait(void)
{
    /* Port 0x80 is used for 'checkpoints' during POST. */
    /* The Linux kernel seems to think it is free for use :-/ */
    asm volatile ( "outb %%al, $0x80" : : "a"(0) );
    /* %%al instead of %0 makes no difference.  TODO: does the register need to be zeroed? */
}