#ifndef ATA_DRIVER_H
#define ATA_DRIVER_H

#include "Types.h"

// we will asume the ports:
// Primary 0x1F0, 0x3F6
// Secondary 0x170, 0x376
// next_1 0x1E8, 0x3E6
// next_2 0x168, 0x366
namespace ata
{
	const uint16 primaryPort = 0x1F0;
	const uint16 prinaryCommand = 0x3F6;

	const uint8 data = 0;
	const uint8 error = 1,			features = 1;
	const uint8 sectorCount = 2;
	const uint8 LBAlo = 3;
	const uint8 LBAmi = 4;
	const uint8 LBAhi = 5;
	const uint8 device = 6;
	const uint8 status = 7,			command = 7;

	const uint16 deviceDefault = 0xA0;
	const uint16 deviceLBASend = 0xE0;

	const uint8 identifyCommand = 0xEC;
	const uint8 readCommand = 0x20;

	void waitBSY();
	bool waitDSQ();

	// will read 512 * sectorCount from ATA and write them to address
	bool lba28Read (void *address, uint32 lba, uint32 sectorCount, uint8 device);

	bool lba28PIORead (void *address, uint32 lba, uint8 sectorCount, uint8 device);
	bool sendIdentify (uint8 device, bool &lba28, bool printData);
}

// if we decide that we need to discover the devices by hand
// BAR0: Base address of primary channel (I/O space), if it is 0x0 or 0x1, the port is 0x1F0.
// BAR1: Base address of primary channel control port (I/O space), if it is 0x0 or 0x1, the port is 0x3F6.
// BAR2: Base address of secondary channel (I/O space), if it is 0x0 or 0x1, the port is 0x170.
// BAR3: Base address of secondary channel control port, if it is 0x0 or 0x1, the port is 0x376.
// BAR4: Bus Master IDE; refers to the base of I/O range consisting of 16 ports. Each 8 ports 
// controls DMA on the primary and secondary channel respectively.
#endif