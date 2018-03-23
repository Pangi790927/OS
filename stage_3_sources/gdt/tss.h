#ifndef TSS_H
#define TSS_H

#include "Types.h"

namespace gdt
{
	struct __attribute__((__packed__)) tss {
		uint16 prevTss;
		uint16 reserved_0;
		uint32 esp0;
		uint16 ss0;
		uint16 reserved_1;
		uint32 esp1;
		uint16 ss1;
		uint16 reserved_2;
		uint32 esp2;
		uint16 ss2;
		uint16 reserved_3;
		uint32 cr3;
		uint32 eip;
		uint32 eflags;
		uint32 eax;
		uint32 ecx;
		uint32 edx;
		uint32 ebx;
		uint32 esp;
		uint32 ebp;
		uint32 esi;
		uint32 edi;
		uint16 es;
		uint16 reserved_4;
		uint16 cs;
		uint16 reserved_5;
		uint16 ss;
		uint16 reserved_6;
		uint16 ds;
		uint16 reserved_7;
		uint16 fs;
		uint16 reserved_8;
		uint16 gs;
		uint16 reserved_9;
		uint16 ldtr;
		uint16 reserved_10;
		uint16 reserved_11;
		uint16 iopb;

		void init (uint32 esp0, uint16 ss);
	};

	void flush_tss (uint16 selector);
}

#endif