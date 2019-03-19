#ifndef NETINFO_H
#define NETINFO_H

#include "string.h"
#include "net.h"

namespace net {
	std::string netinfo() {
		auto& dev = net::driver();
		if (!net::is_valid())
			return "Invalid network device\n";
		std::string ret = 
				std::string() + 
				"devID: " +
				std::to_string((int)dev.pciDevice.deviceId, 16) + 
				" vendor: " +
				std::to_string((int)dev.pciDevice.vendorId, 16) + "\n";

		ret += "addr bar0: " + std::to_string(dev.pciDevice.bar0, 16) + "\n";
		ret += "mmio_base: " + std::to_string((uint32)dev.mmio_base, 16) + "\n";
		ret += "mac = ";
		ret += 	std::to_string((int)dev.mac[0] >> 4, 16) +
				std::to_string((int)dev.mac[0] & 0xf, 16) + ":" + 
				std::to_string((int)dev.mac[1] >> 4, 16) +
				std::to_string((int)dev.mac[1] & 0xf, 16) + ":" +  
				std::to_string((int)dev.mac[2] >> 4, 16) + 
				std::to_string((int)dev.mac[2] & 0xf, 16) + ":" +
				std::to_string((int)dev.mac[3] >> 4, 16) +
				std::to_string((int)dev.mac[3] & 0xf, 16) + ":" +
				std::to_string((int)dev.mac[4] >> 4, 16) +
				std::to_string((int)dev.mac[4] & 0xf, 16) + ":" +
				std::to_string((int)dev.mac[5] >> 4, 16) +
				std::to_string((int)dev.mac[5] & 0xf, 16);
		ret += "\n";
		return ret;
	}
}

#endif