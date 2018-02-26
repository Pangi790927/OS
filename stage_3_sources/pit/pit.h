#ifndef PIT_H
#define PIT_H

#include "Types.h"

namespace pit
{
	const uint16 DATA_CHANNEL_0 = 0x40;
	const uint16 DATA_CHANNEL_1 = 0x41;
	const uint16 DATA_CHANNEL_2 = 0x42;

	const uint16 COMMAND_REGISTER = 0x43;

	// command: 
	// | 0          | 1  -  3 | 4  -  5  | 6  -  7 |
	// | BCD/Binary | op mode | acc mode | channel |

	const uint8 CHANNEL_0 =			0b0000'0000;
	const uint8 CHANNEL_1 =			0b0100'0000;	// not sure if 01 or 10
	const uint8 CHANNEL_2 =			0b1000'0000;	// not sure if 10 or 01
	const uint8 READ_BACK =			0b1100'0000;

	const uint8 LATCH_COUNT =		0b0000'0000;
	const uint8 LO_BYTE_ACCESS =	0b0001'0000;	// not sure if 01 or 10
	const uint8 HI_BYTE_ACCESS =	0b0010'0000;	// not sure if 10 or 01
	const uint8 LO_HI_BYTE_ACCESS =	0b0011'0000;

	const uint8 MODE_INTERRUPT =	0b0000'0000;
	const uint8 MODE_RETRIGABLE =	0b0000'0010;
	const uint8 RATE_GENERATOR =	0b0000'0100;
	const uint8 SQUARE_GENERATOR =	0b0000'0110;
	const uint8 SOFT_TRIG_STROBE =	0b0000'1000;
	const uint8 HARD_TRIG_STROBE =	0b0000'1010;
	const uint8 RATE_GENERATOR2 =	0b0000'1100;
	const uint8 SQUARE_GENERATOR2 =	0b0000'1110;

	const uint8 BINARY_REP =		0b0000'0000;
	const uint8 BCD_REP =			0b0000'0001;	

	const uint32 BASE_FREQUENCY = 1193182;	// Hz

	uint8 makeCommand (uint8 channel, uint8 access_mode,
			uint8 operating_mode, uint8 representation);

	void initDefault (uint16 divider);
}

#endif