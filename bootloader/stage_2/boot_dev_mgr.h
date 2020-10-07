#ifndef BOOT_DEV_MGR_H
#define BOOT_DEV_MGR_H

#include "types.h"

int dev_mgr_init(alloc_fn_t alloc_fn, free_fn_t free_fn);
void dev_mgr_uninit();
void *dev_mgr_get_if(int if_num);

#endif