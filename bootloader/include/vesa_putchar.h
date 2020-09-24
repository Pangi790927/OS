#ifndef VESA_PUTCHAR_H
#define VESA_PUTCHAR_H

#include "vesa_bios.h"

void vesa_set_putchar_mode(const vesa_mode_t& mode);
uint16_t vesa_putchar(uint16_t c);

#endif