#include "pit.h"
#include "Types.h"
#include "c_asm_func.h"

uint8 pit::makeCommand (uint8 channel, uint8 access_mode,
		uint8 operating_mode, uint8 representation) {
	return channel | access_mode | operating_mode | representation;
}

void pit::initDefault (uint16 divider) {
	if (divider <= 1)
		divider = 2;
	
	uint8 command = makeCommand(CHANNEL_0, LO_HI_BYTE_ACCESS,
			SQUARE_GENERATOR, BINARY_REP);

	outb(COMMAND_REGISTER, command);
	outb(DATA_CHANNEL_0, divider & 0xff);
	outb(DATA_CHANNEL_0, (divider >> 8) & 0xff);
}