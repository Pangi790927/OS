#include "idt.h"
#include "Types.h"

idt::Desc desc[256];
idt::Reg reg;

extern void callLIDT (uint32 idtRegAddr) asm ("callLIDT");

void idt::Desc::set_offset (uint32 offset) {
	offset1 = offset & 0xffff;
	offset2 = (offset >> 16) & 0xffff;
}

void idt::Desc::set_selector (uint16 new_selector) {
	selector = new_selector;
}

void idt::Desc::set_attr (uint8 attr) {
	type_attr = attr;
}

void idt::Desc::set_zero() {
	zero = 0;
}

void idt::set_offset (int id, uint32 offset) {
	desc[id].set_offset(offset);
}

void idt::set_selector (int id, uint16 new_selector)  {
	desc[id].set_selector(new_selector);
}

void idt::set_attr (int id, uint8 attr)  {
	desc[id].set_attr(attr);
}

void idt::set_zero(int id) {
	desc[id].set_zero();
}

void idt::loadIDT() {
	reg.limit = sizeof(desc) - 1;
	reg.baseLo = ((uint32)desc) & 0xffff;
	reg.baseHi = ((uint32)desc >> 16) & 0xffff;

	callLIDT((uint32)&reg);
}