#ifndef ATA_IMPL_H
#define ATA_IMPL_H

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
const static uint8_t SECTOR_COUNT0 =		2;
const static uint8_t LBA0 =					3;
const static uint8_t LBA1 =					4;
const static uint8_t LBA2 =					5;
const static uint8_t DEVSEL =				6;
const static uint8_t STATUS =				7, COMMAND = 7;

// Obs, next are not really port numbers offsets, subtract 8 to
// get port numbers offsets
const static uint8_t SECTOR_COUNT1 =		10;
const static uint8_t LBA3 =					11;
const static uint8_t LBA4 =					12;
const static uint8_t LBA5 =					13;

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
	uint8_t bsy			: 1;

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
	uint8_t head		: 4;	// bits 24 to 27 of the block number
	uint8_t drv			: 1;	// master or slave, 0 for master
	uint8_t one1		: 1;	// set to one
	uint8_t use_lba		: 1;	// use lba bit
	uint8_t one2		: 1;	// set to one

	drvsel_t() {
		head = 0;
		drv = 0;
		use_lba = 0;
		one1 = one2 = 1;
	}

	operator uint8_t() {
		return *(uint8_t *)this;
	}
} __attribute__((__packed__));

struct identify_t {
	uint16_t type;										// 0
	uint32_t cylinder_cnt;			// sure u32 ?		// 2
	uint32_t head_cnt;				// sure u32 ?		// 6
	uint16_t r_1;		 								// 10
	uint32_t sector_cnt;			// sure u32 ?		// 12
	uint32_t r_2;		 								// 16
	uint8_t serial[34];				// sure 34 ?		// 20
	char model[40];										// 54
	uint32_t r_3;										// 94
	uint16_t capab_r1				: 9;				// 98
	uint16_t capab_is_lba			: 1;
	uint16_t capab_r2				: 6;
	uint32_t r_4;										// 100
	uint16_t r_5;										// 102
	uint8_t field_valid[14];							// 106
	uint32_t max_lba;									// 120
	uint8_t r_6[40];									// 124
	uint32_t cmd_sets_r1 			: 26;				// 164
	uint32_t cmd_sets_ata48 		: 1;
	uint32_t cmd_sets_r2 			: 5;
	uint8_t r_7[32];									// 168
	uint32_t max_lba_ext;								// 200
} __attribute__((__packed__));

struct ata_device_t : public dev_if, public storage_if {
	uint16_t io_base = 0;
	uint16_t io_ctrl = 0;
	uint16_t io_bus_master = 0;
	bool is_master;

	virtual void *get_dev_if(int if_num);
	virtual int read(uint32_t lba, void *buff, int cnt);
	virtual int write(uint32_t lba, void *buff, int cnt);
	virtual uint32_t get_lba_cnt();

	int init(uint16_t io_base, uint16_t io_ctrl, uint16_t io_bus_master,
			bool is_master);

private:
	char buff[2048]{0};
	bool is_ata48;
	bool is_lba;
	uint32_t lba_cnt = 0;

	bool wait_drq();
	void wait_bsy();

	uint8_t read_base(uint8_t reg);
	void write_base(uint8_t reg, uint8_t val);

	uint8_t read_ctrl(uint8_t reg);
	void write_ctrl(uint8_t reg, uint8_t val);

	void devsel(int dev);
	void wait();

	int identify();
	int transfer_data(uint32_t lba, char *buff, uint8_t cnt, bool dir_write);
	int poll(int advanced_check);
};

// bellow functions should be moved in a cpp file but for now they can stay
// here because we don't include this file in more than one cpp file

int ata_device_t::init(uint16_t io_base, uint16_t io_ctrl,
		uint16_t io_bus_master, bool is_master)
{
	DBG("io_base: %x, io_ctrl: %x, io_bus_master: %x, is_master: %d",
			io_base, io_ctrl, io_bus_master, is_master);
	this->io_base = io_base;
	this->io_ctrl = io_ctrl;
	this->io_bus_master = io_bus_master;
	this->is_master = is_master;
	if (identify() < 0)
		return -1;
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
	uint32_t curr_lba = lba;
	uint8_t to_read = cnt > 255 ? 255 : cnt;
	while (cnt > 0) {
		int err = 0;
		if ((err = transfer_data(curr_lba, (char *)buff, to_read, 0)))
			return err;
		buff = (char *)buff + 512 * to_read;
		curr_lba += to_read;
		cnt -= to_read;
		to_read = cnt >= 255 ? 255 : cnt;
	}
	return 0;
}

int ata_device_t::write(uint32_t lba, void *buff, int cnt) {
	uint32_t curr_lba = lba;
	uint8_t to_write = cnt > 255 ? 255 : cnt;
	while (cnt > 0) {
		int err = 0;
		if ((err = transfer_data(curr_lba, (char *)buff, to_write, 1)))
			return err;
		buff = (char *)buff + 512 * to_write;
		curr_lba += to_write;
		cnt -= to_write;
		to_write = cnt >= 255 ? 255 : cnt;
	}
	return 0;
}

uint32_t ata_device_t::get_lba_cnt() {
	return lba_cnt;
}

void ata_device_t::wait_bsy() {
	while (status_t{read_ctrl(STATUS)}.bsy)
		asm volatile ("nop");
}

bool ata_device_t::wait_drq() {
	while (true) {
		uint8_t val = read_base(STATUS);
		if (status_t{val}.err)
			return false;
		if (status_t{val}.drq)
			return true;
	}
}

// obs: we disable interupts on read but don't re-enable them
uint8_t ata_device_t::read_base(uint8_t reg) {
	uint8_t port = reg;
	if (reg >= 8) {
		port -= 8;
		write_ctrl(io_ctrl + CONTROL, CONTROL_HOB | CONTROL_nIEN);
	}
	uint8_t ret = inb(io_base + port);
	if (reg >= 8)
		write_ctrl(io_ctrl + CONTROL, CONTROL_nIEN);
	return ret;
}

void ata_device_t::write_base(uint8_t reg, uint8_t val) {
	uint8_t port = reg;
	if (reg >= 8) {
		port -= 8;
		write_ctrl(io_ctrl + CONTROL, CONTROL_HOB | CONTROL_nIEN);
	}
	outb(io_base + port, val);
	if (reg >= 8)
		write_ctrl(io_ctrl + CONTROL, CONTROL_nIEN);
}

uint8_t ata_device_t::read_ctrl(uint8_t reg) {
	return inb(io_ctrl + reg);
}

void ata_device_t::write_ctrl(uint8_t reg, uint8_t val) {
	outb(io_ctrl + reg, val);
}

void ata_device_t::devsel(int dev) {
	drvsel_t sel;
	sel.drv = dev;
	DBG("Will select device");
	write_base(DEVSEL, (uint8_t)sel);
	DBG("selected device");
}

void ata_device_t::wait() {
	read_ctrl(ALTERNATE);
	read_ctrl(ALTERNATE);
	read_ctrl(ALTERNATE);
	read_ctrl(ALTERNATE);
}

int ata_device_t::identify() {
	DBGSCOPE();
	devsel(is_master ? ATA_MASTER : ATA_SLAVE);
	wait();

	write_base(COMMAND, IDENTIFY_COMMAND);
	wait();

	if (read_base(STATUS) == 0) {
		// no device here
		return -1;
	}

	status_t status(0);
	while (true) {
		status = (status_t)read_base(STATUS);
		if (status.err) {
			// if err, device is not ATA
			break;
		}
		if (!status.bsy && status.drq) {
			// all ok
			break;
		}
	}

	if (status.err) {
		// can be atapi but we really don't care right now
		return -1;
	}
 
 	for (int i = 0; i < 128; i++)
 		((int *)buff)[i] = inl(io_base + DATA);

 	auto ident = (identify_t *)buff;
 	for (uint i = 0; i < sizeof(ident->model); i += 2) {
 		char aux = ident->model[i];
 		ident->model[i] = ident->model[i + 1];
 		ident->model[i + 1] = aux;
 	}
 	ident->model[sizeof(ident->model) - 1] = 0;
 	is_lba = ident->capab_is_lba;
 	if (is_lba) {
		if (ident->cmd_sets_ata48) {
			lba_cnt = ident->max_lba_ext;
			is_ata48 = true;
		}
		else {
			is_ata48 = false;
			lba_cnt = ident->max_lba;
		}
	}
	DBG("size ident: %d, off_max_lba %d, off_max_lba_ext %d",
			sizeof(identify_t), (char *)&ident->max_lba - (char *)ident,
			(char *)&ident->max_lba_ext - (char *)ident)
 	DBG("Found ATA dev, model: %s, lba_cnt: %x is_lba: %d, is_ata48: %d",
 		ident->model, lba_cnt, is_lba, is_ata48);
	return 0;
}

int ata_device_t::transfer_data(uint32_t lba, char *buff, uint8_t cnt,
		bool dir_write)
{
	uint8_t cmd = 0;
	drvsel_t drvsel;
	drvsel.drv = is_master ? ATA_MASTER : ATA_SLAVE;
	uint8_t sect;
	uint16_t cyl;
	uint8_t lba_io[6]{0};
	if (lba >= 0x10000000 && (!is_ata48 || !is_lba))
		return -1;
	if (!is_lba) {
		/* use chs */
		/* magic numbers I found on net, I don't care about chs, I wish I
		will never have to debug or use this part */
		sect = (lba % 63) + 1;
		cyl = (lba + 1  - sect) / (16 * 63);
		lba_io[0] = sect;
		lba_io[1] = (cyl >> 0) & 0xFF;
		lba_io[2] = (cyl >> 8) & 0xFF;

		cmd = dir_write ? CMD_WRITE_PIO : CMD_READ_PIO;
		drvsel.use_lba = false;
		drvsel.head = (lba + 1 - sect) % (16 * 63) / (63);
	}
	else {
		if (!is_ata48) {
			/* use ata28 */
			lba_io[0] = (lba & 0x00000FF) >> 0;
			lba_io[1] = (lba & 0x000FF00) >> 8;
			lba_io[2] = (lba & 0x0FF0000) >> 16;

			cmd = dir_write ? CMD_WRITE_PIO : CMD_READ_PIO;
			drvsel.use_lba = true;
			drvsel.head = (lba & 0xF000000) >> 24;
		}
		else {
			/* use ata48 */
			lba_io[0] = (lba & 0x000000FF) >> 0;
			lba_io[1] = (lba & 0x0000FF00) >> 8;
			lba_io[2] = (lba & 0x00FF0000) >> 16;
			lba_io[3] = (lba & 0xFF000000) >> 24;
			// we prob could add more but 2T is enaugh and I don't want
			// uint64_t here

			cmd = dir_write ? CMD_WRITE_PIO_EXT : CMD_READ_PIO_EXT;
			drvsel.use_lba = true;
			drvsel.head = 0;
		}
	}
	wait_bsy();
	write_base(DEVSEL, (uint8_t)drvsel);
	wait();

	if (is_lba && is_ata48) {
		write_base(SECTOR_COUNT1, 0);
		write_base(LBA3, lba_io[3]);
		write_base(LBA4, lba_io[4]);
		write_base(LBA5, lba_io[5]);
	}
	write_base(SECTOR_COUNT0, cnt);
	write_base(LBA0, lba_io[0]);
	write_base(LBA1, lba_io[1]);
	write_base(LBA2, lba_io[2]);

	write_base(COMMAND, cmd);
	wait();

	int err = 0;
	if (!dir_write) {
		/* read */
		for (int i = 0; i < cnt; i++) {
			if ((err = poll(1))) {
				DBG("err while reading: %d", err);
				return err;
			}
			int *base = (int *)(buff + i * 512);
			for (int j = 0; j < 128; j++)
				base[j] = inl(io_base + DATA);
		}
	}
	else {
		/* write */
		for (int i = 0; i < cnt; i++) {
			if ((err = poll(0))) {
				DBG("err while writing: %d", err);
				return err;
			}
			int *base = (int *)(buff + i * 512);
			for (int j = 0; j < 128; j++)
				outl(io_base + DATA, base[j]);
		}

		uint8_t flush_cmd = is_lba && is_ata48 ? CMD_CACHE_FLUSH_EXT :
				CMD_CACHE_FLUSH;
		write_base(COMMAND, flush_cmd);
		wait();
		if ((err = poll(0))) {
			DBG("err while writing: %d", err);
			return err;
		}
	}
	return 0;
}

int ata_device_t::poll(int advanced_check) {
	wait();
	if (!wait_drq())
		return -1;

	if (advanced_check) {
		status_t stat(read_base(STATUS));
		if (stat.err) {
			DBG("Error while polling");
			return -2;
		}
		if (stat.df) {
			DBG("Device fault while polling");
			return -3;
		}
		if (!stat.drq) {
			DBG("Drq should be set");
			return -4;
		}
	}
	return 0;
}

#endif