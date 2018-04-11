#ifndef C_ASM_FUNC_H
#define C_ASM_FUNC_H

#include "Types.h"

uint8			inb (uint16 port);
uint16			inw (uint16 port);
uint32			ind (uint16 port);
void			inws (uint16 port, uint32 buff, uint32 count);

void			outb (uint16 port, uint8 data);
void			outw (uint16 port, uint16 data);
void			outd (uint16 port, uint32 data);

void			io_wait ();

extern uint32	__getIOPL() asm("__getIOPL");
extern void		__setIOPL(uint32 iopl) asm("__setIOPL");
extern void		__getStack(uint32 *vec, uint32 count) asm("__getStack");

extern uint32	__getRegEAX() asm("__getRegEAX");
extern uint32	__getRegEBX() asm("__getRegEBX");
extern uint32	__getRegECX() asm("__getRegECX");
extern uint32	__getRegEDX() asm("__getRegEDX");
extern uint32	__getRegEDI() asm("__getRegEDI");
extern uint32	__getRegESI() asm("__getRegESI");
extern uint32	__getRegEBP() asm("__getRegEBP");
extern uint32	__getRegESP() asm("__getRegESP");
extern uint32	__getRegEIP() asm("__getRegEIP");

extern uint32	__getCR4() asm("__setCR4");
extern uint32	__setCR4(uint32 arg) asm("__setCR4");
extern uint32	__getCR3() asm("__setCR3");
extern uint32	__setCR3(uint32 arg) asm("__setCR3");
extern uint32	__getCR0() asm("__getCR0");
extern uint32	__setCR0(uint32 arg) asm("__setCR0");

#endif