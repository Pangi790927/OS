#include "ata_driver.h"
#include "Types.h"
#include "c_asm_func.h"
#include "kstdio.h"

namespace ata
{
	bool is_lba_32 = false;
}

void ata::waitBSY() {
	while (inb(PRIMARY_PORT | STATUS) & 0x80)
		;
}

bool ata::waitDSQ() {
	bool done = false;
	while (!done) {
		uint8 value = inb(PRIMARY_PORT | STATUS);

		if (value & 1)
			return false;

		if (value & 8)
			done = true;
	}
	return true;
}

// will read 512 * sectorCount from ATA and write them to address
bool ata::lba28Read (void *address, uint64 lba, uint32 sectorCount, uint8 device) {
	while (sectorCount != 0) {
		uint32 toRead = 1;
		if (sectorCount > LBA28_SECTOR_PATCH)
			toRead = LBA28_SECTOR_PATCH;
		else
			toRead = sectorCount;
		sectorCount -= toRead;

		if (!lba28PIORead(address, lba, toRead, device))
			return false;
		lba += toRead;
		address = (void *)((char *)address + toRead * SECTOR_SIZE);
	}
	return true;
}

bool ata::lba48Read (void *address, uint64 lba, uint32 sectorCount, uint8 device) {
	while (sectorCount != 0) {
		uint64 toRead = 1;
		if (sectorCount > LBA48_SECTOR_PATCH)
			toRead = LBA48_SECTOR_PATCH;
		else
			toRead = sectorCount;
		sectorCount -= toRead;

		if (!lba48PIORead(address, lba, toRead, device))
			return false;
		lba += toRead;
		address = (void *)((char *)address + toRead * SECTOR_SIZE);
	}
	return true;
}

bool ata::lba28PIORead (void *address, uint32 lba, uint8 sectorCount, uint8 device) {
	outb(PRIMARY_PORT | DEVICE, DEVICE_LBA_SEND |
			(device << 4) | ((lba >> 24) & 0x0F));
	outb(PRIMARY_PORT | ERROR, 0x00);
	outb(PRIMARY_PORT | SECTOR_COUNT, sectorCount);
	outb(PRIMARY_PORT | LBA_LO, (uint8)lba);
	outb(PRIMARY_PORT | LBA_MI, (uint8)(lba >> 8));
	outb(PRIMARY_PORT | LBA_HI, (uint8)(lba >> 16));
	
	waitBSY();
	outb(PRIMARY_PORT | COMMAND, READ_COMMAND);

	for (int i = 0; i < sectorCount; i++) {
		waitBSY();
		for (int i = 0; i < 3; i++)
			inb(PRIMARY_COMMAND);
		if (!waitDSQ())
			return false;

		for (uint32 j = 0; j < SECTOR_SIZE / 2; j++) {
			*((uint16 *)address + j + i * (SECTOR_SIZE / 2)) 
					= inw(PRIMARY_PORT | DATA);
		}
	}
	return true;
}

bool ata::lba48PIORead (void *address, uint64 lba, uint16 sectorCount, uint8 device) {
	outb(PRIMARY_PORT | DEVICE, DEVICE_LBA_SEND | (device << 4));
	outb(PRIMARY_PORT | ERROR, 0x00);
	outb(PRIMARY_PORT | SECTOR_COUNT, (sectorCount >> 8) & 0xff);	// hi byte
	outb(PRIMARY_PORT | LBA_LO, (uint8)(lba >> (8 * 3)));
	outb(PRIMARY_PORT | LBA_MI, (uint8)(lba >> (8 * 4)));
	outb(PRIMARY_PORT | LBA_HI, (uint8)(lba >> (8 * 5)));
	outb(PRIMARY_PORT | SECTOR_COUNT, sectorCount & 0xff);			// lo byte
	outb(PRIMARY_PORT | LBA_LO, (uint8)(lba));
	outb(PRIMARY_PORT | LBA_MI, (uint8)(lba >> (8 * 1)));
	outb(PRIMARY_PORT | LBA_HI, (uint8)(lba >> (8 * 2)));

	waitBSY();
	outb(PRIMARY_PORT | COMMAND, READ_COMMAND_EXT);

	for (int i = 0; i < sectorCount; i++) {
		waitBSY();
		for (int i = 0; i < 3; i++)
			inb(PRIMARY_COMMAND);
		if (!waitDSQ())
			return false;

		for (uint32 j = 0; j < SECTOR_SIZE / 2; j++) {
			*((uint16 *)address + j + i * SECTOR_SIZE / 2) 
					= inw(PRIMARY_PORT | DATA);
		}
	}
	return true;
}

bool ata::sendIdentify (uint8 device, bool &lba28, bool printData) {
	// floating, no device here 
	if (inb(STATUS | PRIMARY_PORT) == 0xff)
		return false;

	outb(PRIMARY_PORT | DEVICE, (device << 4) | DEVICE_DEFAULT);

	for (int i = 0; i < 3; i++)
		inb(PRIMARY_COMMAND);

	// we must wait for the bussy to clear
	while (inb(PRIMARY_PORT | STATUS) & 0x80)
		;

	outb(PRIMARY_PORT | SECTOR_COUNT, 0);
	outb(PRIMARY_PORT | LBA_LO, 0);
	outb(PRIMARY_PORT | LBA_MI, 0);
	outb(PRIMARY_PORT | LBA_HI, 0);

	outb(PRIMARY_PORT | COMMAND, IDENTIFY_COMMAND);

	// drive does not exist
	if (inb(PRIMARY_PORT | STATUS) == 0)
		return false;

	waitBSY();

	if (inb(PRIMARY_PORT | LBA_MI) != 0 || inb(PRIMARY_PORT | LBA_HI) != 0)
		return false;

	if (!waitDSQ())
		return false;

	uint16 res[256] = {0};

	for (int i = 0; i < 256; ++i) {
		res[i] = inw(PRIMARY_PORT | DATA);
	}

	if (printData) {		
		kprintf("identify result: \n");
		// for (int i = 0; i < 16; ++i) {
		// 	for (int j = 0; j < 16; ++j) {
		// 		kprintf("%x ", res[i * 16 + j]);
		// 	}
		// 	kprintf("\n");
		// }
		kprintf("0 - %b\n83 - %b\n88 - %b\n", res[0], res[83], res[88]);
		kprintf("60, 61 - %d\n", *(int *)(res + 60));
		kprintf("100..103 - %x %x %x %x\n", res[100], res[101], res[102], res[103]);

		for (int i = 0; i < 40; i++)
			kprintf("%c", ((char *)((uint16 *)res + 27))[i]);
		kprintf("\n");
		// while (true) {}
	}

	lba28 = ((1 << 10) & res[83]) == 0;
	return true;
}

int ata::init() {
	if (!ata::sendIdentify(0, is_lba_32, false)) {
		kprintf("Identify Failed\n");
		return -1;
	}
	return 0;
}

bool ata::read (void *dst, uint64 hdd_addr, uint32 size, uint8 dev)
{
	using lba_read_t = decltype(&ata::lba48Read);
	lba_read_t lba_read = is_lba_32 ? &ata::lba28Read : &ata::lba48Read;

	uint64 end_addr = hdd_addr + size;
	uint64 start_sector = hdd_addr / SECTOR_SIZE;
	uint64 end_sector = end_addr / SECTOR_SIZE;

	if (end_addr == hdd_addr)
		return true;

	if (end_addr < hdd_addr)
		return false;

	if (start_sector == end_sector) {
		uint8 sector[SECTOR_SIZE];
		if (!lba_read(sector, start_sector, 1, dev))
			return false;
		for (uint32 i = hdd_addr % SECTOR_SIZE; i < end_addr % SECTOR_SIZE; i++)
			((char *)dst)[i - hdd_addr % SECTOR_SIZE] = sector[i];
		return true;
	}

	if (hdd_addr % SECTOR_SIZE != 0) {
		uint8 sector[SECTOR_SIZE];
		if (!lba_read(sector, start_sector, 1, dev))
			return false;
		for (uint32 i = hdd_addr % SECTOR_SIZE; i < SECTOR_SIZE; i++)
			((char *)dst)[i - hdd_addr % SECTOR_SIZE] = sector[i];
		start_sector++;
	}

	if (end_addr % SECTOR_SIZE != 0) {
		uint8 sector[SECTOR_SIZE];
		if (!lba_read(sector, end_sector + 1, 1, dev))
			return false;
		for (uint32 i = 0; i < end_addr % SECTOR_SIZE; i++)
			((char *)dst)[i + size - end_addr % SECTOR_SIZE] = sector[i];
		end_sector--;
	}

	uint32 offset_vaddr = hdd_addr % SECTOR_SIZE != 0 ? 
			SECTOR_SIZE - hdd_addr % SECTOR_SIZE
			: 0;

	if (end_sector - start_sector > 0)
		if (!lba_read((uint8 *)dst + offset_vaddr,
				start_sector, end_sector - start_sector, dev))
			return false;
	return true;
}