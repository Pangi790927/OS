#ifndef PS2_H
#define PS2_H

#include "Types.h"

namespace ps2
{
	enum Ports {
		DATA_PORT = 0x60,	/* data port */
		COMM_PORT = 0x64,	/* command and status register */
	};

	enum Status {
		OUT_STATUS =	0b0000'0001,	/*  */
		IN_STATUS =		0b0000'0010,	/*  */
		SYS_FLAG =		0b0000'0100,	/*  */
		COMM_DATA =		0b0000'1000,	/*  */
		UNKNOWN1 =		0b0001'0000,	/*  */
		AUX_DEV =		0b0010'0000,	/* when bit0 and this one is 1 => aux */
		ERR_TIMEO =		0b0100'0000,	/*  */
		PARITY_ERR =	0b1000'0000,	/*  */
	};

#	define READ_CONF_BYTEN(n) (READ_CONF_BYTE0 + n)
#	define WRITE_CONF_BYTEN(n) (WRITE_CONF_BYTE0 + n)

	enum Commands {
		READ_CONF_BYTE0 =	0x20,
		WRITE_CONF_BYTE0 =	0x60,
		DISABLE_2ND_PORT =	0xA7,	/* only if supported */
		ENABLE_2ND_PORT =	0xA8,	/* only if supported */
		TEST_2ND_PORT =		0xA9,	/* only if supported, 0 - passed */
		TEST_PS2_CTRL =		0xAA,	/* 0x55 - passed */
		TEST_1ST_PORT =		0xAB,	/* 0 - passed */
		DIAG_DUMP =			0xAC,
		DISABLE_1ST_PORT =	0xAD,
		ENABLE_1ST_PORT =	0xAE,
		READ_CTRL_IN_PORT =	0xC0,
		UNUSED_COMMAND1 =	0xC1,	/* I won't use thos commands */
		UNUSED_COMMAND2 =	0xC2,
		READ_CTRL_OUT =		0xD0,
		WRITE_CTRL_OUT =	0xD1,
		WRITE_OUT_BUFF1 = 	0xD2,
		WRITE_OUT_BUFF2 = 	0xD3,
		WRITE_IN_BUFF2 = 	0xD4,
	};

	enum ConfigByte {
		IRQ_1ST_PORT =	0b0000'0001,	/* (1 = enabled, 0 = disabled)  */
		IRQ_2ND_PORT =	0b0000'0010,	/* (1 = enabled, 0 = disabled)  */
		// SYS_FLAG	 =	0b0000'0100,	/* same value as above */
		ZERO1 =			0b0000'1000,
		PORT1_CLK =		0b0001'0000,	/* (1 = disabled, 0 = enabled) */
		PORT2_CLK =		0b0010'0000,	/* (1 = disabled, 0 = enabled) */
		PORT1_TRANS =	0b0100'0000,	/* (1 = enabled, 0 = disabled) */
		ZERO2 =			0b1000'0000,
	};

	enum CtrlOutPort {
		DANGEROUS_RESET =	0b0000'0001,
		A20_GATE =			0b0000'0010,
		CLK_1ST_PORT =		0b0000'0100,
		CLK_1ST_DATA =		0b0000'1000,
		OUT_BUFF1_FULL =	0b0001'0000,
		OUT_BUFF2_FULL =	0b0010'0000,
		CLK_2ST_PORT =		0b0100'0000,
		CLK_2ST_DATA =		0b1000'0000,
	};

	void init();
	bool is_init();
	bool clear_data();
	uint8 send_command(uint8 comm, bool has_ret = false);
	void send_data(uint8 data);
	uint8 read_data();
}

#endif