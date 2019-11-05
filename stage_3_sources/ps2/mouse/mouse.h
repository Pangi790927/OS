#ifndef MOUSE_H
#define MOUSE_H

#include "Types.h"

namespace mouse
{
	enum Commands {
		RESET =			0xFF,	/* reset */
		RESEND =		0xFE,	/* resend */
		DEFAULT =		0xF6,	/* set defaults */
		DISABLE_DATA =	0xF5,	/* disable data reporting */
		ENABLE_DATA =	0xF4,	/* enable data reporting */
		SAMPLE_RATE =	0xF3,	/* sample rates: [10, 20, 40, 60, 80, 100, 200] */
		GET_ID =		0xF2,	/* get device id */
		REMOTE_MODE =	0xF0,	/* set remote mode */
		WRAP_MODE =		0xEE,	/* set wrap mode */
		RESET_WRAP =	0xEC,	/* reset wrap mode */
		READ_DATA =		0xEB,	/* read data */
		STREAM_MODE =	0xEA,	/* set stream mode */
		STATUS_REQ =	0xE9,	/* status request */
		RESOLUTION =	0xE8,	/* set resolution: [1, 2, 4, 8]*/
		SCALING =		0xE6,	/* set scaling: [1, 2] */
	};

	enum Response {
		ACK = 0xFA,
		SELF_TEST_PASSED = 0xAA,
	};

	enum EventTypes {
		NO_EVENT,
		LBTN_DOWN,
		LBTN_UP,
		RBTN_DOWN,
		RBTN_UP,
		MBTN_DOWN,
		MBTN_UP,
		MOUSE_MOVE,
		WHEEL_MOVE,
	};

	struct Event {
		uint8 ev_type;
		int16 mov_x = 0;
		int16 mov_y = 0;
		int16 mov_z = 0;

		Event(uint8 ev_type = 0, int16 dx = 0, int16 dy = 0, int16 dz = 0)
		: ev_type(ev_type), mov_x(dx), mov_y(dy), mov_z(dz) {}
	};

	constexpr const int max_que_size = 1024;

	void init();
	void uninit();

	bool is_init();
	void set_sample_rate(uint8 rate);
	int identify();

	void irq();

	Event top_event();
	Event pop_event();
	int event_cnt();
}

#endif