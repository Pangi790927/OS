#ifndef NETINFO_H
#define NETINFO_H

#include "string.h"
#include "net.h"

namespace net {
	std::string netinfo() {
		auto& dev = net::driver();
		
		if (!net::is_valid())
			return "Invalid network device\n";

		std::string ret;
		ret += "devID: ";
		ret += std::to_string((int)dev.pci_device.deviceId, 16); 
		ret += " vendor: ";
		ret += std::to_string((int)dev.pci_device.vendorId, 16) + "\n";
		ret += "addr bar0: " + std::to_string(dev.pci_device.bar0, 16) + "\n";
		ret += "mmio_base: " + std::to_string((uint32)dev.mmio_base, 16) + "\n";
		ret += "mac = ";
		ret += eth::to_string(*(mac_addr_t *)(dev.mac));
		ret += "\n";

		return ret;
	}
}

#endif
