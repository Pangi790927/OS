#include "pci.h"
#include "ioports.h"
#include "dbg.h"

namespace pci
{
	uint32_t read_reg(addr_reg_t addr) {
		outl(PCI_CONFIG_ADDR, addr);
		return inl(PCI_CONFIG_DATA);
	}

	void read_conf_reg(addr_reg_t addr, config_reg_t *reg) {
		if (addr.off != 0)
			EXCEPTION("Can't read from non-aligned pci_addr");
		for (int i = 0; i < 64; i++) {
			outl(PCI_CONFIG_ADDR, addr);
			reg->data[i] = inl(PCI_CONFIG_DATA);
			addr.off++;
		}
	}

	void read_conf_hdr(addr_reg_t addr, config_reg_hdr_t *hdr) {
		if (addr.off != 0)
			EXCEPTION("Can't read from non-aligned pci_addr");
		char *p = (char *)hdr;
		uint32_t *arr = (uint32_t *)p;
		for (size_t i = 0; i < sizeof(config_reg_hdr_t) / 4; i++) {
			outl(PCI_CONFIG_ADDR, addr);
			arr[i] = inl(PCI_CONFIG_DATA);
			addr.off++;
		}
	}

	uint16_t read_vendor_id(addr_reg_t addr) {
		config_reg_hdr_t hdr;
		read_conf_hdr(addr, &hdr);
		return hdr.vendor_id;
	};

	void dbg_print_hdr(config_reg_hdr_t *hdr) {
		DBG("helper string: %s", class_info(hdr->class_code, hdr->subclass));
		DBG("vendor_id: %x device_id: %x", hdr->vendor_id, hdr->device_id);
		DBG("command: %b status: %b", hdr->command, hdr->status);
		DBG("rev_id: %x prog_if: %x subclass: %x class_code: %x",
				hdr->rev_id, hdr->prog_if, hdr->subclass, hdr->class_code);
		DBG("hdr_type: %x", hdr->hdr_type);
	}

	void dbg_print_addr_reg(addr_reg_t *reg) {
		DBG("bus: %x dev: %x fn: %x off: %x ",
				reg->bus_num, reg->dev_num, reg->fn_num, reg->off);
	}

	void scan_buses() {
		for (int bus_num = 0; bus_num < 256; bus_num++) {
			for (int dev_num = 0; dev_num < 32; dev_num++) {
				config_reg_hdr_t hdr;
				addr_reg_t addr;
				addr.enable = true;
				addr.bus_num = bus_num;
				addr.dev_num = dev_num;
				read_conf_hdr(addr, &hdr);
				int fn_num_max = 1;
				if (hdr_type_t(hdr.hdr_type).multi_fn)
					fn_num_max = 8;
				for (int fn_num = 0; fn_num < fn_num_max; fn_num++) {
					addr.fn_num = fn_num;
					read_conf_hdr(addr, &hdr);
					if (hdr.vendor_id != 0xffff) {
						DBG("Found dev:");
						dbg_print_addr_reg(&addr);
						dbg_print_hdr(&hdr);
					}
				}
			}
		}
		return ;
	}

	const char *class_info(uint8_t class_code, uint8_t subclass) {
		// took from here:
		// https://wiki.osdev.org/PCI#Header_Type_Register
		switch (class_code) {
			case 0x12: return "Processing Accelerator";
			case 0x13: return "Non-Essential Instrumentation";
			case 0x14: return "(Reserved)";
			case 0x40: return "Co-Processor";
			case 0x41: return "(Reserved)";
			case 0xFF: return "Unassigned Class (Vendor specific)";
		}

		switch ((class_code << 8) + subclass) {
			case 0x00'00: return "Unclassified | " "Non-VGA-Compatible devices";
			case 0x00'01: return "Unclassified | " "VGA-Compatible Device ";

			case 0x01'00: return "Mass Storage Controller | "
					"SCSI Bus Controller";
			case 0x01'01: return "Mass Storage Controller | "
					"IDE Controller ";
			case 0x01'02: return "Mass Storage Controller | "
					"Floppy Disk Controller";
			case 0x01'03: return "Mass Storage Controller | "
					"IPI Bus Controller ";
			case 0x01'04: return "Mass Storage Controller | "
					"RAID Controller ";
			case 0x01'05: return "Mass Storage Controller | " "ATA Controller ";
			case 0x01'06: return "Mass Storage Controller | " "Serial ATA ";
			case 0x01'07: return "Mass Storage Controller | "
					"Serial Attached SCSI ";
			case 0x01'08: return "Mass Storage Controller | "
					"Non-Volatile Memory Controller";
			case 0x01'80: return "Mass Storage Controller | " "Other";

			case 0x02'00: return "Network Controller | ""Ethernet Controller ";
			case 0x02'01: return "Network Controller | "
					"Token Ring Controller ";
			case 0x02'02: return "Network Controller | " "FDDI Controller ";
			case 0x02'03: return "Network Controller | " "ATM Controller ";
			case 0x02'04: return "Network Controller | " "ISDN Controller";
			case 0x02'05: return "Network Controller | " "WorldFip Controller";
			case 0x02'06: return "Network Controller | "
					"PICMG 2.14 Multi Computing ";
			case 0x02'07: return "Network Controller | "
					"Infiniband Controller ";
			case 0x02'08: return "Network Controller | " "Fabric Controller ";
			case 0x02'80: return "Network Controller | " "Other";

			case 0x03'00: return "Display Controller | "
					"VGA Compatible Controller ";
			case 0x03'01: return "Display Controller | " "XGA Controller ";
			case 0x03'02: return "Display Controller | "
					"3D Controller (Not VGA-Compatible) ";
			case 0x03'80: return "Display Controller | " "Other";

			case 0x04'00: return "Multimedia Controller | "
					"Multimedia Video Controller ";
			case 0x04'01: return "Multimedia Controller | "
					"Multimedia Audio Controller ";
			case 0x04'02: return "Multimedia Controller | "
					"Computer Telephony Device";
			case 0x04'03: return "Multimedia Controller | "
					"Audio Device ";
			case 0x04'80: return "Multimedia Controller | " "Other";

			case 0x05'00: return "Memory Controller | " "RAM Controller";
			case 0x05'01: return "Memory Controller | " "Flash Controller";
			case 0x05'80: return "Memory Controller | " "Other";
			
			case 0x06'00: return "Bridge Device | " "Host Bridge ";
			case 0x06'01: return "Bridge Device | " "ISA Bridge ";
			case 0x06'02: return "Bridge Device | " "EISA Bridge ";
			case 0x06'03: return "Bridge Device | " "MCA Bridge";
			case 0x06'04: return "Bridge Device | " "PCI-to-PCI Bridge ";
			case 0x06'05: return "Bridge Device | " "PCMCIA Bridge ";
			case 0x06'06: return "Bridge Device | " "NuBus Bridge ";
			case 0x06'07: return "Bridge Device | " "CardBus Bridge ";
			case 0x06'08: return "Bridge Device | " "RACEway Bridge ";
			case 0x06'09: return "Bridge Device | " "PCI-to-PCI Bridge ";
			case 0x06'0A: return "Bridge Device | "
					"InfiniBand-to-PCI Host Bridge ";
			case 0x06'80: return "Bridge Device | " "Other";

			case 0x07'00: return "Simple Communication Controller | "
					"Serial Controller ";
			case 0x07'01: return "Simple Communication Controller | "
					"Parallel Controller ";
			case 0x07'02: return "Simple Communication Controller | "
					"Multiport Serial Controller ";
			case 0x07'03: return "Simple Communication Controller | " "Modem ";
			case 0x07'04: return "Simple Communication Controller | "
					"IEEE 488.1/2 (GPIB) Controller ";
			case 0x07'05: return "Simple Communication Controller | "
					"Smart Card ";
			case 0x07'80: return "Simple Communication Controller | " "Other";
		
			case 0x08'00: return "Base System Peripheral | " "PIC";
			case 0x08'01: return "Base System Peripheral | " "DMA Controller ";
			case 0x08'02: return "Base System Peripheral | " "Timer ";
			case 0x08'03: return "Base System Peripheral | " "RTC Controller ";
			case 0x08'04: return "Base System Peripheral | "
					"PCI Hot-Plug Controller ";
			case 0x08'05: return "Base System Peripheral | "
					"SD Host controller ";
			case 0x08'06: return "Base System Peripheral | " "IOMMU";
			case 0x08'80: return "Base System Peripheral | " "Other";
		
			case 0x09'00: return "Input Device Controller | "
					"Keyboard Controller ";
			case 0x09'01: return "Input Device Controller | " "Digitizer Pen ";
			case 0x09'02: return "Input Device Controller | "
					"Mouse Controller ";
			case 0x09'03: return "Input Device Controller | "
					"Scanner Controller ";
			case 0x09'04: return "Input Device Controller | "
					"Gameport Controller ";
			case 0x09'80: return "Input Device Controller | " "Other";
		
			case 0x0A'00: return "Docking Station | " "Generic";
			case 0x0A'80: return "Docking Station | " "Other";
		
			case 0x0B'00: return "Processor | " "386";
			case 0x0B'01: return "Processor | " "486 ";
			case 0x0B'02: return "Processor | " "Pentium";
			case 0x0B'03: return "Processor | " "Pentium Pro ";
			case 0x0B'10: return "Processor | " "Alpha ";
			case 0x0B'20: return "Processor | " "PowerPC";
			case 0x0B'30: return "Processor | " "MIPS ";
			case 0x0B'40: return "Processor | " "Co-Processor ";
			case 0x0B'80: return "Processor | " "Other";
		
			case 0x0C'00: return "Serial Bus Controller | "
					"FireWire (IEEE 1394) Controller";
			case 0x0C'01: return "Serial Bus Controller | " "ACCESS Bus ";
			case 0x0C'02: return "Serial Bus Controller | " "SSA ";
			case 0x0C'03: return "Serial Bus Controller | " "USB Controller ";
			case 0x0C'04: return "Serial Bus Controller | " "Fibre Channel ";
			case 0x0C'05: return "Serial Bus Controller | " "SMBus ";
			case 0x0C'06: return "Serial Bus Controller | " "InfiniBand ";
			case 0x0C'07: return "Serial Bus Controller | " "IPMI Interface ";
			case 0x0C'08: return "Serial Bus Controller | "
					"SERCOS Interface (IEC 61491) ";
			case 0x0C'09: return "Serial Bus Controller | " "CANbus";
			case 0x0C'80: return "Serial Bus Controller | " "Other";
		
			case 0x0D'00: return "Wireless Controller | "
					"iRDA Compatible Controller ";
			case 0x0D'01: return "Wireless Controller | "
					"Consumer IR Controller ";
			case 0x0D'10: return "Wireless Controller | " "RF Controller ";
			case 0x0D'11: return "Wireless Controller | "
					"Bluetooth Controller ";
			case 0x0D'12: return "Wireless Controller | "
					"Broadband Controller ";
			case 0x0D'20: return "Wireless Controller | "
					"Ethernet Controller (802.1a) ";
			case 0x0D'21: return "Wireless Controller | "
					"Ethernet Controller (802.1b) ";
			case 0x0D'80: return "Wireless Controller | " "Other";
		
			case 0x0E'00: return " Intelligent Controller | " "I20";
		
			case 0x0F'01: return "Satellite Communication Controller | " "?";
			case 0x0F'02: return "Satellite Communication Controller | " "?";
			case 0x0F'03: return "Satellite Communication Controller | " "?";
			case 0x0F'04: return "Satellite Communication Controller | " "?";
		
			case 0x10'00: return "Encryption Controller | " "?";
			case 0x10'10: return "Encryption Controller | " "?";
			case 0x10'80: return "Encryption Controller | " "?";
		
			case 0x11'00: return "Signal Processing Controller | " "?";
			case 0x11'01: return "Signal Processing Controller | " "?";
			case 0x11'10: return "Signal Processing Controller | " "?";
			case 0x11'20: return "Signal Processing Controller | " "?";
			case 0x11'80: return "Signal Processing Controller | " "?";
		}
		return "[err unknown class code | subclass]";
	}
}