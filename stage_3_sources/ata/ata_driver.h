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
	const uint16 PRIMARY_PORT = 0x1F0;
	const uint16 PRIMARY_COMMAND = 0x3F6;

	const uint8 DATA = 0;
	const uint8 ERROR = 1,			FEATURES = 1;
	const uint8 SECTOR_COUNT = 2;
	const uint8 LBA_LO = 3;
	const uint8 LBA_MI = 4;
	const uint8 LBA_HI = 5;
	const uint8 DEVICE = 6;
	const uint8 STATUS = 7,			COMMAND = 7;

	const uint16 DEVICE_DEFAULT = 0xA0;
	const uint16 DEVICE_LBA_SEND = 0xE0;

	const uint8 IDENTIFY_COMMAND = 0xEC;
	const uint8 READ_COMMAND = 0x20;
	const uint8 READ_COMMAND_EXT = 0x24;

	const uint32 LBA28_SECTOR_PATCH = 255;
	const uint32 LBA48_SECTOR_PATCH = 65535;
	const uint32 SECTOR_SIZE = 512;

	void waitBSY();
	bool waitDSQ();

	// will read 512 * sectorCount from ATA and write them to address
	bool lba28Read (void *address, uint64 lba, uint32 sectorCount, uint8 device);
	bool lba48Read (void *address, uint64 lba, uint32 sectorCount, uint8 device);

	bool lba28PIORead (void *address, uint32 lba, uint8 sectorCount, uint8 device);
	bool lba48PIORead (void *address, uint64 lba, uint16 sectorCount, uint8 device);
	bool sendIdentify (uint8 device, bool &lba28, bool printData);

	int init();
	bool read (void *dst, uint64 hdd_addr, uint32 size, uint8 dev);
}

// if we decide that we need to discover the devices by hand
// BAR0: Base address of primary channel (I/O space), if it is 0x0 or 0x1, the port is 0x1F0.
// BAR1: Base address of primary channel control port (I/O space), if it is 0x0 or 0x1, the port is 0x3F6.
// BAR2: Base address of secondary channel (I/O space), if it is 0x0 or 0x1, the port is 0x170.
// BAR3: Base address of secondary channel control port, if it is 0x0 or 0x1, the port is 0x376.
// BAR4: Bus Master IDE; refers to the base of I/O range consisting of 16 ports. Each 8 ports 
// controls DMA on the primary and secondary channel respectively.
#endif