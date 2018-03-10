#include "stdio.h"
#include "keyboard.h"
#include "c_asm_func.h"

namespace keyboard
{
	bool newKey = false;
	bool isInit = false;
	uint32 keys[maxQueSize + 1];
	int queStart = 0;
	int queEnd = 0;
	int count = 0;
}

bool keyboard::checkInit() {
	return isInit;
}

static void waitCanRead() {
	while ((inb(keyboard::COMMAND_PORT) & 1u) == 0u)
		asm volatile ("nop");
}

static void waitCanWrite() {
	while ((inb(keyboard::COMMAND_PORT) & 2u) != 0u)
		asm volatile ("nop");
}

void keyboard::init() {
	isInit = true;
	newKey = false;
	queStart = 0;
	queEnd = 0;
	count = 0;
	bool done = false;

	// waitCanWrite();
	// outb(COMMAND_PORT, 0xAD);
	
	// waitCanWrite();
	// outb(COMMAND_PORT, 0xA7);
	
	// waitCanRead();
	// inb(COMMAND_PORT);

	waitCanWrite();
	outb(COMMAND_PORT, 0x20);
	
	waitCanRead();
	uint8 conf = inb(DATA_PORT);

	waitCanWrite();
	outb(COMMAND_PORT, 0x60);

	waitCanWrite();
	outb(DATA_PORT, conf & 0b1011'1111);
	
	// waitCanWrite();
	// outb(COMMAND_PORT, 0xAE);
	
	// waitCanWrite();
	// outb(COMMAND_PORT, 0xA8);

	for (int i = 0; i < 3 && !done; ++i) {
		waitCanWrite();
		outb(DATA_PORT, RESET);
		waitCanRead();
		uint8 response = inb(DATA_PORT);

		if (response == ACK) {
			done = true;
		}
		else if (response != RESEND) {
			printf("RESET_FAILED %x\n", response);
			break;
		}
	}
	
	waitCanRead();
	uint8 response = inb(DATA_PORT);

	if (response != SELF_TEST_PASSED) {
		printf("SELF_TEST_FAILED %x\n", response);
	}

	for (int i = 0; i < 3 && !done; ++i) {
		waitCanWrite();
		outb(DATA_PORT, SET_SCAN_CODE);
		// waitCanWrite();
		outb(DATA_PORT, 2);
		waitCanRead();
		response = inb(DATA_PORT);

		if (response == ACK) {
			done = true;
		}
		else if (response != RESEND) {
			printf("KEYBOARD_SCAN_CODE_FAIL %x\n", response);
			break;
		}
	}

	if (!done)
		printf("Keyboard inactive\n");
}

void keyboard::irq (uint8 key) {
	if (queEnd == queStart && count != 0)
		popKey();
	keys[queEnd++] = key;
	if (queEnd > maxQueSize)
		queEnd = 0;
	count++;
	newKey = true;
}

bool keyboard::hasNewKey() {
	return newKey;
}

void keyboard::ackKey() {
	newKey = false;
}

uint32 keyboard::getKey() {
	return keys[queStart];
}

int keyboard::keyCount() {
	return count;
}

void keyboard::popKey() {
	if (queStart == queEnd)
		return;
	queStart++;
	if (queStart > maxQueSize)
		queStart = 0;
	count--;
}

