#include "boot_dev_mgr.h"
#include "dev_ifaces.h"
#include "dev_if_helper.h"

static alloc_fn_t _alloc_fn;
static free_fn_t _free_fn;


struct dev_mgr_t : public dev_mgr_if {
	virtual int reg_driver(drv_if *driver, base_match_t *match) {
		(void)match;
		(void)driver;
		/* TO DO */
		return -1;
	}

	virtual drv_if *find_driver(base_match_t *match) {
		(void)match;
		/* TO DO */
		return NULL;
	}

	virtual int reg_device(dev_if *device, base_match_t *match) {
		(void)match;
		(void)device;
		/* TO DO */
		return -1;
	}

	virtual dev_if *find_device(base_match_t *match) {
		(void)match;
		/* TO DO */
		return NULL;
	}
};

static if_instance<dev_mgr_t> dev_mgr;

int dev_mgr_init(alloc_fn_t alloc_fn, free_fn_t free_fn) {
	_alloc_fn = alloc_fn;
	_free_fn = free_fn;
	dev_mgr.init();
	return 0;
}

void dev_mgr_uninit() {
	dev_mgr.uninit();
}

void *dev_mgr_get_if(int if_num) {
	if (if_num == dev_mgr_if::n)
		return (dev_mgr_if *)dev_mgr.get();
	return NULL;
}
