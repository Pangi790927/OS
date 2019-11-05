#include "mouse.h"
#include "ps2.h"
#include "kerndiag.h"
#include "static_queue.h"
#include "c_asm_func.h"

namespace mouse
{
	static static_queue_t<Event, max_que_size + 1> events_que;

	enum {
		bl = 0b0000'0001,
		br = 0b0000'0010,
		bm = 0b0000'0100,
		ao = 0b0000'1000,
		xs = 0b0001'0000,
		ys = 0b0010'0000,
		xo = 0b0100'0000,
		yo = 0b1000'0000,
	};

	struct mouse_t {
		uint8 fl;
		uint8 dx;
		uint8 dy;
	} __attribute__((__packed__));

	struct mouse_ex_t : mouse_t {
		int8 dz;
	} __attribute__((__packed__));

	static int mouse_cycle = 0;
	static bool is_init_val = false;
	static bool has_z_axis = false;
	/* this will send commands and data to mouse */
	static void mouse_send(uint8 data) {
		ps2::send_command(ps2::WRITE_IN_BUFF2);
		ps2::send_data(data);
	}

	// static bool get_ack() {
	// 	uint8 ack = ps2::read_data();
	// 	return ack == ACK;
	// }

	void init() {
		bool done = false;
		KDBG("Will try to reset mouse");
		/* try to resend 3 times */ 
		for (int i = 0; i < 3 && !done; ++i) {
			mouse_send(RESET);
			uint8 rsp = ps2::read_data();
			if (rsp == ACK) {
				done = true;
			}
			else if (rsp != RESEND) {
				KDBG("Reset failed with: %x", rsp);
				return ;
			}
		}

		if (!done) {
			KDBG("Failed to init mouse");
			return ;
		}

		uint8 self_test = ps2::read_data();
		if (self_test != SELF_TEST_PASSED) {
			KDBG("Self test failed with: %x", self_test);
			return ;
		}

		uint8 id = ps2::read_data();
		KDBG("mouse id %x", id);

		KDBG("Will try to enable z-axis");
		set_sample_rate(200);
		set_sample_rate(100);
		set_sample_rate(80);
		id = identify();
		if (id == 3) {
			has_z_axis = true;
			KDBG("z axis enabled");
		}
		else {
			KDBG("z axis disabled");
		}

		KDBG("Will set sample rate");
		set_sample_rate(40);
		is_init_val = true;
		mouse_cycle = 0;

		if (ps2::clear_data())
			KDBG("mouse data needed cleaning");

		KDBG("Will enable mouse");
		mouse_send(ENABLE_DATA);
		uint8 rsp = ps2::read_data();
		if (rsp != ACK) {
			KDBG("failed to enable mouse %x", rsp);
			return ;
		}

		KDBG("Mouse init done, id %d", id);
	}

	void uninit() {}

	bool is_init() {
		return is_init_val;
	}

	int identify() {
		mouse_send(GET_ID);
		uint8 rsp = ps2::read_data();
		if (rsp != ACK) {
			KDBG("failed to identify %x", rsp);
			return 0;
		}
		return ps2::read_data();
	}

	void set_sample_rate(uint8 rate) {
		mouse_send(SAMPLE_RATE);
		uint8 rsp = ps2::read_data();
		if (rsp != ACK) {
			KDBG("failed to send sample rate1 %x", rsp);
			return ;
		}
		mouse_send(rate);
		rsp = ps2::read_data();
		if (rsp != ACK) {
			KDBG("failed to send sample rate2 %x", rsp);
			return ;
		}
	}

	static int16 mouse_mov_val(bool overflow, bool sign, uint8 value) {
		if (overflow)
			return 0;
		int ret = 0;
		if (sign) {
			if (value == 0)
				ret = 0;
			else
				ret = 0xFFFFFF00 | (int)value;
		}
		else
			ret = value;
		return ret;
	}

	static void handle_mouse_key(uint8 bytes[4]) {
		// KDBG("%b, %d, %d, %b", bytes[0], bytes[1], bytes[2], bytes[3]);
		static mouse_ex_t last_hw_ev;
		mouse_ex_t hw_ev = *(mouse_ex_t *)bytes;
		Event new_event;

		if ((hw_ev.fl & bl) != (last_hw_ev.fl & bl)) {
			if (hw_ev.fl & bl)
				events_que.push(Event(LBTN_DOWN));
			else
				events_que.push(Event(LBTN_UP));
		}

		if ((hw_ev.fl & bm) != (last_hw_ev.fl & bm)) {
			if (hw_ev.fl & bm)
				events_que.push(Event(MBTN_DOWN));
			else
				events_que.push(Event(MBTN_UP));
		}

		if ((hw_ev.fl & br) != (last_hw_ev.fl & br)) {
			if (hw_ev.fl & br)
				events_que.push(Event(RBTN_DOWN));
			else
				events_que.push(Event(RBTN_UP));
		}

		if (hw_ev.dz != last_hw_ev.dz)
			events_que.push(Event(WHEEL_MOVE, 0, 0, hw_ev.dz));

		if ((hw_ev.fl & xs) != (last_hw_ev.fl & xs) ||
				(hw_ev.fl & ys) != (last_hw_ev.fl & ys) ||
				(hw_ev.fl & xo) != (last_hw_ev.fl & xo) ||
				(hw_ev.fl & yo) != (last_hw_ev.fl & yo) ||
				hw_ev.dx != last_hw_ev.dx ||
				hw_ev.dy != last_hw_ev.dy)
		{
			events_que.push(Event(MOUSE_MOVE,
					mouse_mov_val(hw_ev.fl & xo, hw_ev.fl & xs, hw_ev.dx),
					mouse_mov_val(hw_ev.fl & yo, hw_ev.fl & ys, hw_ev.dy)));
		}

		last_hw_ev = hw_ev;
	}

	/* what's with this strange order????? and why does this work??? */
	void irq() {
		static uint8 bytes[4] = {0};
		switch (mouse_cycle) {
			case 0:
				bytes[0] = inb(ps2::DATA_PORT);
				mouse_cycle++;
				break;
			case 1:
				bytes[1] = inb(ps2::DATA_PORT);
				mouse_cycle++;
				break;
			case 2:
				bytes[2] = inb(ps2::DATA_PORT);
				if (!has_z_axis) {
					mouse_cycle = 0;
					handle_mouse_key(bytes);
				}
				else
					mouse_cycle++;
				break;
			case 3:
				bytes[3] = inb(ps2::DATA_PORT);
				handle_mouse_key(bytes);
				mouse_cycle = 0;
				break;
		}
	}

	Event top_event() {
		return events_que.top();
	}

	Event pop_event() {
		Event to_pop = events_que.top();
		events_que.pop();
		return to_pop;
	}

	int event_cnt() {
		return events_que.size();
	}
}
