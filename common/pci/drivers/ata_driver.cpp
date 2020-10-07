#include "ata_driver.h"
#include "types.h"
#include "ioports.h"
#include "dbg.h"

// fill this struct in
// struct pci_dev_t {
// 	using init_fn = int (*)(pci_dev_t *dev, config_reg_t *pci_reg);
// 	using uninit_fn = void (*)(pci_dev_t *dev);
// 	using get_if_fn = void *(*)(pci_dev_t *dev, int if_num);
// 	using reg_cbk_fn = int *(*)(pci_dev_t *dev, cbk_t cbk, int cbk_type);

// 	// those are set by the user
// 	uint8_t class_id;
// 	uint8_t subclass;

// 	init_fn init;
// 	uninit_fn uninit;
// 	get_if_fn get_if;
// 	reg_cbk_fn reg_cbk;

// 	// can be set during init
// 	void *ctx = NULL;

// 	// those are set by pci, must be null first
// 	uint8_t pci_bus = 0;
// 	uint8_t pci_dev = 0;
// 	uint8_t pci_fn = 0;

// 	pci_dev_t *next = NULL;
// 	bool init_done = false;
// };


extern "C" void	*memset(void *s, int c, size_t n)
{
	size_t	i;

	i = 0;
	while (i < n)
	{
		*((char *)s + i) = c;
		i++;
	}
	return (s);
}


void ata::waitBSY() {
	while (inb(PRIMARY_PORT | STATUS) & 0x80)
		;
}

bool ata::waitDSQ() {
	bool done = false;
	while (!done) {
		uint8_t value = inb(PRIMARY_PORT | STATUS);

		if (value & 1)
			return false;

		if (value & 8)
			done = true;
	}
	return true;
}

// will read 512 * sectorCount from ATA and write them to address
bool ata::lba28Read (void *address, uint64_t lba, uint32_t sectorCount,
		uint8_t device)
{
	while (sectorCount != 0) {
		uint32_t toRead = 1;
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

bool ata::lba48Read (void *address, uint64_t lba, uint32_t sectorCount,
		uint8_t device)
{
	while (sectorCount != 0) {
		uint64_t toRead = 1;
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

bool ata::lba28PIORead (void *address, uint32_t lba, uint8_t sectorCount,
		uint8_t device)
{
	// DBG("read28: addr[%p] lba[%x] cnt[%d]", address, lba, sectorCount);
	outb(PRIMARY_PORT | DEVICE, DEVICE_LBA_SEND |
			(device << 4) | ((lba >> 24) & 0x0F));
	outb(PRIMARY_PORT | ERROR, 0x00);
	outb(PRIMARY_PORT | SECTOR_COUNT, sectorCount);
	outb(PRIMARY_PORT | LBA_LO, (uint8_t)lba);
	outb(PRIMARY_PORT | LBA_MI, (uint8_t)(lba >> 8));
	outb(PRIMARY_PORT | LBA_HI, (uint8_t)(lba >> 16));
	
	waitBSY();
	outb(PRIMARY_PORT | COMMAND, READ_COMMAND);

	for (int i = 0; i < sectorCount; i++) {
		waitBSY();
		// for (int i = 0; i < 3; i++)
		// 	inb(PRIMARY_COMMAND);
		if (!waitDSQ())
			return false;

		for (uint32_t j = 0; j < SECTOR_SIZE / 2; j++) {
			*((uint16_t *)address + j + i * (SECTOR_SIZE / 2)) 
					= inw(PRIMARY_PORT | DATA);
		}
	}
	return true;
}

bool ata::lba48PIORead (void *address, uint64_t lba, uint16_t sectorCount,
		uint8_t device)
{
	// DBG("read48: addr[%p] lba[%x] cnt[%d]", address, lba, sectorCount);
	outb(PRIMARY_PORT | DEVICE, DEVICE_LBA_SEND | (device << 4));
	outb(PRIMARY_PORT | ERROR, 0x00);
	outb(PRIMARY_PORT | SECTOR_COUNT, (sectorCount >> 8) & 0xff);	// hi byte
	outb(PRIMARY_PORT | LBA_LO, (uint8_t)(lba >> (8 * 3)));
	outb(PRIMARY_PORT | LBA_MI, (uint8_t)(lba >> (8 * 4)));
	outb(PRIMARY_PORT | LBA_HI, (uint8_t)(lba >> (8 * 5)));
	outb(PRIMARY_PORT | SECTOR_COUNT, sectorCount & 0xff);			// lo byte
	outb(PRIMARY_PORT | LBA_LO, (uint8_t)(lba));
	outb(PRIMARY_PORT | LBA_MI, (uint8_t)(lba >> (8 * 1)));
	outb(PRIMARY_PORT | LBA_HI, (uint8_t)(lba >> (8 * 2)));

	waitBSY();
	outb(PRIMARY_PORT | COMMAND, READ_COMMAND_EXT);

	for (int i = 0; i < sectorCount; i++) {
		waitBSY();
		// for (int i = 0; i < 3; i++)
		// 	inb(PRIMARY_COMMAND);
		if (!waitDSQ())
			return false;

		for (uint32_t j = 0; j < SECTOR_SIZE / 2; j++) {
			*((uint16_t *)address + j + i * SECTOR_SIZE / 2) 
					= inw(PRIMARY_PORT | DATA);
		}
	}
	return true;
}

bool ata::sendIdentify (uint8_t device, bool &lba28, bool printData,
		uint32_t &lba_cnt)
{
	// floating, no device here 
	if (inb(PRIMARY_PORT | STATUS) == 0xff) {
		DBG("floating, no device here, 0xff")
		return false;
	}

	outb(PRIMARY_PORT | DEVICE, (device << 4) | DEVICE_DEFAULT);

	// for (int i = 0; i < 3; i++)
	// 	inb(PRIMARY_COMMAND);

	// we must wait for the bussy to clear
	while (inb(PRIMARY_PORT | STATUS) & 0x80)
		;

	outb(PRIMARY_PORT | SECTOR_COUNT, 0);
	outb(PRIMARY_PORT | LBA_LO, 0);
	outb(PRIMARY_PORT | LBA_MI, 0);
	outb(PRIMARY_PORT | LBA_HI, 0);

	outb(PRIMARY_PORT | COMMAND, IDENTIFY_COMMAND);

	// drive does not exist
	int ret;
	if ((ret = inb(PRIMARY_PORT | STATUS)) == 0) {
		DBG("drive does not exist: %d", ret);
		return false;
	}

	waitBSY();

	if (inb(PRIMARY_PORT | LBA_MI) != 0 || inb(PRIMARY_PORT | LBA_HI) != 0) {
		DBG("LBA_MI or LBA_HI != 0")
		return false;
	}

	if (!waitDSQ()) {
		DBG("waitDSQ false")
		return false;
	}

	uint16_t res[256] = {0};

	for (int i = 0; i < 256; ++i) {
		res[i] = inw(PRIMARY_PORT | DATA);
	}

	if (printData) {		
		DBG("identify result:");
		DBG("\n0  - %b\n83 - %b\n88 - %b\n", res[0], res[83], res[88]);
		DBG("lba28 sec count: [60, 61]   - %d", *(uint32_t *)(res + 60));
		DBG("lba48 sec count: [100..103] - %d", *(uint64_t *)(res + 100));
	}

	lba28 = ((1 << 10) & res[83]) == 0;
	if (lba28)
		lba_cnt = *(uint32_t *)(res + 60);
	else
		lba_cnt = *(uint64_t *)(res + 100);

	return true;
}

bool ata::read (void *dst, uint64_t hdd_addr, uint32_t size, uint8_t dev,
		bool is_lba_32)
{
	using lba_read_t = decltype(&ata::lba48Read);
	lba_read_t lba_read = is_lba_32 ? &ata::lba28Read : &ata::lba48Read;

	if (size == 0)
		return true;

	uint8_t *dst_buff = (uint8_t *)dst; 
	uint64_t end_addr = hdd_addr + size - 1;
	uint64_t start_sector = hdd_addr / SECTOR_SIZE;
	uint64_t end_sector = end_addr / SECTOR_SIZE;

	// LOG("read from: hdd_s: %x, hdd_e: %x, dst: %x, ss: %d, es: %d",
	// 		hdd_addr, end_addr, dst, start_sector, end_sector);

	if (end_addr < hdd_addr)
		return false;

	uint32_t start_rel = hdd_addr % SECTOR_SIZE;
	uint32_t end_rel = end_addr % SECTOR_SIZE;

	if (start_sector == end_sector) {
		uint8_t sector[SECTOR_SIZE];
		
		if (!lba_read(sector, start_sector, 1, dev))
			return false;
		
		uint32_t start_rel = hdd_addr % SECTOR_SIZE;
		uint32_t end_rel = end_addr % SECTOR_SIZE;
		for (uint32_t i = start_rel; i <= end_rel; i++)
			dst_buff[i - start_rel] = sector[i];
		return true;
	}

	uint8_t sector_start_buff[SECTOR_SIZE] = {0};
	uint8_t sector_end_buff[SECTOR_SIZE] = {0};
	
	if (!lba_read(sector_start_buff, start_sector, 1, dev))
		return false;

	if (!lba_read(sector_end_buff, end_sector, 1, dev))
		return false;
	
	for (uint32_t i = start_rel; i < SECTOR_SIZE; i++)
		dst_buff[i - start_rel] = sector_start_buff[i];

	for (uint32_t i = 0; i <= end_rel; i++)
		dst_buff[size - end_rel - 1 + i] = sector_end_buff[i];

	uint32_t offset_vaddr = SECTOR_SIZE - start_rel;
	// LOG("offset_vaddr: %x", offset_vaddr);

	if (start_sector + 1 <= end_sector - 1) {
		if (!lba_read(dst_buff + offset_vaddr,
				start_sector + 1, end_sector - 1 - start_sector, dev))
		{
			return false;
		}
	}
	return true;
}