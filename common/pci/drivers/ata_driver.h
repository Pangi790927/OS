#ifndef ATA_DRIVER_H
#define ATA_DRIVER_H

#include "types.h"
#include "pci.h"

/* headers of drivers cover a large spectrum of devices and the have a function
to register one or more drivers that should be added to dev_mgr_t */
int ata_reg_drivers(dev_mgr_if *idev_mgr, alloc_fn_t alloc, free_fn_t free);

#endif
