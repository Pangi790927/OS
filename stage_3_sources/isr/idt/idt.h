#ifndef IDT_H
#define IDT_H

#include "Types.h"

namespace idt
{
	struct __attribute__((__packed__)) Desc
	{
		uint16 offset1;		// 0:15
		uint16 selector;	// code segmet selector
		uint8 zero;			// 0
		uint8 type_attr;	// type and attributes
		uint16 offset2;		// 16:31
	
		void set_offset (uint32 offset);
		void set_selector (uint16 new_selector);
		void set_attr (uint8 attr);
		void set_zero();
	};

	// type_attr:
	//   7   6   5   4   3   2   1   0
	// +---+---+---+---+---+---+---+---+
	// | P |  DPL  | S |  GateType     |
	// +---+---+---+---+---+---+---+---+
	
	struct __attribute__((__packed__)) Reg
	{
		uint16 limit;
		uint16 baseLo;
		uint16 baseHi;
	};

	void loadIDT();
	void set_offset (int id, uint32 offset);
	void set_selector (int id, uint16 new_selector);
	void set_attr (int id, uint8 attr);
	void set_zero(int id);
}

#endif