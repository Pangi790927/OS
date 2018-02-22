#ifndef PCI_H
#define PCI_H

#include "Types.h"

// this needs to be updated to also support Configuration Space Access Mechanism #2
// and Memory Mapped PCI Configuration Space Access
namespace pci
{
	// Legacy	
	const uint32 CONFIG_ADDRESS = 0xCF8;
	const uint32 CONFIG_DATA = 0xCFC;

	// Config address:
	// 31	|	30 - 24		|	15 - 11		|	10 - 8		|	7 - 2	|
	// 1	|	Reserved	|	Device nr.	|	Function nr	|	Reg nr	|
	// 64 32bit registers

	uint32 configAddress (uint8 bus, uint8 devNr, uint8 func, uint8 regNr);

	// byte can be 0, 1, 2, 3
	uint8 configReadByte (uint8 bus, uint8 devNr, uint8 func, uint8 regNr, uint8 byte);

	// word is the first or second word in the 32bit register (must be 1 or 0)
	uint16 configReadWord (uint8 bus, uint8 devNr, uint8 func, uint8 regNr, uint8 word);
	

	uint32 configRead (uint8 bus, uint8 devNr, uint8 func, uint8 regNr);
	
	// New PCI (WIP)
	const uint32 ENABLE_PORT = 0x0CF8;		// 8 bit port, enable disable 
	const uint32 FORWARDING_PORT = 0x0CFA;	// 8 bit port, bus number 
	const uint32 BASE_REGS = 0xC000;

	// Comune functions:
	bool checkDevice (uint8 bus, uint8 device, uint8 func);
	void printBusses();
}

#endif