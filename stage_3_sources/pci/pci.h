#ifndef PCI_H
#define PCI_H

#include "Types.h"
#include "ostream.h"
#include "kiostream.h"

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
	void configWrite (uint8 bus, uint8 devNr, uint8 func,
			uint8 regNr, uint32 data);
	
	// New PCI (WIP)
	const uint32 ENABLE_PORT = 0x0CF8;		// 8 bit port, enable disable 
	const uint32 FORWARDING_PORT = 0x0CFA;	// 8 bit port, bus number 
	const uint32 BASE_REGS = 0xC000;

	// Comune functions:
	bool checkDevice (uint8 bus, uint8 device, uint8 func);
	void printBusses();

	struct Device {
		uint32 valid = false;

		uint32 bus;
		uint32 device;
		uint32 func;

		uint16 vendorId;
		uint16 deviceId;
		uint16 status;
		uint16 command;
		uint8 revID;
		uint8 classCode;
		uint8 headerType;

		uint32 bar0;
		uint32 bar1;
		uint32 bar2;
		uint32 bar3;
		uint32 bar4;
		uint32 bar5;

		Device () {}
		Device (uint32 bus, uint32 device, uint32 func) 
		: bus(bus), device(device), func(func) {}

		uint8 readByte (uint8 reg, uint8 byte) {
			return pci::configReadByte(bus, device, func, reg, byte);
		}

		uint8 readWord (uint8 reg, uint8 word) {
			return pci::configReadWord(bus, device, func, reg, word);
		}

		uint8 readReg (uint8 reg) {
			return pci::configRead(bus, device, func, reg);
		}

		void writeReg (uint8 reg, uint32 data) {
			pci::configWrite(bus, device, func, reg, data);
		}

		friend std::ostream& operator << (std::ostream& stream, const Device& arg) {
			stream << std::hex <<
					"bus: " << arg.bus <<
					" dev: " << arg.device <<
					" func: " << arg.func <<
					" vendorId: " << arg.vendorId <<
					" deviceId: " << arg.deviceId << std::endl;
			stream << 
					"status: " << arg.status <<
					" command: " << arg.command <<
					" revID: " << arg.revID <<
					" classCode: " << arg.classCode <<
					" headerType: " << arg.headerType << std::endl;
			stream << "bars: " <<
					arg.bar0 << " " <<
					arg.bar1 << " " <<
					arg.bar2 << " " <<
					arg.bar3 << " " <<
					arg.bar4 << " " <<
					arg.bar5 << std::endl;

			return stream;
		}

		static Device readDevice (uint8 bus, uint8 device, uint8 func, bool readBar) {
			Device toRead(bus, device, func);

			if (checkDevice(bus, device, func)) {
				toRead.valid = true;

				toRead.vendorId = pci::configReadWord(bus, device, func, 0, 0);
				toRead.deviceId = pci::configReadWord(bus, device, func, 0, 1);
				toRead.command = pci::configReadWord(bus, device, func, 1, 0);
				toRead.status = pci::configReadWord(bus, device, func, 1, 1);
				toRead.revID = pci::configReadByte(bus, device, func, 2, 0);
				toRead.classCode = pci::configReadByte(bus, device, func, 2, 3);
				toRead.headerType = pci::configReadByte(bus, device, func, 3, 2);

				if (readBar) {
					toRead.bar0 = pci::configRead(bus, device, func, 4);
					toRead.bar1 = pci::configRead(bus, device, func, 5);
					toRead.bar2 = pci::configRead(bus, device, func, 6);
					toRead.bar3 = pci::configRead(bus, device, func, 7);
					toRead.bar4 = pci::configRead(bus, device, func, 8);
					toRead.bar5 = pci::configRead(bus, device, func, 9);
				}
				return toRead; 
			}
			else {
				return Device(0, 0, 0);
			}
		}

		// must take as argument a function that returns true or false
		// and gets as parameter a device
		template <typename FuncType>
		static Device getFirst (FuncType rule, bool readBar = true) {
			for (int func = 0; func < 8; func++) {
				for (int bus = 0; bus < 256; bus++) {
					for (int device = 0; device < 32; device++) {
						Device toCheck = readDevice(bus, device, func, readBar);
						
						// regardless of rule we first check if it exists
						if (toCheck.valid && rule(toCheck))
							return toCheck;
					}
				}
			}
			return pci::Device(0, 0, 0);
		}

		// must take as argument a function that returns true or false
		// and gets as parameter a device
		template <typename FuncType>
		static Device getNext (const Device& prev, FuncType rule, bool readBar = true) {
			bool first = true;
			for (int func = 0; func < 8; func++) {
				if (first)
					func = prev.func;
				for (int bus = 0; bus < 256; bus++) {
					if (first)
						bus = prev.bus;
					for (int device = 0; device < 32; device++) {
						if (first)
							device = prev.device;
						if (!first) {
							Device toCheck = readDevice(bus, device, func, readBar);
							// regardless of rule we first check if it exists
							if (toCheck.valid && rule(toCheck))
								return toCheck;
						}
						first = false;
					}
				}
			}
			return pci::Device(0, 0, 0);
		}

		static std::vector<Device> getAll() {
			auto checkDev = [](const Device& dev){
				(void)dev;
				return true;
			};
			std::vector<Device> all;
			Device current = getFirst(checkDev);

			while (current.valid) {
				all.push_back(current);
				current = getNext(current, checkDev);
			}
			return all;
		}
	};
}

#endif