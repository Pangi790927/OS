#include "boot_dev_mgr.h"
#include "dev_ifaces.h"
#include "dev_if_helper.h"

static alloc_fn_t _alloc_fn;
static free_fn_t _free_fn;

struct dev_mgr_t : public dev_mgr_if {
	template <typename Type>
	struct ListNode {
		Type *obj;
		base_match_t *match;
		ListNode<Type> *next;
	};

	ListNode<drv_if> *drv_start = NULL;
	ListNode<dev_if> *dev_start = NULL;

	template <typename T>
	auto find_match(T *list_start, base_match_t *match) {
		auto curr = list_start;
		while (curr) {
			if (curr->match->match(match))
				return curr;
			curr = curr->next;
		}
		return (T *)(NULL);
	}

	virtual int reg_driver(drv_if *driver, base_match_t *match) {
		if (!driver || !match) {
			DBG("No more nullptr to dev_mgr plz");
			return -1;
		}
		if (find_match(drv_start, match))
			return -1;

		auto new_driver = alloc_obj<ListNode<drv_if>>(_alloc_fn);
		if (!new_driver)
			return -1;
		new_driver->obj = driver;
		new_driver->match = match;
		new_driver->next = drv_start;
		cbk_t cbk {
			.fn = (void *)+[](void *c, dev_if *d, base_match_t *match) {
				((dev_mgr_t *)c)->reg_device(d, match);
			},
			.ctx = (void *)this,
		};
		driver->register_cbk(cbk, CBK_CREATE_DEVICE);
		drv_start = new_driver;
		return 0;
	}

	virtual drv_if *find_driver(base_match_t *match) {
		if (!match) {
			DBG("No more nullptr to dev_mgr plz");
			return NULL;
		}
		auto obj_inst = find_match(drv_start, match);
		if (!obj_inst)
			return NULL;
		return obj_inst->obj;
	}

	virtual int reg_device(dev_if *device, base_match_t *match) {
		if (!device || !match) {
			DBG("No more nullptr to dev_mgr plz");
			return -1;
		}
		if (find_match(dev_start, match))
			return -1;

		DBG("Adding device: %p match: %p", device, match);
		auto new_device = alloc_obj<ListNode<dev_if>>(_alloc_fn);
		if (!new_device)
			return -1;
		new_device->obj = device;
		new_device->match = match;
		new_device->next = dev_start;
		dev_start = new_device;
		return 0;
	}

	virtual dev_if *find_device(base_match_t *match) {
		if (!match) {
			DBG("No more nullptr to dev_mgr plz");
			return NULL;
		}
		auto obj_inst = find_match(dev_start, match);
		if (!obj_inst)
			return NULL;
		return obj_inst->obj;
	}

	// [void *ctx], drv_if *
	virtual void iter_drivers(cbk_t cbk) {
		auto curr = drv_start;
		while (curr) {
			if (cbk.call<cbk_iter_drv_t>(curr->obj) == 0)
				break;
			curr = curr->next;
		}
	}

	// [void *ctx], dev_if *
	virtual void iter_devices(cbk_t cbk) {
		auto curr = dev_start;
		while (curr) {
			DBG("curr: %p, obj: %p", curr, curr->obj);
			if (cbk.call<cbk_iter_dev_t>(curr->obj) == 0)
				break;
			curr = curr->next;
		}
	}

};

static dev_mgr_t *dev_mgr = NULL;

int dev_mgr_init(alloc_fn_t alloc_fn, free_fn_t free_fn) {
	if (!dev_mgr) {
		_alloc_fn = alloc_fn;
		_free_fn = free_fn;
		dev_mgr = alloc_obj<dev_mgr_t>(alloc_fn);
		if (!dev_mgr) {
			DBG("Can't allocate object");
			return -1;
		}
	}
	return 0;
}

void dev_mgr_uninit() {
	free_obj(_free_fn, dev_mgr);
}

void *dev_mgr_get_if(int if_num) {
	if (if_num == dev_mgr_if::n)
		return static_cast<dev_mgr_if *>(dev_mgr);
	return NULL;
}
