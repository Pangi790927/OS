#include "vga_stdio.h"

#include "intrerupts/intrerupts.h"

int main() {

	VGA::clear_screen();
	// VGA::print("string");
	// VGA::putnbr(123);
	
	char str[] = "Welcome to MyOS";
	VGA::print(str);
	VGA::print("\n");
	
	VGA::putHex(10);
	VGA::print("\n");

	VGA::putDec(10);
	VGA::print("\n");

	VGA::putOct(10);
	VGA::print("\n");

	VGA::putBin(10);
	VGA::print("\n");
}