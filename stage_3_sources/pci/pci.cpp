#include "Types.h"
#include "c_asm_func.h"
#include "pci.h"
#include "kstdio.h"

uint32 pci::configAddress (uint8 bus, uint8 devNr, uint8 func, uint8 regNr) {
	return (uint32)((bus << 16) | (devNr << 11) | (func << 8) | ((regNr << 2) & 0xfc) 
			| ((uint32)0x80000000));
}

uint8 pci::configReadByte (uint8 bus, uint8 devNr, uint8 func, uint8 regNr, uint8 byte) {
	outd(CONFIG_ADDRESS, configAddress(bus, devNr, func, regNr));
	return (uint8)((ind(CONFIG_DATA) >> (byte << 3)) & 0xff);
}

uint16 pci::configReadWord (uint8 bus, uint8 devNr, uint8 func, uint8 regNr, uint8 word) {
	outd(CONFIG_ADDRESS, configAddress(bus, devNr, func, regNr));
	return (uint16)((ind(CONFIG_DATA) >> (word << 4)) & 0xffff);
}

uint32 pci::configRead (uint8 bus, uint8 devNr, uint8 func, uint8 regNr) {
	outd(CONFIG_ADDRESS, configAddress(bus, devNr, func, regNr));
	return (uint32)ind(CONFIG_DATA);
}

bool pci::checkDevice (uint8 bus, uint8 device, uint8 func) {
	if (pci::configReadWord(bus, device, func, 0, 0) == 0xffff)
		return false;
	return true;
}

void pci::printBusses() {
	for (int func = 0; func < 3; func++) {
		for (int bus = 0; bus < 256; bus++) {
			for (int device = 0; device < 32; device++) {
				if (checkDevice(bus, device, func)) {
					// uint16 hi = pci::configReadWord(bus, device, func, 2, 1);
					// uint16 lo = pci::configReadWord(bus, device, func, 2, 0);

					kprintf("Class code %x, Subclass %x, Prog IF %x, Rev ID %x, bus: %x, dev %x\n",
						pci::configReadByte(bus, device, func, 2, 3),
						pci::configReadByte(bus, device, func, 2, 2),
						pci::configReadByte(bus, device, func, 2, 1),
						pci::configReadByte(bus, device, func, 2, 0),
						bus,
						device
					);
					kprintf("Vendor id: %x, Device id: %x, Header Type: %x, BAR0: %x\n", 
						pci::configReadWord(bus, device, func, 0, 0),
						pci::configReadWord(bus, device, func, 0, 1), 
						pci::configReadByte(bus, device, func, 3, 3),
						pci::configRead(bus, device, func, 4)
					);
				}
			}
		}
	}
	kprintf("done printing busses ... \n");
}