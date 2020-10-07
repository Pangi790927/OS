#include "types.h"
#include "dev_ifaces.h"
#include "dev_if_helper.h"

/* there is a difrence to be noted: there are two types of objects, a driver
and a device. A driver holds the necesary information to initialize and create
a device.
You would first create a driver for your device and add this driver
in device manager(dev_mgr). When a device is detected, dev_mgr is asked to
provide a driver structure to initialize that device. The driver's specific init
function is called and a device struct is created. That device struct is added
back into dev_mgr with device specific match identification data. You should
note that there could be more than one devices created by a driver, one example
consists of having more than one ata storage device. */

#ifdef DYNAMIC_LIB

static alloc_fn_t _alloc_fn;
static free_fn_t _free_fn;

struct dev_mgr_t : public dev_mgr_if {
	virtual int reg_driver(drv_if *driver, base_match_t *match) {
		(void)type;
		(void)match;
		(void)driver;
		/* TO DO */
		return -1;
	}

	virtual drv_if *find_driver(base_match_t *match) {
		(void)type;
		(void)match;
		/* TO DO */
		return NULL;
	}

	virtual int reg_device(dev_if *device, base_match_t *match) {
		(void)type;
		(void)match;
		(void)device;
		/* TO DO */
		return -1;
	}

	virtual dev_if *find_device(base_match_t *match) {
		(void)type;
		(void)match;
		/* TO DO */
		return NULL;
	}
};

static if_instance<dev_mgr_t> dev_mgr;

extern "C" int init(alloc_fn_t alloc_fn, free_fn_t free_fn) {
	_alloc_fn = alloc_fn;
	_free_fn = free_fn;
	dev_mgr.init();
	return 0;
}

extern "C" void uninit() {
	dev_mgr.uninit();
}

extern "C" void *get_if(int if_num) {
	if (if_num == dev_mgr_if::n)
		return (dev_mgr_if *)dev_mgr.get();
	return NULL;
}

#endif
