#include "timer.h"
#include "irq.h"
#include "stdio.h"
#include "c_asm_func.h"

int timer = 0;

int get_timer () {
	return timer;
}

void timer_callback (registers_irq& registers) {
	timer++;
	printf("timer: %d, err: %d\n", timer, 0);
}

void init_timer (u_int_32 frequency) {
	// printf("Registering callback %p %d\n", PIT_REPEATING_MODE, PIT_FREQUENCY);
	register_callback(TIMER_IRQ, &timer_callback);

	u_int_32 divisor = PIT_FREQUENCY / frequency;

	port_byte_out(PIT_COMMAND_ADDR, PIT_REPEATING_MODE);
	
	port_byte_out(PIT_ADDRESS_BASE, divisor);
	port_byte_out(PIT_ADDRESS_BASE, divisor >> 8);
}