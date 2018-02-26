#include "ata_driver.h"
#include "Types.h"
#include "c_asm_func.h"
#include "stdio.h"

void ata::waitBSY() {
	while (inb(primaryPort | status) & 0x80)
		;
}

bool ata::waitDSQ() {
	bool done = false;
	while (!done) {
		uint8 value = inb(primaryPort | status);

		if (value & 1)
			return false;

		if (value & 8)
			done = true;
	}
	return true;
}

// will read 512 * sectorCount from ATA and write them to address
bool ata::lba28Read (void *address, uint32 lba, uint32 sectorCount, uint8 device) {
	while (sectorCount != 0) {
		uint32 toRead = 1;
		if (sectorCount > 255)
			toRead = 255;
		else
			toRead = sectorCount;
		sectorCount -= toRead;

		if (!lba28PIORead(address, lba, toRead, device))
			return false;
		lba += toRead;
		address = (void *)((char *)address + toRead * 512);
	}
	return true;
}

bool ata::lba28PIORead (void *address, uint32 lba, uint8 sectorCount, uint8 device) {
	outb(primaryPort | device, deviceLBASend | (device << 4) | ((lba >> 24) & 0x0F));
	outb(primaryPort | error, 0x00);
	outb(primaryPort | sectorCount, sectorCount);
	outb(primaryPort | LBAlo, (unsigned char)lba);
	outb(primaryPort | LBAmi, (unsigned char)(lba >> 8));
	outb(primaryPort | LBAhi, (unsigned char)(lba >> 16));
	
	waitBSY();
	outb(primaryPort | command, readCommand);

	for (int i = 0; i < sectorCount; i++) {
		waitBSY();
		for (int i = 0; i < 3; i++)
			inb(prinaryCommand);
		if (!waitDSQ())
			return false;

		for (int j = 0; j < 256; j++) {
			*((uint16 *)address + j + i * 256) = inw(primaryPort | data);
		}
	}
	return true;
}

bool ata::lba48PIORead (void *address, uint64 lba, uint16 sectorCount, uint8 device) {

}

bool ata::sendIdentify (uint8 device, bool &lba28, bool printData) {
	// floating, no device here 
	if (inb(status | primaryPort) == 0xff)
		return false;

	outb(primaryPort | device, (device << 4) | deviceDefault);

	for (int i = 0; i < 3; i++)
		inb(prinaryCommand);

	// we must wait for the bussy to clear
	while (inb(primaryPort | status) & 0x80)
		;

	outb(primaryPort | sectorCount, 0);
	outb(primaryPort | LBAlo, 0);
	outb(primaryPort | LBAmi, 0);
	outb(primaryPort | LBAhi, 0);

	outb(primaryPort | command, identifyCommand);

	// drive does not exist
	if (inb(primaryPort | status) == 0)
		return false;

	waitBSY();

	if (inb(primaryPort | LBAmi) != 0 || inb(primaryPort | LBAhi) != 0)
		return false;

	if (!waitDSQ())
		return false;

	uint16 res[256] = {0};

	for (int i = 0; i < 256; ++i) {
		res[i] = inw(primaryPort | data);
	}

	if (printData) {		
		printf("identify result: \n");
		for (int i = 0; i < 16; ++i) {
			for (int j = 0; j < 16; ++j) {
				printf("%x ", res[i * 16 + j]);
			}
			printf("\n");
		}
		printf("0 - %b\n83 - %b\n88 - %b\n", res[0], res[83], res[88]);
		printf("60, 61 - %d\n", *(int *)(res + 60));
		printf("100..103 - %x %x %x %x\n", res[100], res[101], res[102], res[103]);

		for (int i = 0; i < 40; i++)
			printf("%c", ((char *)((uint16 *)res + 27))[i]);
		printf("\n");
	}

	lba28 = ((1 << 10) & res[83]) == 0;
	return true;
}