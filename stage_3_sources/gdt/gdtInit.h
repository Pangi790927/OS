#ifndef GDT_INIT_H
#define GDT_INIT_H

#include "gdt.h"
#include "tss.h"

namespace gdt
{
	Descriptor getAllRAMSeg();
	Descriptor makeTSSSeg (gdt::tss *addr);

	Descriptor& entry (int entry);
	void init_gdt();
	// code and data are the same as the stage_1 ones
	// so we will not need to reset segment registers
	void load_gdt();
}

#endif