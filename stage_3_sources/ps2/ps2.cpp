#include "ps2.h"
#include "c_asm_func.h"
#include "kerndiag.h"

namespace ps2
{
	static bool is_init_val = false;
	static bool has_2nd_port = false;

	static void wait_ctrl_out() {
		while ((inb(COMM_PORT) & OUT_STATUS) == 0) {
			asm volatile ("pause");
		}
	}

	[[maybe_unused]]
	static void wait_ctrl_in() {
		while ((inb(COMM_PORT) & IN_STATUS) != 0) {
			asm volatile ("pause");
		}
	}

	uint8 read_data() {
		wait_ctrl_out();
		return inb(DATA_PORT);
	}

	uint8 send_command(uint8 comm, bool has_ret) {
		wait_ctrl_in();
		outb(COMM_PORT, comm);
		if (has_ret) {
			return read_data();
		}
		return 0;
	}

	void send_data(uint8 data) {
		wait_ctrl_in();
		outb(DATA_PORT, data);
	}

	bool clear_data() {
		bool flag = false;
		while (inb(COMM_PORT) & OUT_STATUS) {
			inb(DATA_PORT);
			flag = true;
		}
		return flag;
	}

	void init() {
		KDBG(">>> Will init ps2 controller");
		if (is_init()) {
			KDBG("ps2 allready initialized");
			return ;
		}
		/* we just imagine it exists here because I'm not in the mood to add
		ACPI whtever right now */

		KDBG("will disable all devices");
		send_command(DISABLE_1ST_PORT);
		send_command(DISABLE_2ND_PORT);

		KDBG("will clear pending data");
		clear_data();

		KDBG("will disable irq and translation");
		uint8 conf_byte = send_command(READ_CONF_BYTE0, true);
		conf_byte &= ~(IRQ_1ST_PORT | IRQ_2ND_PORT | PORT1_TRANS);
		send_command(WRITE_CONF_BYTE0);
		send_data(conf_byte);

		KDBG("will self-test");
		if (send_command(TEST_PS2_CTRL, true) != 0x55) {
			KDBG("ps2 self-test failed");
			return ;
		}
		else {
			KDBG("ps2 self-test passed");
		}

		KDBG("re-write conf byte after self-test");
		send_command(WRITE_CONF_BYTE0);
		send_data(conf_byte);

		KDBG("will check for second port");
		send_command(ENABLE_2ND_PORT);
		conf_byte = send_command(READ_CONF_BYTE0, true);
		if (!(conf_byte & PORT2_CLK)) {
			KDBG("controller has second port");
			has_2nd_port = true;
			send_command(DISABLE_2ND_PORT);
		}

		KDBG("Test and enable ps2 ports");
		if (send_command(TEST_1ST_PORT, true)) {
			KDBG("Failed 1st port test");
		}
		else {
			send_command(ENABLE_1ST_PORT);
		}
		
		if (has_2nd_port) {
			if (send_command(TEST_2ND_PORT, true)) {
				KDBG("Failed 2nd port test");
			}
			else {
				send_command(ENABLE_2ND_PORT);
			}
		}

		KDBG("re-enable ps2 irq");		
		conf_byte = send_command(READ_CONF_BYTE0, true);
		conf_byte |= IRQ_1ST_PORT;
		if (has_2nd_port)
			conf_byte |= IRQ_2ND_PORT;
		send_command(WRITE_CONF_BYTE0);
		send_data(conf_byte);

		KDBG("<<< Init ps2 ok");
		is_init_val = true;
	}

	bool is_init() {
		return is_init_val;
	}
}