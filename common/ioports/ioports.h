#ifndef IOPORTS_H
#define IOPORTS_H

#include "types.h"

uint8_t			inb (uint16_t port);
uint16_t		inw (uint16_t port);
uint32_t		inl (uint16_t port);

void			outb (uint16_t port, uint8_t data);
void			outw (uint16_t port, uint16_t data);
void			outl (uint16_t port, uint32_t data);

void			io_wait();

#endif