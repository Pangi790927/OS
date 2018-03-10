#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "Types.h"

namespace keyboard
{
	const uint16 DATA_PORT = 0x60;		// keyboard 
	const uint16 COMMAND_PORT = 0x64;	// keyboard controler (difrent from above)
	const uint8 SET_SCAN_CODE = 0xF0;
	const uint8 SCAN_CODE_2 = 0x02;
	const uint8 RESET = 0xFF;
	
	const uint8 ACK = 0xFA;
	const uint8 RESEND = 0xFE;
	const uint8 SELF_TEST_PASSED = 0xAA;
	const int maxQueSize = 1024;

	bool hasNewKey();
	void ackKey();
	bool checkInit();
	void init();
	void irq (uint8 key);
	uint32 getKey();
	void popKey();
	int keyCount();
}

#endif