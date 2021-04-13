#include "ata_driver.h"
#include "types.h"
#include "ioports.h"
#include "dev_if_helper.h"
#include "dbg.h"
#include "ata_device.h"

// INTERFACE PART ==============================================================

static alloc_fn_t _alloc_fn;
static free_fn_t _free_fn;

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
		auto r = (pci::config_reg_t *)reg;
		if (r->hdr.hdr_type != 0) {
			DBG("Only hdr type 0 is implemented");
			return -1;
		}
		int bar0 = (r->a.bar0 == 0x0 || r->a.bar0 == 0x1) ? 0x1F0 : r->a.bar0;
		int bar1 = (r->a.bar1 == 0x0 || r->a.bar1 == 0x1) ? 0x3F6 : r->a.bar1;
		int bar2 = (r->a.bar2 == 0x0 || r->a.bar2 == 0x1) ? 0x170 : r->a.bar2;
		int bar3 = (r->a.bar3 == 0x0 || r->a.bar3 == 0x1) ? 0x376 : r->a.bar3;
		if (add_device(bar0, bar1, r->a.bar4, bus, dev, fn, 0)) {
			DBG("Failed to init primary ide, master");
		}
		if (add_device(bar0, bar1, r->a.bar4, bus, dev, fn, 1)) {
			DBG("Failed to init primary ide, slave");
		}
		if (add_device(bar2, bar3, r->a.bar4 + 8, bus, dev, fn, 2)) {
			DBG("Failed to init secondary ide, master");
		}
		if (add_device(bar2, bar3, r->a.bar4 + 8, bus, dev, fn, 3)) {
			DBG("Failed to init secondary ide, slave");
		}
		return 0;
	}

	int add_device(uint16_t io_base, uint16_t io_ctrl, uint16_t io_bus_master,
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
		return 0;
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
