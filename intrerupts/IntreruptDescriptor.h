#ifndef INTRERUPT_DESCRIPTOR_H
#define INTRERUPT_DESCRIPTOR_H

#include "Types.h"

extern void idt_flush (unsigned int table) asm("idt_flush");		/// present in a asm file

extern void isr0 () asm("isr0");
extern void isr1 () asm("isr1");
extern void isr2 () asm("isr2");
extern void isr3 () asm("isr3");
extern void isr4 () asm("isr4");
extern void isr5 () asm("isr5");
extern void isr6 () asm("isr6");
extern void isr7 () asm("isr7");
extern void isr8 () asm("isr8");
extern void isr9 () asm("isr9");
extern void isr10() asm("isr10");
extern void isr11() asm("isr11");
extern void isr12() asm("isr12");
extern void isr13() asm("isr13");
extern void isr14() asm("isr14");
extern void isr15() asm("isr15");
extern void isr16() asm("isr16");
extern void isr17() asm("isr17");
extern void isr18() asm("isr18");
extern void isr19() asm("isr19");
extern void isr20() asm("isr20");
extern void isr21() asm("isr21");
extern void isr22() asm("isr22");
extern void isr23() asm("isr23");
extern void isr24() asm("isr24");
extern void isr25() asm("isr25");
extern void isr26() asm("isr26");
extern void isr27() asm("isr27");
extern void isr28() asm("isr28");
extern void isr29() asm("isr29");
extern void isr30() asm("isr30");
extern void isr31() asm("isr31");

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

		VGA::print("here I am: ");
		VGA::putDec(32);
		VGA::print("\n");
	
		setGate( 0, (u_int_32)isr0 , 0x08, 0x8E);
    	setGate( 1, (u_int_32)isr1 , 0x08, 0x8E);
    	setGate( 2, (u_int_32)isr2 , 0x08, 0x8E);
    	setGate( 3, (u_int_32)isr3 , 0x08, 0x8E);
    	setGate( 4, (u_int_32)isr4 , 0x08, 0x8E);
    	setGate( 5, (u_int_32)isr5 , 0x08, 0x8E);
    	setGate( 6, (u_int_32)isr6 , 0x08, 0x8E);
    	setGate( 7, (u_int_32)isr7 , 0x08, 0x8E);
    	setGate( 8, (u_int_32)isr8 , 0x08, 0x8E);
    	setGate( 9, (u_int_32)isr9 , 0x08, 0x8E);
    	setGate(10, (u_int_32)isr10, 0x08, 0x8E);
    	setGate(11, (u_int_32)isr11, 0x08, 0x8E);
    	setGate(12, (u_int_32)isr12, 0x08, 0x8E);
    	setGate(13, (u_int_32)isr13, 0x08, 0x8E);
    	setGate(14, (u_int_32)isr14, 0x08, 0x8E);
    	setGate(15, (u_int_32)isr15, 0x08, 0x8E);
    	setGate(16, (u_int_32)isr16, 0x08, 0x8E);
    	setGate(17, (u_int_32)isr17, 0x08, 0x8E);
    	setGate(18, (u_int_32)isr18, 0x08, 0x8E);
    	setGate(19, (u_int_32)isr19, 0x08, 0x8E);
    	setGate(20, (u_int_32)isr20, 0x08, 0x8E);
    	setGate(21, (u_int_32)isr21, 0x08, 0x8E);
    	setGate(22, (u_int_32)isr22, 0x08, 0x8E);
    	setGate(23, (u_int_32)isr23, 0x08, 0x8E);
    	setGate(24, (u_int_32)isr24, 0x08, 0x8E);
    	setGate(25, (u_int_32)isr25, 0x08, 0x8E);
    	setGate(26, (u_int_32)isr26, 0x08, 0x8E);
    	setGate(27, (u_int_32)isr27, 0x08, 0x8E);
    	setGate(28, (u_int_32)isr28, 0x08, 0x8E);
    	setGate(29, (u_int_32)isr29, 0x08, 0x8E);
    	setGate(30, (u_int_32)isr30, 0x08, 0x8E);
		setGate(31, (u_int_32)isr31, 0x08, 0x8E);
	}

	void sendTable() {
		descPtr.sendToCPU();
	}
};


#endif
