#ifndef INTERFACES_H
#define INTERFACES_H

#include "cbk.h"

// =========================== ENUMS ===========================================

enum CALLBACKS {
	CBK_CREATE_DEVICE,			// [void *ctx], dev_if *d, base_match_t *match
};

// ========================== MATCHERS =========================================

struct base_match_t {
	virtual bool match(base_match_t *oth) = 0;
	uint32_t t;
};

#define CREATE_MATCH_SELF(self_name) \
self_name() { t = _t; } \
bool match_self(base_match_t *b) { return _t == b->t; } \
constexpr const static uint32_t _t = __LINE__;

struct net_match_t : public base_match_t {
	virtual bool match(base_match_t *oth) { return match_self(oth); }
	CREATE_MATCH_SELF(net_match_t)
};

struct vesa_match_t : public base_match_t {
	virtual bool match(base_match_t *oth) { return match_self(oth); }
	CREATE_MATCH_SELF(vesa_match_t)
};

struct pci_vendor_match_t : public base_match_t {
	uint16_t vendor_id;
	uint16_t device_id;

	virtual bool match(base_match_t *oth) {
		auto o = static_cast<pci_vendor_match_t *>(oth);
		return match_self(oth) && o->vendor_id == vendor_id &&
				o->device_id == device_id;
	}
	CREATE_MATCH_SELF(pci_vendor_match_t)
};

struct pci_class_match_t : public base_match_t {
	uint16_t class_code;
	uint16_t subclass;

	virtual bool match(base_match_t *oth) {
		auto o = static_cast<pci_class_match_t *>(oth);
		return match_self(oth) && o->class_code == class_code &&
				o->subclass == subclass;
	}
	CREATE_MATCH_SELF(pci_class_match_t)
};

struct pci_addr_match_t : public base_match_t {
	uint8_t bus = 0;
	uint8_t dev = 0;
	uint8_t fn = 0;
	uint8_t id = 0;

	virtual bool match(base_match_t *oth) {
		auto o = static_cast<pci_addr_match_t *>(oth);
		return match_self(oth) && o->bus == bus && o->dev == dev && o->fn == fn
				&& o->id == id;
	}
	CREATE_MATCH_SELF(pci_addr_match_t)
};

// ========================= INTERFACES ========================================

struct drv_if {
	virtual void *get_if(int if_num) = 0;
	virtual void register_cbk(cbk_t cbk, int cbk_num) = 0;
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

	// [void *ctx], drv_if *
	virtual void iter_drivers(cbk_t cbk) = 0;

	// [void *ctx], dev_if *
	virtual void iter_devices(cbk_t cbk) = 0;

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

// ========================= CALLBACKS =========================================

using cbk_create_device_t = int (*)(void *, dev_if *, base_match_t *);
using cbk_iter_dev_t = int (*)(void *, dev_if *);
using cbk_iter_drv_t = int (*)(void *, drv_if *);

#endif
