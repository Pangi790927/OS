#include "vga_stdio.h"
#include "isr.h"

void isr_handler (registers_isr regs) {
	VGA::print("recieved intrerupt: ");
	VGA::putHex(regs.int_no);
	VGA::print(" - ");
	VGA::putHex(regs.err_code);
	VGA::print("\n");
}