#include "vga_stdio.h"
#include "isr.h"

void isr_handler (registers_isr regs) {
	VGA::print(" interr no: ");
	VGA::putHex(regs.int_no);
	
	VGA::print(" err code: ");
	VGA::putHex(regs.err_code);

	VGA::print(" data seg: ");
	VGA::putHex(regs.ds);

	VGA::print("\n");
}

void int13 (registers_isr regs) {
	/// well no isq13 is happening now ...
	
	// VGA::print(" ::int13:: E: ");
	// VGA::putDec(regs.err_code & 0b1);

	// VGA::print(" Tbl: ");
	// VGA::putDec((regs.err_code & 0b110) >> 1);

	// VGA::print(" Index: ");
	// VGA::putDec((regs.err_code & 0b1111111111111000) >> 3);

	// VGA::print("\n");
}
