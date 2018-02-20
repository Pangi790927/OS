#ifndef TIMER_H
#define TIMER_H

#include "irq.h"
#include "Types.h"

const int TIMER_IRQ = 0;
const int IRQ0 = TIMER_IRQ;

const int PIT_FREQUENCY = 1193180;

const int PIT_COMMAND_ADDR = 0x43;
const int PIT_ADDRESS_BASE = 0x40;
const int PIT_REPEATING_MODE = 0x36;

void timer_callback (registers_irq& registers);

void init_timer (u_int_32 frequency);

long long get_timer ();
void sleep (int millisecs);

#endif