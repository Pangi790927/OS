#ifndef PCI_H
#define PCI_H

#include "types.h"
#include "cbk.h"
#include "dev_ifaces.h"

#define PCI_CONFIG_ADDR		0xCF8
#define PCI_CONFIG_DATA		0xCFC

// TO DO: int 0x1A, AX=0xB101 (PCI BIOS presence check)
namespace pci
{
	struct addr_reg_t {
		uint32_t zero_off			: 2;
		uint32_t off				: 6;
		uint32_t fn_num				: 3;
		uint32_t dev_num			: 5;
		uint32_t bus_num			: 8;
		uint32_t reserved			: 7;
		uint32_t enable				: 1;

		void zero() {
			*(uint32_t *)this = 0;
		}

		addr_reg_t(uint32_t value = 0) {
			*(uint32_t *)this = value;
		}

		operator uint32_t() {
			return *(uint32_t *)this;	
		}
	} __attribute__((__packed__));

	struct command_reg_t {
		uint16_t io_space		: 1;
		uint16_t mem_space		: 1;
		uint16_t bus_master		: 1;
		uint16_t spec_cycle		: 1;
		uint16_t write_inval	: 1;
		uint16_t vga_snoop		: 1;
		uint16_t parity_err_rsp	: 1;
		uint16_t reserved		: 1;
		uint16_t serr_enable	: 1; // If set to 1 the SERR# driver is enabled
		uint16_t back2back		: 1; // Fast Back-to-Back Enable
		uint16_t int_disable	: 1;
		uint32_t reserved1		: 5;

		void zero() {
			*(uint16_t *)this = 0;
		}

		command_reg_t(uint16_t value = 0) {
			*(uint16_t *)this = value;
		}

		operator uint16_t() {
			return *(uint16_t *)this;	
		}
	} __attribute__((__packed__));

	struct status_reg_t {
		uint16_t reserved			: 3;
		uint16_t int_status			: 1;
		uint16_t list_capab			: 1; // list capabilities
		uint16_t can_66mhz			: 1;
		uint16_t reserved1			: 1;
		uint16_t can_back2back		: 1;
		uint16_t master_pa_err		: 1; // master parity error
		uint16_t devsel_timing		: 1;
		uint16_t sig_target_abort	: 1;
		uint16_t recv_target_abrt	: 1;
		uint16_t recv_master_abrt	: 1;
		uint16_t sig_system_err		: 1;
		uint16_t detect_pa_err		: 1;

		void zero() {
			*(uint16_t *)this = 0;
		}

		status_reg_t(uint16_t value = 0) {
			*(uint16_t *)this = value;
		}

		operator uint16_t() {
			return *(uint16_t *)this;	
		}
	} __attribute__((__packed__));

	struct bar_io_t {
		uint32_t zero		: 1;	
		uint32_t reserved	: 1;	
		uint32_t base_addr	: 30; // 4 bit aligned	
	} __attribute__((__packed__));

	struct bar_mem_t {
		uint32_t zero			: 1;	
		uint32_t type			: 2;	
		uint32_t prefetchable	: 1;	
		uint32_t base_addr		: 28; // 16 bit aligned	
	} __attribute__((__packed__));

	struct bar_t {
		union {
			bar_io_t io;
			bar_mem_t m;
		};

		void zero() {
			*(uint32_t *)this = 0;
		}

		bar_t(uint32_t value = 0) {
			*(uint32_t *)this = value;
		}

		operator uint32_t() {
			return *(uint32_t *)this;	
		}
	} __attribute__((__packed__));

	struct hdr_type_t {
		uint8_t type		: 7;
		uint8_t multi_fn	: 1;

		void zero() {
			*(uint8_t *)this = 0;
		}

		hdr_type_t(uint8_t value = 0) {
			*(uint8_t *)this = value;
		}

		operator uint8_t() {
			return *(uint8_t *)this;	
		}
	} __attribute__((__packed__));

	struct bist_t {
		uint8_t completion_code		: 4;
		uint8_t reserved			: 2;
		uint8_t start_bist			: 1;
		uint8_t bist_capable		: 1;

		void zero() {
			*(uint8_t *)this = 0;
		}

		bist_t(uint8_t value = 0) {
			*(uint8_t *)this = value;
		}

		operator uint8_t() {
			return *(uint8_t *)this;	
		}
	} __attribute__((__packed__));

	struct config_reg_hdr_t {
		uint16_t vendor_id;
		uint16_t device_id;
		uint16_t command;
		uint16_t status;
		uint8_t	rev_id;
		uint8_t	prog_if;
		uint8_t subclass;
		uint8_t class_code;
		uint8_t cache_line_size;
		uint8_t latency_timer;
		uint8_t hdr_type;
		uint8_t bist;		// built-in self test
	} __attribute__((__packed__));

	// normal
	struct config_reg_0_t {
		union {
			uint32_t bar[6];
			struct {
				uint32_t bar0;
				uint32_t bar1;
				uint32_t bar2;
				uint32_t bar3;
				uint32_t bar4;
				uint32_t bar5;
			} __attribute__((__packed__));
		};
		uint32_t cis_ptr;
		uint16_t subsys_vendor_id;
		uint16_t system_id;
		uint32_t expansion_rom_addr;
		uint8_t capability;
		uint8_t reserved[3];
		uint32_t reserved1;
		uint8_t int_line;
		uint8_t int_pin;
		uint8_t min_grant;
		uint8_t max_latency;
	} __attribute__((__packed__));

	// PCI-to-PCI bridge
	struct config_reg_1_t {
		union {
			uint32_t bar[2];
			struct {
				uint32_t bar0;
				uint32_t bar1;
			} __attribute__((__packed__));
		};
		uint8_t primary_buss_num;
		uint8_t second_buss_num;
		uint8_t subord_buss_num;
		uint8_t second_latency_timer;
		uint8_t io_base;
		uint8_t io_limit;
		uint16_t second_status;
		uint16_t mem_base;
		uint16_t mem_limit;
		uint16_t prefetchable_base;
		uint16_t prefetchable_limit;
		uint32_t prefetchable_upper_base;
		uint32_t prefetchable_upper_limit;
		uint16_t io_base_16;
		uint16_t io_limit_16;
		uint8_t capability;
		uint8_t reserved[3];
		uint8_t int_line;
		uint8_t int_pin;
		uint16_t bridge_ctl;
	} __attribute__((__packed__));

	// PCI-to-CardBus bridge
	struct config_reg_2_t {
		uint32_t cardbus_base_addr;
		uint8_t off_capab;
		uint8_t reserved;
		uint16_t second_status_off;
		uint8_t pci_bus_num;
		uint8_t cardbus_bus_num;
		uint8_t subord_bus_num;
		uint8_t cardbus_latency;
		uint32_t mem_addr_0;
		uint32_t mem_limit_0;
		uint32_t mem_addr_1;
		uint32_t mem_limit_1;
		uint32_t io_addr_0;
		uint32_t io_limit_0;
		uint32_t io_addr_1;
		uint32_t io_limit_1;
		uint8_t int_line;
		uint8_t int_pin;
		uint16_t bridge_ctl;
		uint16_t sub_vendor_id;
		uint16_t sub_device_id;
		uint32_t legacy_base_addr;
	} __attribute__((__packed__));

	struct config_reg_t {
		union {
			struct {
				config_reg_hdr_t hdr;
				union {
					config_reg_0_t a;
					config_reg_1_t b;
					config_reg_2_t c;
				};
			} __attribute__((__packed__));
			uint32_t data[64];
		};

	} __attribute__((__packed__));

	/* this works in the following way:
		- you first init one of those with a driver and a callback to notify the
		module that uses this driver. For example, you would implement more than
		one network driver and all of them would point to the same tcp/ip stack,
		or you would have more than one storage device.
		- when a new pci device is detected, the list of registered pci_dev_t's
		is iterated and init is called on the first matching driver
		- 0 is returned when the driver is done initializing and INIT_DEV_CBK
		is called, which will notify the module of this device initialization
		- if the driver is already initialized, a copy is made and a new struct
		is added by pci */
	struct pci_dev_t {
		using init_fn = int (*)(pci_dev_t *dev, config_reg_t *pci_reg);
		using uninit_fn = void (*)(pci_dev_t *dev);
		using get_if_fn = void *(*)(pci_dev_t *dev, int if_num);
		using reg_cbk_fn = int *(*)(pci_dev_t *dev, cbk_t cbk, int cbk_type);

		// those are set by the user
		uint8_t class_id;
		uint8_t subclass;

		init_fn init;
		uninit_fn uninit;
		get_if_fn get_if;
		reg_cbk_fn reg_cbk;

		// can be set during init
		void *ctx = NULL;

		// those are set by pci, must be null first
		uint8_t pci_bus = 0;
		uint8_t pci_dev = 0;
		uint8_t pci_fn = 0;

		pci_dev_t *next = NULL;
		bool init_done = false;
	};

	static_assert(sizeof(config_reg_hdr_t) == 16, "hdr_reg_t has invalid size");
	static_assert(sizeof(addr_reg_t) == 4, "addr_reg_t has invalid size");
	static_assert(sizeof(command_reg_t) == 2, "command_reg_t has invalid size");
	static_assert(sizeof(status_reg_t) == 2, "status_reg_t has invalid size");
	static_assert(sizeof(bar_t) == 4, "bar_t has invalid size");
	static_assert(sizeof(config_reg_t) == 256, "config_reg_t has invalid size");

	void init(dev_mgr_if *_idev_mgr);

	uint32_t read_reg(addr_reg_t addr);
	void read_conf_reg(addr_reg_t addr, config_reg_t *reg);
	void read_conf_hdr(addr_reg_t addr, config_reg_hdr_t *hdr);
	uint16_t read_vendor_id(addr_reg_t addr);

	void dbg_print_hdr(config_reg_hdr_t *hdr);
	void dbg_print_addr_reg(addr_reg_t *reg);

	void add_driver(pci_dev_t *);
	void scan_buses();
	const char *class_info(uint8_t class_code, uint8_t subclass);
}

#endif
