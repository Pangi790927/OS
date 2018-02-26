#include "idt.h"
#include "isr.h"

uint8 isr::makeAttr (uint8 present, uint8 dpl, uint8 seg, uint8 gate) {
	return (present << 7) | (dpl << 5) | (seg << 4) | gate;
}

void isr::addISR (int id, void (*isr_func)(), uint16 selector, uint8 attr) {
	idt::set_offset(id, (uint32)isr_func);
	idt::set_selector(id, selector);
	idt::set_attr(id, attr);
	idt::set_zero(id);
}
