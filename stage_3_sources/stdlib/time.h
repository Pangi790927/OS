#ifndef TIME_H
#define TIME_H

#include "irq_isr.h"

inline static void sleep (uint64 ms) {
	uint64 last_time = irq_isr::get_irq0_count();
	while (irq_isr::get_irq0_count() - last_time < ms)
		asm volatile (""); 
}

#endif