#include "timer.h"
#include "irq.h"
#include "stdio.h"
#include "c_asm_func.h"

long long volatile timer = 0;

long long get_timer () {
	return timer;
}

void sleep (int millisecs) {
	long long start = get_timer();
	while (get_timer() - start < millisecs)
		asm volatile("");
}

void timer_callback (registers_irq& registers) {
	timer++;
	// printf("timer: %d, err: %d\n", timer, 0);
}

void init_timer (u_int_32 frequency) {
	printf("INIT Timer ... \n");;
	register_callback(TIMER_IRQ, &timer_callback);

	u_int_32 divisor = PIT_FREQUENCY / frequency;

	port_byte_out(PIT_COMMAND_ADDR, PIT_REPEATING_MODE);
	
	port_byte_out(PIT_ADDRESS_BASE, divisor);
	port_byte_out(PIT_ADDRESS_BASE, divisor >> 8);

	timer = 0;
}