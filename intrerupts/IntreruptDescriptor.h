#ifndef INTRERUPT_DESCRIPTOR_H
#define INTRERUPT_DESCRIPTOR_H

#include "Types.h"

extern void idt_flush (unsigned int table);		/// present in a asm file

class IntreruptDescriptor {
public:
	u_int_8 data[8];							// should be aligned now

	u_int_16& _baseLow() 	{ return *((u_int_16*)(data + 0)); };
	u_int_16& _selector() 	{ return *((u_int_16*)(data + 2)); };
	u_int_8& _zero() 		{ return *((u_int_8* )(data + 4)); };
	u_int_8& _flags()	 	{ return *((u_int_8* )(data + 5)); };
	u_int_16& _baseHigh() 	{ return *((u_int_16*)(data + 6)); };

	IntreruptDescriptor() {
		_zero() = 0;

		setBase(0);
		setSelector(0);
		setFlags(0);
	}

	void setBase(u_int_32 baseAddr) {
		_baseLow() = baseAddr & 0xffff;
		_baseHigh() = ((baseAddr >> 16) & 0xffff);
	}

	void setSelector (u_int_16 selector) {
		_selector() = selector;
	}

	void setFlags (u_int_8 flags) {
		_flags() = flags;
	}
};

class IntreruptDescriptorPointer {
public:
	u_int_16 data[3];

	u_int_16& _limit()	{ return *((u_int_16*)(data + 0)); }
	u_int_32& _base()	{ return *((u_int_32*)(data + 1)); }

	void sendToCPU() {
		idt_flush((u_int_32)&data);
	}
};

class IntreruptDescriptorTable {
public:
	IntreruptDescriptorPointer descPtr;

	IntreruptDescriptor descriptors[256];	// we only need 256 descriptors

	void setGate (int number, u_int_32 func, u_int_16 sel, u_int_8 flags) {
		descriptors[number].setBase(func);
		descriptors[number].setSelector(sel);
		descriptors[number].setFlags(flags);
	}

	IntreruptDescriptorTable() {
		descPtr._limit() = sizeof(descriptors) - 1;
		descPtr._base() = (u_int_32)&descriptors;
	}

	void snedTable() {
		descPtr.sendToCPU();
	}
};


#endif
