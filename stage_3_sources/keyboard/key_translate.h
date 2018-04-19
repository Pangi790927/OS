#ifndef KEY_TRANSLATE_H
#define KEY_TRANSLATE_H

#include "Types.h"
#include "keyboard.h"

namespace keyboard
{
	class KeyTranslator {
	public:
		bool leftShiftPressed = false;
		bool rightShiftPressed = false;
		bool capsLock = false;
		bool capsLockReleased = false;

		int asciiKeysShift[256];
		int asciiKeysCapsLock[256];

		KeyTranslator() {
			init();
		}

		void init() {
			for (int i = 0; i < 256; i++) {
				asciiKeysShift[i] = -1;
				asciiKeysCapsLock[i] = -1;
			}
			for (int i = 'a'; i <= 'z'; i++) {
				asciiKeysShift[i] = i - 'a' + 'A';
				asciiKeysCapsLock[i] = i - 'a' + 'A';
			}
			asciiKeysShift['1'] = '!';
			asciiKeysShift['2'] = '@';
			asciiKeysShift['3'] = '#';
			asciiKeysShift['4'] = '$';
			asciiKeysShift['5'] = '%';
			asciiKeysShift['6'] = '^';
			asciiKeysShift['7'] = '&';
			asciiKeysShift['8'] = '*';
			asciiKeysShift['9'] = '(';
			asciiKeysShift['0'] = ')';
			asciiKeysShift['-'] = '_';
			asciiKeysShift['='] = '+';
			asciiKeysShift['['] = '{';
			asciiKeysShift[']'] = '}';
			asciiKeysShift['\\'] = '|';
			asciiKeysShift[';'] = ':';
			asciiKeysShift['\''] = '\"';
			asciiKeysShift[','] = '<';
			asciiKeysShift['.'] = '>';
			asciiKeysShift['/'] = '?';
			asciiKeysShift['`'] = '~';
		}

		char translate (uint32 key) {
			if (key == LEFT_SHIFT_PRESS)
				leftShiftPressed = true;
			if (key == LEFT_SHIFT_RELEASE)
				leftShiftPressed = false;

			if (key == RIGHT_SHIFT_PRESS)
				rightShiftPressed = true;
			if (key == RIGHT_SHIFT_RELEASE)
				rightShiftPressed = false;
			
			if (key == CAPS_LOCK_PRESS && capsLockReleased == false)
				capsLock = true;
			if (key == CAPS_LOCK_PRESS && capsLockReleased == true)
				capsLock = false;

			if (key == CAPS_LOCK_RELEASE)
				capsLockReleased = !capsLockReleased;

			if (!(key & NON_ASCII_KEY)) {
				uint8 res = key;

				if (leftShiftPressed || rightShiftPressed) {
					if (asciiKeysShift[res] != -1) {
						return asciiKeysShift[res];
					}
				}
				else if (capsLock) {
					if (asciiKeysCapsLock[res] != -1) {
						return asciiKeysCapsLock[res];
					}
				}
				return res;
			}
			return 0;
		}
	};
}

#endif