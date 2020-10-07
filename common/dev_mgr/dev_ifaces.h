#ifndef INTERFACES_H
#define INTERFACES_H

struct base_match_t {
	virtual bool match(base_match_t *oth) = 0;
};

struct net_match_t : public base_match_t {
	virtual bool match(base_match_t *oth) {
		auto o = dynamic_cast<net_match_t *>(oth);
		return !!o;
	}
};

struct vesa_match_t : public base_match_t {
	virtual bool match(base_match_t *oth) {
		auto o = dynamic_cast<vesa_match_t *>(oth);
		return !!o;
	}
};

struct pci_vendor_match_t : public base_match_t {
	uint16_t vendor_id;
	uint16_t device_id;

	virtual bool match(base_match_t *oth) {
		auto o = dynamic_cast<pci_vendor_match_t *>(oth);
		return !!o && o->vendor_id == vendor_id && o->device_id == device_id;
	}
};

struct pci_class_match_t : public base_match_t {
	uint16_t class_code;
	uint16_t subclass;

	virtual bool match(base_match_t *oth) {
		auto o = dynamic_cast<pci_class_match_t *>(oth);
		return !!o && o->class_code == class_code && o->subclass == subclass;
	}
};

struct pci_addr_match_t : public base_match_t {
	uint8_t bus;
	uint8_t dev;
	uint8_t fn;

	virtual bool match(base_match_t *oth) {
		auto o = dynamic_cast<pci_addr_match_t *>(oth);
		return !!o && o->bus == bus && o->dev == dev && o->fn == fn;
	}
};

struct drv_if {
	virtual void *get_if(int if_num) = 0;
	constexpr const static int n = __LINE__;
};

struct dev_if {
	virtual void *get_dev_if(int if_num) = 0;
	constexpr const static int n = __LINE__;
};

struct dev_mgr_if {
	virtual int reg_driver(drv_if *driver, base_match_t *match) = 0;
	virtual drv_if *find_driver(base_match_t *match) = 0;

	virtual int reg_device(dev_if *device, base_match_t *match) = 0;
	virtual dev_if *find_device(base_match_t *match) = 0;

	constexpr const static int n = __LINE__;
};

struct pcidrv_if {
	virtual int pci_init(void *hdr, int bus, int dev, int fn) = 0;

	constexpr const static int n = __LINE__;
};

struct storage_if {
	virtual int read(uint32_t lba, void *buff, int cnt) = 0;
	virtual int write(uint32_t lba, void *buff, int cnt) = 0;

	constexpr const static int n = __LINE__;
};

#endif
