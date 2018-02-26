#ifndef C_ASM_FUNC_H
#define C_ASM_FUNC_H

#include "Types.h"

uint8		inb (uint16 port);
uint16		inw (uint16 port);
uint32		ind (uint16 port);
void		inws (uint16 port, uint32 buff, uint32 count);

void		outb (uint16 port, uint8 data);
void		outw (uint16 port, uint16 data);
void		outd (uint16 port, uint32 data);

void		io_wait ();

#endif