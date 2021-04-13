#ifndef BOOT_READER_H
#define BOOT_READER_H

#include "types.h"
#include "dbg.h"
#include "pci.h"
#include "ata_driver.h"

// loads ext2 fs readonly to find the kernel data 
struct BootReader {
	// std::vector<uint8_t> intern_buff;
	// std::string filename;
	uint32_t lba_cnt = 0;
	bool is_lba_28 = false;
	storage_if *storage;

	BootReader() {}

	int init(dev_mgr_if *idev_mgr, mbr_post_t *mbr_post) {
		/* TO DO: search device manager for a device that has the boot sector */

		dev_if *dev = NULL;
		struct param_t {
			mbr_post_t *mbr_post;
			dev_if **devp;
		};
		param_t param {
			.mbr_post = mbr_post,
			.devp = &dev,
		};

		idev_mgr->iter_devices(cbk_t{
			.fn = (void *)+[](void *ctx, dev_if *dev) {
				if (!dev)
					return -1;
				DBG("potential device ! %x", dev);
				auto storage = (storage_if *)dev->get_dev_if(storage_if::n);
				if (!storage)
					return -1;
				DBG("potential storage !!");
				mbr_post_t aux_mbr;
				if (storage->read(0, (void *)&aux_mbr, 1) < 0)
					return -1;
				DBG("potential boot sector !!!");
				auto param = (param_t *)ctx;
				if (aux_mbr.init_opts.boot_uid !=
						param->mbr_post->init_opts.boot_uid)
				{
					return -1; 
				}
				DBG("found our boot sector !!!!");

				*param->devp = dev;
				(void)ctx;
				return -1;
			},
			.ctx = (void *)&param,
		});

		if (!dev) {
			DBG("Can't find device with boot sector");
			return -1;
		}

		storage = (storage_if *)dev->get_dev_if(storage_if::n);
		if (!storage) {
			DBG("Not a storage device??");
			return -1;
		}

		lba_cnt = storage->get_lba_cnt();

		return 0;
	}

	// void add_pci_hook(pci_dev_t *driver) {
	// 	driver->reg_cbk()
	// } 

	int read_sector(uint32_t lba, uint32_t cnt, char *buff) {
		if (lba >= lba_cnt || lba + cnt > lba_cnt) {
			DBG("Outside of bounds read: %x - %x, max: %x",
					lba, lba + cnt, lba_cnt);
			return -1;
		}
		int err;
		if ((err = storage->read(lba, buff, cnt)) != 0) {
			DBG("can't read: lba: %x, cnt %x, err: %x", lba, cnt, err);
			return -1;
		}
		return 0;
	}

	int write_sector(uint32_t lba, uint32_t cnt, char *buff) {
		(void)lba;
		(void)cnt;
		(void)buff;
		DBG("[ERROR] can't write in bootloader, driver is readonly");
		return -1;
	}

	ProvInterface get_if() {
		return ProvInterface(this,
			[](void *ctx, uint32_t lba, uint32_t cnt, char *buff) {
				return ((BootReader *)ctx)->read_sector(lba, cnt, buff);
			},
			[](void *ctx, uint32_t lba, uint32_t cnt, char *buff) {
				return ((BootReader *)ctx)->write_sector(lba, cnt, buff);
			});
	}
};

#endif