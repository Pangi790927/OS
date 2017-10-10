#ifndef PCI_H
#define PCI_H

#include "Types.h"

#define PCI_CONFIG_ADDRESS 0xCF8
#define PCI_CONFIG_DATA 0xCFC

u_int_16 pciAddressReadWord(u_int_8 bus, u_int_8 device, u_int_8 func, u_int_8 offset);
u_int_16 pciCheckVendor(u_int_8 bus, u_int_8 slot);

#endif