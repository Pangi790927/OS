#include "tss.h"

void gdt::tss::init (uint32 esp0, uint16 ss) {
	for (int i = 0; i < sizeof(tss); i++)
		((uint8 *)this)[i] = 0;
	this->esp0 = esp0;
	this->ss0 = ss;
	this->iopb = sizeof(tss);
}

extern void callLTR (uint32 gdtPtr) asm ("callLTR");

void gdt::flush_tss (uint16 selector) {
	callLTR(selector);
}