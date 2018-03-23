#include "tss.h"

void gdt::tss::init (uint32 esp0, uint16 ss) {
	this->esp0 = esp0;
	this->ss = ss;
	this->iopb = sizeof(tss);
}

extern void callLTR (uint32 gdtPtr) asm ("callLTR");

void gdt::flush_tss (uint16 selector) {
	callLTR(selector);
}