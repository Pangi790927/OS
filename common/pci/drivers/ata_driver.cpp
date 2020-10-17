#include "ata_driver.h"
#include "types.h"
#include "ioports.h"
#include "dev_if_helper.h"
#include "dbg.h"

// INTERFACE PART ==============================================================

static alloc_fn_t _alloc_fn;
static free_fn_t _free_fn;

struct ata_device_t : public dev_if, public storage_if {
	uint16_t io_base = 0;
	uint16_t io_ctrl = 0;
	uint16_t io_bus_master = 0;
	bool is_master;

	virtual void *get_dev_if(int if_num);
	virtual int read(uint32_t lba, void *buff, int cnt);
	virtual int write(uint32_t lba, void *buff, int cnt);

	int init(uint8_t io_base, uint8_t io_ctrl, uint8_t io_bus_master,
			bool is_master);

private:
	char buff[SECTOR_SIZE]{0};

	bool wait_drq();
	void wait_bsy();

	uint8_t read_base(uint8_t reg);
	void write_base(uint8_t reg, uint8_t val);

	uint8_t read_ctrl(uint8_t reg);
	void write_ctrl(uint8_t reg, uint8_t val);
};

struct ata_driver_t : public drv_if, public pcidrv_if {
	pci_class_match_t match1;
	pci_class_match_t match5;

	dev_mgr_if *_idev_mgr;
	cbk_t creat_cbk;

	int init(dev_mgr_if *idev_mgr) {
		_idev_mgr = idev_mgr;

		/* we use diffrent matches for the same ata driver, it just matches
		(pun intended) */
		match5.class_code = match1.class_code = 0x1;
		match1.subclass = 0x1;
		match5.subclass = 0x5;
		return 0;
	}

	virtual void *get_if(int if_num) {
		if (if_num == drv_if::n)
			return (drv_if *)this;
		if (if_num == pcidrv_if::n)
			return (pcidrv_if *)this;
		return NULL;
	}

	virtual int pci_init(void *reg, int bus, int dev, int fn) {
		auto _reg = (pci::config_reg_t *)reg;
		if (_reg->hdr.hdr_type != 0) {
			DBG("Only hdr type 0 is implemented");
			return -1;
		}
		int bar0 = (r->a.bar0 == 0x0 || r->a.bar0 == 0x1) ? 0x1F0 : r->a.bar0;
		int bar1 = (r->a.bar1 == 0x0 || r->a.bar1 == 0x1) ? 0x3F6 : r->a.bar1;
		int bar2 = (r->a.bar2 == 0x0 || r->a.bar2 == 0x1) ? 0x170 : r->a.bar2;
		int bar3 = (r->a.bar3 == 0x0 || r->a.bar3 == 0x1) ? 0x376 : r->a.bar3;
		if (add_device(bar0, bar1, r->a.bar4, bus, dev, fn, 0)) {
			DBG("Failed to init primary ide, master");
			return -1;
		}
		if (add_device(bar0, bar1, r->a.bar4, bus, dev, fn, 1)) {
			DBG("Failed to init primary ide, slave");
			return -1;
		}
		if (add_device(bar2, bar3, r->a.bar4 + 8, bus, dev, fn, 2)) {
			DBG("Failed to init secondary ide, master");
			return -1;
		}
		if (add_device(bar2, bar3, r->a.bar4 + 8, bus, dev, fn, 3)) {
			DBG("Failed to init secondary ide, slave");
			return -1;
		}
		return 0;
	}

	int add_device(uint8_t io_base, uint8_t io_ctrl, uint8_t io_bus_master,
			uint8_t bus, uint8_t dev, uint8_t fn, uint8_t id)
	{
		DBG("Will try to init ata device: %d %d %d", bus, dev, fn);
		auto new_device = alloc_obj<ata_device_t>(_alloc_fn);
		if (!new_device) {
			DBG("No more memory for new device");
			return -1;
		}
		if (new_device->init(io_base, io_ctrl, io_bus_master, !(id % 2)) < 0) {
			DBG("Failed to init new device");
			return -1;
		}
		auto new_match = alloc_obj<pci_addr_match_t>(_alloc_fn);
		if (!new_match) {
			DBG("Failed to create match for device");
			return -1;
		}
		new_match->bus = bus;
		new_match->dev = dev;
		new_match->fn = fn;
		new_match->id = id;
		creat_cbk.call<cbk_create_device_t>(
				(dev_if *)new_device->get_dev_if(dev_if::n), new_match);
		DBG("Init done for ata device: %d %d %d %d -> %p",
				bus, dev, fn, id, new_device->get_dev_if(dev_if::n));
	}

	virtual void register_cbk(cbk_t cbk, int cbk_num) {
		switch (cbk_num) {
			case CBK_CREATE_DEVICE: creat_cbk = cbk;
				break;
			default:
				DBG("unknown register cbk: %d", cbk_num);
				break;
		}
	}

};

static ata_driver_t *ata_driver = NULL;

int ata_reg_drivers(dev_mgr_if *idev_mgr, alloc_fn_t alloc, free_fn_t free) {
	if (!ata_driver) {
		_alloc_fn = alloc;
		_free_fn = free;
		ata_driver = alloc_obj<ata_driver_t>(_alloc_fn);
		if (!ata_driver) {
			DBG("Couldn't allocate ata driver memory");
			return -1;
		}
		if (ata_driver->init(idev_mgr) < 0) {
			DBG("Couldn't init ata driver");
			return -1;
		}
	}
	auto d_if = (drv_if *)ata_driver->get_if(drv_if::n);
	if (idev_mgr->reg_driver(d_if, &ata_driver->match1) < 0) {
		DBG("can't register ide driver");
		return -1;
	}
	if (idev_mgr->reg_driver(d_if, &ata_driver->match5) < 0) {
		DBG("can't register ata controler driver");
		return -1;
	}
	// move to ahci driver when is done
	// if (idev_mgr->reg_driver(d_if, &ata_driver->match6) < 0) {
	// 	DBG("can't register sata driver");
	// 	return -1;
	// }
	return 0;
}

// IMPLEMENTATION PART =========================================================

const static uint8_t CMD_READ_PIO =			0x20;
const static uint8_t CMD_READ_PIO_EXT =		0x24;
const static uint8_t CMD_READ_DMA =			0xC8;
const static uint8_t CMD_READ_DMA_EXT =		0x25;
const static uint8_t CMD_WRITE_PIO =		0x30;
const static uint8_t CMD_WRITE_PIO_EXT =	0x34;
const static uint8_t CMD_WRITE_DMA =		0xCA;
const static uint8_t CMD_WRITE_DMA_EXT =	0x35;
const static uint8_t CMD_CACHE_FLUSH =		0xE7;
const static uint8_t CMD_CACHE_FLUSH_EXT =	0xEA;
const static uint8_t CMD_PACKET =			0xA0;
const static uint8_t CMD_IDENTIFY_PACKET =	0xA1;
const static uint8_t CMD_IDENTIFY =			0xEC;

const static uint8_t IDENTIFY_COMMAND =		0xEC;
const static uint8_t READ_COMMAND =			0x20;
const static uint8_t READ_COMMAND_EXT =		0x24;

const static uint32_t LBA28_SECTOR_PATCH =	255;
const static uint32_t LBA48_SECTOR_PATCH =	65535;
const static uint32_t SECTOR_SIZE =			512;

// used on base port:
const static uint8_t DATA =					0;
const static uint8_t ERROR =				1, FEATURES = 1;
const static uint8_t SECTOR_COUNT0 =		2, SECTOR_COUNT1 = 2;
const static uint8_t LBA0 =					3, LBA3 = 3;
const static uint8_t LBA1 =					4, LBA4 = 4;
const static uint8_t LBA2 =					5, LBA5 = 5;
const static uint8_t DEVSEL =				6;
const static uint8_t STATUS =				7, COMMAND = 7;

// used on ctrl port:
const static uint8_t CONTROL =				2, ALTERNATE = 2;
const static uint8_t DRVADDR =				3;

// used as values in CONTROL reg:
const static uint8_t ATA_MASTER =			0x00;
const static uint8_t ATA_SLAVE =			0x01;

const static uint8_t CONTROL_nIEN =			0x02;	// disable irq's
const static uint8_t CONTROL_SRST =			0x04;	// sowftware reset
const static uint8_t CONTROL_HOB =			0x80;	// high order byte? no idea

struct status_t {
	uint8_t err			: 1;
	uint8_t idx			: 1;	// index
	uint8_t corr		: 1;	// corrected data
	uint8_t drq			: 1;	// data request ready
	uint8_t dsc			: 1;	// drive seek complete
	uint8_t df			: 1;	// drive write fault
	uint8_t drdy		: 1;	// drive ready
	uint8_t busy		: 1;

	status_t(uint8_t num) {
		*(uint8_t *)this = num;
	}
} __attribute__((__packed__));

struct error_t {
	uint8_t amnf		: 1;	// no address mark
	uint8_t tk0nf		: 1;	// track 0 not found
	uint8_t abrt		: 1;	// command aborted
	uint8_t mcr			: 1;	// media change request
	uint8_t idnf		: 1;	// id not found
	uint8_t mc			: 1;	// media changed
	uint8_t unc			: 1;	// uncorrectable data
	uint8_t bbk			: 1;	// bad block

	error_t(uint8_t num) {
		*(uint8_t *)this = num;
	}
} __attribute__((__packed__));

struct drvsel_t {
	uint8_t lba24		: 3;	// bits 24 to 27 of the block number
	uint8_t drv			: 1;	// master or slave, 0 for master
	uint8_t one1		: 1;	// set to one
	uint8_t use_lba		: 1;	// use lba bit
	uint8_t one2		: 1;	// set to one

	error_t() {
		lba24 = 0;
		drv = 0;
		lba = 1;
		one1 = one2 = 1;
	}

	uint8_t () {
		return *(uint8_t *)this;
	}
} __attribute__((__packed__));

static void *memset(void *s, int c, size_t n)
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

int ata_device_t::init(uint8_t io_base, uint8_t io_ctrl, uint8_t io_bus_master,
			bool is_master)
{
	this->io_base = io_base;
	this->io_ctrl = io_ctrl;
	this->io_bus_master = io_bus_master;
	this->is_master = is_master;
	return 0;
}

void *ata_device_t::get_dev_if(int if_num) {
	if (if_num == dev_if::n)
		return (dev_if *)this;
	if (if_num == storage_if::n)
		return (storage_if *)this;
	return NULL;	
}

int ata_device_t::read(uint32_t lba, void *buff, int cnt) {
	DBG("A read was requested: %x %x %d", lba, buff, cnt);
	return -1;
}

int ata_device_t::write(uint32_t lba, void *buff, int cnt) {
	DBG("A write was requested: %x %x %d", lba, buff, cnt);
	return -1;
}

void ata_device_t::wait_bsy() {
	while (status_t{read_ctrl(ALTERNATE)}.busy)
		asm volatile ("nop");
}

bool ata_device_t::wait_drq() {
	while (true) {
		uint8_t val = read_ctrl(ALTERNATE);
		if (status_t{val}.err)
			return false;
		if (status_t{val}.drq)
			return true;
	}
}

uint8_t ata_device_t::read_base(uint8_t reg) {
	return inb(io_base + reg);
}

void ata_device_t::write_base(uint8_t reg, uint8_t val) {
	outb(io_base + reg, val);
}

uint8_t ata_device_t::read_ctrl(uint8_t reg) {
	return inb(io_ctrl + reg);
}

void ata_device_t::write_ctrl(uint8_t reg, uint8_t val) {
	outb(io_ctrl + reg, val);
}

bool ata::waitDSQ() {
	bool done = false;
	while (!done) {
		uint8_t value = inb(io_base + STATUS);

		if (value & 1)
			return false;

		if (value & 8)
			done = true;
	}
	return true;
}

int ata_device_t::identify() {
	drvsel_t sel;
	sel.
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