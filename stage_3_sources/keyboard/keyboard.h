#ifndef KEYBOARD_H
#define KEYBOARD_H

#include <utility>
#include "Types.h"
#include "vector.h"
#include "memory.h"

namespace keyboard
{
	const uint16 DATA_PORT = 0x60;		// keyboard 
	const uint16 COMMAND_PORT = 0x64;	// keyboard controler 
	const uint8 SET_SCAN_CODE = 0xF0;
	const uint8 SCAN_CODE_2 = 0x02;
	const uint8 RESET = 0xFF;
	
	const uint8 ACK = 0xFA;
	const uint8 RESEND = 0xFE;
	const uint8 SELF_TEST_PASSED = 0xAA;
	const int maxQueSize = 1024;

	const uint32 NON_ASCII_KEY =	0b00000000'00000000'00000001'00000000;
	const uint32 PRESS =			0b00000000'00000000'00000010'00000000;
	const uint32 RELEASE =			0b00000000'00000000'00000100'00000000;
	const uint32 NOT_USED_KEY =		0b00000000'00000000'00001000'00000000;
	const uint32 NUMPAD =			0b00000000'00000000'00010000'00000000;

	const uint32 F1_PRESS = PRESS | NON_ASCII_KEY | 0x01;
	const uint32 F2_PRESS = PRESS | NON_ASCII_KEY | 0x02;
	const uint32 F3_PRESS = PRESS | NON_ASCII_KEY | 0x03;
	const uint32 F4_PRESS = PRESS | NON_ASCII_KEY | 0x04;
	const uint32 F5_PRESS = PRESS | NON_ASCII_KEY | 0x05;
	const uint32 F6_PRESS = PRESS | NON_ASCII_KEY | 0x06;
	const uint32 F7_PRESS = PRESS | NON_ASCII_KEY | 0x07;
	const uint32 F8_PRESS = PRESS | NON_ASCII_KEY | 0x08;
	const uint32 F9_PRESS = PRESS | NON_ASCII_KEY | 0x09;
	const uint32 F10_PRESS = PRESS | NON_ASCII_KEY | 0x0a;
	const uint32 F11_PRESS = PRESS | NON_ASCII_KEY | 0x0b;
	const uint32 F12_PRESS = PRESS | NON_ASCII_KEY | 0x0c;

	const uint32 F1_RELEASE = RELEASE | NON_ASCII_KEY | 0x01;
	const uint32 F2_RELEASE = RELEASE | NON_ASCII_KEY | 0x02;
	const uint32 F3_RELEASE = RELEASE | NON_ASCII_KEY | 0x03;
	const uint32 F4_RELEASE = RELEASE | NON_ASCII_KEY | 0x04;
	const uint32 F5_RELEASE = RELEASE | NON_ASCII_KEY | 0x05;
	const uint32 F6_RELEASE = RELEASE | NON_ASCII_KEY | 0x06;
	const uint32 F7_RELEASE = RELEASE | NON_ASCII_KEY | 0x07;
	const uint32 F8_RELEASE = RELEASE | NON_ASCII_KEY | 0x08;
	const uint32 F9_RELEASE = RELEASE | NON_ASCII_KEY | 0x09;
	const uint32 F10_RELEASE = RELEASE | NON_ASCII_KEY | 0x0a;
	const uint32 F11_RELEASE = RELEASE | NON_ASCII_KEY | 0x0b;
	const uint32 F12_RELEASE = RELEASE | NON_ASCII_KEY | 0x0c;

	const uint32 ESCAPE_PRESS = PRESS | NON_ASCII_KEY | 0x0d;
	const uint32 ESCAPE_RELEASE = RELEASE | NON_ASCII_KEY | 0x0d;

	const uint32 LEFT_ALT_PRESS = PRESS | NON_ASCII_KEY | 0x10;
	const uint32 LEFT_SHIFT_PRESS = PRESS | NON_ASCII_KEY | 0x11;
	const uint32 LEFT_CONTROL_PRESS = PRESS | NON_ASCII_KEY | 0x12;
	const uint32 LEFT_ALT_RELEASE = RELEASE | NON_ASCII_KEY | 0x10;
	const uint32 LEFT_SHIFT_RELEASE = RELEASE | NON_ASCII_KEY | 0x11;
	const uint32 LEFT_CONTROL_RELEASE = RELEASE | NON_ASCII_KEY | 0x12;

	const uint32 RIGHT_SHIFT_PRESS = PRESS | NON_ASCII_KEY | 0x13;
	const uint32 RIGHT_ALT_PRESS = PRESS | NON_ASCII_KEY | 0x14;
	const uint32 RIGHT_CONTROL_PRESS = PRESS | NON_ASCII_KEY | 0x15;
	const uint32 RIGHT_SHIFT_RELEASE = RELEASE | NON_ASCII_KEY | 0x13;
	const uint32 RIGHT_ALT_RELEASE = RELEASE | NON_ASCII_KEY | 0x14;
	const uint32 RIGHT_CONTROL_RELEASE = RELEASE | NON_ASCII_KEY | 0x15;

	const uint32 CURSOR_UP_PRESS = PRESS | NON_ASCII_KEY | 0x21;
	const uint32 CURSOR_DOWN_PRESS = PRESS | NON_ASCII_KEY | 0x22;
	const uint32 CURSOR_LEFT_PRESS = PRESS | NON_ASCII_KEY | 0x23;
	const uint32 CURSOR_RIGHT_PRESS = PRESS | NON_ASCII_KEY | 0x23;
	const uint32 CURSOR_UP_RELEASE = RELEASE | NON_ASCII_KEY | 0x21;
	const uint32 CURSOR_DOWN_RELEASE = RELEASE | NON_ASCII_KEY | 0x22;
	const uint32 CURSOR_LEFT_RELEASE = RELEASE | NON_ASCII_KEY | 0x23;
	const uint32 CURSOR_RIGHT_RELEASE = RELEASE | NON_ASCII_KEY | 0x24;

	const uint32 POWER_PRESS = PRESS | NON_ASCII_KEY | 0x31;
	const uint32 SLEEP_PRESS = PRESS | NON_ASCII_KEY | 0x32;
	const uint32 WAKE_PRESS = PRESS | NON_ASCII_KEY | 0x33;
	const uint32 POWER_RELEASE = RELEASE | NON_ASCII_KEY | 0x31;
	const uint32 SLEEP_RELEASE = RELEASE | NON_ASCII_KEY | 0x32;
	const uint32 WAKE_RELEASE = RELEASE | NON_ASCII_KEY | 0x33;

	const uint32 PAUSE_PRESS = PRESS | RELEASE | NON_ASCII_KEY | 0xff; 
	const uint32 PRINT_SCREEN_RELEASE = RELEASE | NON_ASCII_KEY | 0xfe;
	const uint32 PRINT_SCREEN_PRESS = PRESS | NON_ASCII_KEY | 0xfe;

	const uint32 CAPS_LOCK_PRESS = PRESS | NON_ASCII_KEY | 0xe1;
	const uint32 NUMBER_LOCK_PRESS = PRESS | NON_ASCII_KEY | 0xe2;
	const uint32 SCROLL_LOCK_PRESS = PRESS | NON_ASCII_KEY | 0xe3;
	const uint32 CAPS_LOCK_RELEASE = RELEASE | NON_ASCII_KEY | 0xe1;
	const uint32 NUMBER_LOCK_RELEASE = RELEASE | NON_ASCII_KEY | 0xe2;
	const uint32 SCROLL_LOCK_RELEASE = RELEASE | NON_ASCII_KEY | 0xe3;

	const uint32 END_PRESS = PRESS | NON_ASCII_KEY | 0xd1;
	const uint32 HOME_PRESS = PRESS | NON_ASCII_KEY | 0xd2;
	const uint32 DELETE_PRESS = PRESS | NON_ASCII_KEY | 0xd3;
	const uint32 INSERT_PRESS = PRESS | NON_ASCII_KEY | 0xd4;
	const uint32 PAGE_DOWN_PRESS = PRESS | NON_ASCII_KEY | 0xd5;
	const uint32 PAGE_UP_PRESS = PRESS | NON_ASCII_KEY | 0xd6;
	const uint32 END_RELEASE = RELEASE | NON_ASCII_KEY | 0xd1;
	const uint32 HOME_RELEASE = RELEASE | NON_ASCII_KEY | 0xd2;
	const uint32 DELETE_RELEASE = RELEASE | NON_ASCII_KEY | 0xd3;
	const uint32 INSERT_RELEASE = RELEASE | NON_ASCII_KEY | 0xd4;
	const uint32 PAGE_UP_RELEASE = RELEASE | NON_ASCII_KEY | 0xd5;
	const uint32 PAGE_DOWN_RELEASE = RELEASE | NON_ASCII_KEY | 0xd6;
	
	const uint32 LEFT_WINDOWS_KEY_PRESS = PRESS | NON_ASCII_KEY | 0xc1;
	const uint32 RIGHT_WINDOWS_KEY_PRESS = PRESS | NON_ASCII_KEY | 0xc2;
	const uint32 APPS_PRESS = PRESS | NON_ASCII_KEY | 0xc3;
	const uint32 LEFT_WINDOWS_KEY_RELEASE = RELEASE | NON_ASCII_KEY | 0xc1;
	const uint32 RIGHT_WINDOWS_KEY_RELEASE = RELEASE | NON_ASCII_KEY | 0xc2;
	const uint32 APPS_RELEASE = RELEASE | NON_ASCII_KEY | 0xc3;

	bool hasNewKey();
	void ackKey();
	bool checkInit();
	void init();
	void irq (uint8 key);
	uint32 getKey();
	void popKey();
	int keyCount();

	class State {
	public:
		std::vector<std::pair<uint32, std::shared_ptr<State>>> next;

		State () : next(256) {}

		void registerEvent (uint8 event, uint32 ret, std::shared_ptr<State> 
				nextState)
		{
			next[event] = std::pair<uint32, std::shared_ptr<State>>
					(ret, nextState);			
		}

		std::pair<uint32, std::shared_ptr<State>>& getNext (uint8 event) {
			return next[event];
		}
	};

	class KeyState {
	public:
		std::shared_ptr<State> root;
		std::shared_ptr<State> current;

		KeyState() {
			root = std::shared_ptr<State>(new State());
			current = root;
		}

		uint32 doEvent (uint8 event) {
			auto result = current->getNext(event);
			if (result.second)
				current = result.second;
			else
				current = root;
			return result.first;
		}

		void registerEvent (uint8 event, uint32 ret = 0) {
			if (ret == 0) {
				if (!current->next[event].second)
					current->registerEvent(event, ret,
							std::shared_ptr<State>(new State()));
			}
			else 
				current->registerEvent(event, ret, std::shared_ptr<State>());
		}
	};

	void init2KeyState (KeyState&); 
}

#endif