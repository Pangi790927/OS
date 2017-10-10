#include "pci.h"
#include "Types.h"
#include "stdio.h"
#include "c_asm_func.h"

u_int_16 pciAddressReadWord (u_int_8 bus, u_int_8 device, u_int_8 func, u_int_8 offset) {
	int_32 address;
    u_int_32 lbus  = (u_int_32)bus;
    u_int_32 ldevice = (u_int_32)device;
    u_int_32 lfunc = (u_int_32)func;
    u_int_16 tmp = 0;

    address = (u_int_32)((lbus << 16) | ( ldevice << 11) | (lfunc << 8) | (offset & 0xfc)
    				| ((u_int_32)0x80000000));

	port_dword_out(address, PCI_CONFIG_ADDRESS);

	// ((offset & 2) << 3) = 0 will choose the first word of the 32 bits register 
	tmp = (u_int_16)((port_dword_in(PCI_CONFIG_DATA) >> ((offset & 2) << 3)) & 0xffff);
	return tmp;
}

u_int_16 pciCheckVendor (u_int_8 bus, u_int_8 slot) {
	u_int_16 vendor, device;

	if ((vendor = pciAddressReadWord(bus, slot, 0, 0)) != 0xffff) {
		device = pciAddressReadWord(bus, slot, 0, 2);
		
		printf("Vendor: %d\n", vendor);
		printf("Device: %d\n", device);
	}
	else {
		printf("No device ... \n");
	}
	return vendor;
}