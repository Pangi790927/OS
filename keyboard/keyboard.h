#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "irq.h"

const int KEYBOARD_IRQ = 1;
const int IRQ1 = KEYBOARD_IRQ;

const int KEYBOARD_ADDR = 0x60;
const int KEYBOARD_SCAN_COMM = 0xF0;
const int KEYBOARD_SET_SCAN_2 = 2;
const int KEYBOARD_ACK = 0xFA;
const int KEYBOARD_RESEND = 0xFE;

void keyboard_callback (registers_irq& regs);
void init_keyboard ();

#endif