#include "kstdio.h"
#include "keyboard.h"
#include "c_asm_func.h"

/*
	PrintScreen Does not work, the same case for F7,
	they don't seem to block the console though
*/

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
	outb(DATA_PORT, conf & 0b10111111);
	
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
			kprintf("RESET_FAILED %x\n", response);
			break;
		}
	}
	
	waitCanRead();
	uint8 response = inb(DATA_PORT);

	if (response != SELF_TEST_PASSED) {
		kprintf("SELF_TEST_FAILED %x\n", response);
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
			kprintf("KEYBOARD_SCAN_CODE_FAIL %x\n", response);
			break;
		}
	}

	if (!done)
		kprintf("Keyboard inactive\n");
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

void keyboard::init2KeyState (keyboard::KeyState &keyState) {
	keyState.registerEvent(0x05, F1_PRESS);
	keyState.registerEvent(0x06, F2_PRESS);
	keyState.registerEvent(0x04, F3_PRESS); 
	keyState.registerEvent(0x0C, F4_PRESS);
	keyState.registerEvent(0x03, F5_PRESS);
	keyState.registerEvent(0x0B, F6_PRESS);
	keyState.registerEvent(0x83, F7_PRESS);
	keyState.registerEvent(0x0A, F8_PRESS);
	keyState.registerEvent(0x01, F9_PRESS);
	keyState.registerEvent(0x09, F10_PRESS);
 	
	keyState.registerEvent(0x00, 0);
	keyState.doEvent(0x00);
		keyState.registerEvent(0x78, F11_PRESS);
	keyState.doEvent(0xFF);	// return to root
	
	keyState.registerEvent(0x07, F12_PRESS);

	keyState.registerEvent(0xF0, 0);
	keyState.doEvent(0xF0);
		keyState.registerEvent(0x05, F1_RELEASE);
		keyState.registerEvent(0x06, F2_RELEASE);
		keyState.registerEvent(0x04, F3_RELEASE); 
		keyState.registerEvent(0x0C, F4_RELEASE);
		keyState.registerEvent(0x03, F5_RELEASE);
		keyState.registerEvent(0x0B, F6_RELEASE);
		keyState.registerEvent(0x83, F7_RELEASE);
		keyState.registerEvent(0x0A, F8_RELEASE);
		keyState.registerEvent(0x01, F9_RELEASE);
		keyState.registerEvent(0x09, F10_RELEASE);
		keyState.registerEvent(0x78, F11_RELEASE);
		keyState.registerEvent(0x07, F12_RELEASE);
	keyState.doEvent(0xFF);	// return 

	keyState.registerEvent(0x76, ESCAPE_PRESS);
	keyState.registerEvent(0x11, LEFT_ALT_PRESS);
	keyState.registerEvent(0x12, LEFT_SHIFT_PRESS);
	keyState.registerEvent(0x14, LEFT_CONTROL_PRESS);
	keyState.registerEvent(0x59, RIGHT_SHIFT_PRESS);

	keyState.registerEvent(0xE0, 0);
	keyState.doEvent(0xE0);
		keyState.registerEvent(0x11, RIGHT_ALT_PRESS);		
		keyState.registerEvent(0x14, RIGHT_CONTROL_PRESS);	
		keyState.registerEvent(0x69, END_PRESS);
		keyState.registerEvent(0x6C, HOME_PRESS);			
		keyState.registerEvent(0x71, DELETE_PRESS);
		keyState.registerEvent(0x70, INSERT_PRESS);
		keyState.registerEvent(0x6B, CURSOR_LEFT_PRESS);
		keyState.registerEvent(0x72, CURSOR_DOWN_PRESS);
		keyState.registerEvent(0x74, CURSOR_RIGHT_PRESS);		
		keyState.registerEvent(0x75, CURSOR_UP_PRESS);
		keyState.registerEvent(0x7A, PAGE_DOWN_PRESS);
		keyState.registerEvent(0x7D, PAGE_UP_PRESS);
		keyState.registerEvent(0x1F, LEFT_WINDOWS_KEY_PRESS);
		keyState.registerEvent(0x27, RIGHT_WINDOWS_KEY_PRESS);
		keyState.registerEvent(0x2F, APPS_PRESS);
	keyState.doEvent(0xFF);	// return 

	keyState.registerEvent(0x58, CAPS_LOCK_PRESS);
	keyState.registerEvent(0x77, NUMBER_LOCK_PRESS);
	keyState.registerEvent(0x7E, SCROLL_LOCK_PRESS);
			
	keyState.registerEvent(0xF0, 0);
	keyState.doEvent(0xF0);
		keyState.registerEvent(0x11, LEFT_ALT_RELEASE);
		keyState.registerEvent(0x12, LEFT_SHIFT_RELEASE);
		keyState.registerEvent(0x14, LEFT_CONTROL_RELEASE);
		keyState.registerEvent(0x58, CAPS_LOCK_RELEASE);
		keyState.registerEvent(0x59, RIGHT_SHIFT_RELEASE);
		keyState.registerEvent(0x76, ESCAPE_RELEASE);
		keyState.registerEvent(0x77, NUMBER_LOCK_RELEASE);
		keyState.registerEvent(0x7E, SCROLL_LOCK_RELEASE);
	keyState.doEvent(0xFF);

	keyState.registerEvent(0xE0, 0);
	keyState.doEvent(0xE0);
		keyState.registerEvent(0xF0, 0);
		keyState.doEvent(0xF0);
			keyState.registerEvent(0x11, RIGHT_ALT_RELEASE);		
			keyState.registerEvent(0x14, RIGHT_CONTROL_RELEASE);	
			keyState.registerEvent(0x69, END_RELEASE);
			keyState.registerEvent(0x6C, HOME_RELEASE);			
			keyState.registerEvent(0x71, DELETE_RELEASE);
			keyState.registerEvent(0x70, INSERT_RELEASE);
			keyState.registerEvent(0x6B, CURSOR_LEFT_RELEASE);
			keyState.registerEvent(0x72, CURSOR_DOWN_RELEASE);
			keyState.registerEvent(0x74, CURSOR_RIGHT_RELEASE);		
			keyState.registerEvent(0x75, CURSOR_UP_RELEASE);
			keyState.registerEvent(0x7A, PAGE_DOWN_RELEASE);
			keyState.registerEvent(0x7D, PAGE_UP_RELEASE);
			keyState.registerEvent(0x1F, LEFT_WINDOWS_KEY_RELEASE);
			keyState.registerEvent(0x27, RIGHT_WINDOWS_KEY_RELEASE);
			keyState.registerEvent(0x2F, APPS_RELEASE);
		keyState.doEvent(0xFF);
	keyState.doEvent(0xFF);

	keyState.registerEvent(0xE0, 0);
	keyState.doEvent(0xE0);
		keyState.registerEvent(0x12, 0);
		keyState.doEvent(0x12);
			keyState.registerEvent(0xE0, 0);
			keyState.doEvent(0xE0);
				keyState.registerEvent(0x7C, PRINT_SCREEN_PRESS);
			keyState.doEvent(0xFF);
		keyState.doEvent(0xFF);
	keyState.doEvent(0xFF);

	keyState.registerEvent(0xE0, 0);
	keyState.doEvent(0xE0);
		keyState.registerEvent(0xF0, 0);
		keyState.doEvent(0xF0);
			keyState.registerEvent(0x7C, 0);
			keyState.doEvent(0x7C);
				keyState.registerEvent(0xE0, 0);
				keyState.doEvent(0xE0);
					keyState.registerEvent(0xF0, 0);
					keyState.doEvent(0xF0);
						keyState.registerEvent(0x12, PRINT_SCREEN_RELEASE);
					keyState.doEvent(0xFF);
				keyState.doEvent(0xFF);
			keyState.doEvent(0xFF);
		keyState.doEvent(0xFF);
	keyState.doEvent(0xFF);
				
	keyState.registerEvent(0xE1, 0);
	keyState.doEvent(0xE1);
		keyState.registerEvent(0x14, 0);
		keyState.doEvent(0x14);
			keyState.registerEvent(0x77, 0);
			keyState.doEvent(0x77);
				keyState.registerEvent(0xE1, 0);
				keyState.doEvent(0xE1);
					keyState.registerEvent(0xF0, 0);
					keyState.doEvent(0xF0);
						keyState.registerEvent(0x14, 0);
						keyState.doEvent(0x14);
							keyState.registerEvent(0xF0, 0);
							keyState.doEvent(0xF0);
								keyState.registerEvent(0x77, PAUSE_PRESS);
							keyState.doEvent(0xFF);
						keyState.doEvent(0xFF);
					keyState.doEvent(0xFF);
				keyState.doEvent(0xFF);
			keyState.doEvent(0xFF);
		keyState.doEvent(0xFF);
	keyState.doEvent(0xFF);

	keyState.registerEvent(0x1C, (uint32)'a' | PRESS);
	keyState.registerEvent(0x32, (uint32)'b' | PRESS);
	keyState.registerEvent(0x21, (uint32)'c' | PRESS);
	keyState.registerEvent(0x23, (uint32)'d' | PRESS);
	keyState.registerEvent(0x24, (uint32)'e' | PRESS);
	keyState.registerEvent(0x2B, (uint32)'f' | PRESS);
	keyState.registerEvent(0x34, (uint32)'g' | PRESS);
	keyState.registerEvent(0x33, (uint32)'h' | PRESS);
	keyState.registerEvent(0x43, (uint32)'i' | PRESS);
	keyState.registerEvent(0x3B, (uint32)'j' | PRESS);
	keyState.registerEvent(0x44, (uint32)'o' | PRESS);
	keyState.registerEvent(0x4D, (uint32)'p' | PRESS);
	keyState.registerEvent(0x2D, (uint32)'r' | PRESS);
	keyState.registerEvent(0x1B, (uint32)'s' | PRESS);
	keyState.registerEvent(0x2C, (uint32)'t' | PRESS);
	keyState.registerEvent(0x15, (uint32)'q' | PRESS);
	keyState.registerEvent(0x1D, (uint32)'w' | PRESS);
	keyState.registerEvent(0x2A, (uint32)'v' | PRESS);
	keyState.registerEvent(0x3C, (uint32)'u' | PRESS);
	keyState.registerEvent(0x4B, (uint32)'l' | PRESS);
	keyState.registerEvent(0x42, (uint32)'k' | PRESS);
	keyState.registerEvent(0x3A, (uint32)'m' | PRESS);
	keyState.registerEvent(0x31, (uint32)'n' | PRESS);
	keyState.registerEvent(0x22, (uint32)'x' | PRESS);
	keyState.registerEvent(0x35, (uint32)'y' | PRESS);
	keyState.registerEvent(0x1A, (uint32)'z' | PRESS);
	keyState.registerEvent(0x0E, (uint32)'`' | PRESS);
	keyState.registerEvent(0x41, (uint32)',' | PRESS);
	keyState.registerEvent(0x49, (uint32)'.' | PRESS);
	keyState.registerEvent(0x4A, (uint32)'/' | PRESS);
	keyState.registerEvent(0x4C, (uint32)';' | PRESS);
	keyState.registerEvent(0x4E, (uint32)'-' | PRESS);
	keyState.registerEvent(0x52, (uint32)'\'' | PRESS);
	keyState.registerEvent(0x54, (uint32)'[' | PRESS);
	keyState.registerEvent(0x55, (uint32)'=' | PRESS);
	keyState.registerEvent(0x5B, (uint32)']' | PRESS);
	keyState.registerEvent(0x5D, (uint32)'\\' | PRESS);
	keyState.registerEvent(0x29, (uint32)' ' | PRESS);
	keyState.registerEvent(0x0D, (uint32)'\t' | PRESS);
	keyState.registerEvent(0x5A, (uint32)'\n' | PRESS);
	keyState.registerEvent(0x66, (uint32)'\b' | PRESS);
	keyState.registerEvent(0x45, (uint32)'0' | PRESS);
	keyState.registerEvent(0x16, (uint32)'1' | PRESS);
	keyState.registerEvent(0x1E, (uint32)'2' | PRESS);
	keyState.registerEvent(0x26, (uint32)'3' | PRESS);
	keyState.registerEvent(0x25, (uint32)'4' | PRESS);
	keyState.registerEvent(0x2E, (uint32)'5' | PRESS);
	keyState.registerEvent(0x36, (uint32)'6' | PRESS);
	keyState.registerEvent(0x3D, (uint32)'7' | PRESS);
	keyState.registerEvent(0x3E, (uint32)'8' | PRESS);
	keyState.registerEvent(0x46, (uint32)'9' | PRESS);

	keyState.registerEvent(0xF0, 0);
	keyState.doEvent(0xF0);

		keyState.registerEvent(0x1C, (uint32)'a' | RELEASE);
		keyState.registerEvent(0x32, (uint32)'b' | RELEASE);
		keyState.registerEvent(0x21, (uint32)'c' | RELEASE);
		keyState.registerEvent(0x23, (uint32)'d' | RELEASE);
		keyState.registerEvent(0x24, (uint32)'e' | RELEASE);
		keyState.registerEvent(0x2B, (uint32)'f' | RELEASE);
		keyState.registerEvent(0x34, (uint32)'g' | RELEASE);
		keyState.registerEvent(0x33, (uint32)'h' | RELEASE);
		keyState.registerEvent(0x43, (uint32)'i' | RELEASE);
		keyState.registerEvent(0x3B, (uint32)'j' | RELEASE);
		keyState.registerEvent(0x44, (uint32)'o' | RELEASE);
		keyState.registerEvent(0x4D, (uint32)'p' | RELEASE);
		keyState.registerEvent(0x2D, (uint32)'r' | RELEASE);
		keyState.registerEvent(0x1B, (uint32)'s' | RELEASE);
		keyState.registerEvent(0x2C, (uint32)'t' | RELEASE);
		keyState.registerEvent(0x15, (uint32)'q' | RELEASE);
		keyState.registerEvent(0x1D, (uint32)'w' | RELEASE);
		keyState.registerEvent(0x2A, (uint32)'v' | RELEASE);
		keyState.registerEvent(0x3C, (uint32)'u' | RELEASE);
		keyState.registerEvent(0x4B, (uint32)'l' | RELEASE);
		keyState.registerEvent(0x42, (uint32)'k' | RELEASE);
		keyState.registerEvent(0x3A, (uint32)'m' | RELEASE);
		keyState.registerEvent(0x31, (uint32)'n' | RELEASE);
		keyState.registerEvent(0x22, (uint32)'x' | RELEASE);
		keyState.registerEvent(0x35, (uint32)'y' | RELEASE);
		keyState.registerEvent(0x1A, (uint32)'z' | RELEASE);
		keyState.registerEvent(0x0E, (uint32)'`' | RELEASE);
		keyState.registerEvent(0x41, (uint32)',' | RELEASE);
		keyState.registerEvent(0x49, (uint32)'.' | RELEASE);
		keyState.registerEvent(0x4A, (uint32)'/' | RELEASE);
		keyState.registerEvent(0x4C, (uint32)';' | RELEASE);
		keyState.registerEvent(0x4E, (uint32)'-' | RELEASE);
		keyState.registerEvent(0x52, (uint32)'\'' | RELEASE);
		keyState.registerEvent(0x54, (uint32)'[' | RELEASE);
		keyState.registerEvent(0x55, (uint32)'=' | RELEASE);
		keyState.registerEvent(0x5B, (uint32)']' | RELEASE);
		keyState.registerEvent(0x5D, (uint32)'\\' | RELEASE);
		keyState.registerEvent(0x29, (uint32)' ' | RELEASE);
		keyState.registerEvent(0x0D, (uint32)'\t' | RELEASE);
		keyState.registerEvent(0x5A, (uint32)'\n' | RELEASE);
		keyState.registerEvent(0x66, (uint32)'\b' | RELEASE);
		keyState.registerEvent(0x45, (uint32)'0' | RELEASE);
		keyState.registerEvent(0x16, (uint32)'1' | RELEASE);
		keyState.registerEvent(0x1E, (uint32)'2' | RELEASE);
		keyState.registerEvent(0x26, (uint32)'3' | RELEASE);
		keyState.registerEvent(0x25, (uint32)'4' | RELEASE);
		keyState.registerEvent(0x2E, (uint32)'5' | RELEASE);
		keyState.registerEvent(0x36, (uint32)'6' | RELEASE);
		keyState.registerEvent(0x3D, (uint32)'7' | RELEASE);
		keyState.registerEvent(0x3E, (uint32)'8' | RELEASE);
		keyState.registerEvent(0x46, (uint32)'9' | RELEASE);

	keyState.doEvent(0xFF);

	keyState.registerEvent(0x70, (uint32)'0' | PRESS | NUMPAD);
	keyState.registerEvent(0x69, (uint32)'1' | PRESS | NUMPAD);
	keyState.registerEvent(0x72, (uint32)'2' | PRESS | NUMPAD);
	keyState.registerEvent(0x7A, (uint32)'3' | PRESS | NUMPAD);
	keyState.registerEvent(0x6B, (uint32)'4' | PRESS | NUMPAD);
	keyState.registerEvent(0x73, (uint32)'5' | PRESS | NUMPAD);
	keyState.registerEvent(0x74, (uint32)'6' | PRESS | NUMPAD);
	keyState.registerEvent(0x6C, (uint32)'7' | PRESS | NUMPAD);
	keyState.registerEvent(0x75, (uint32)'8' | PRESS | NUMPAD);
	keyState.registerEvent(0x7D, (uint32)'9' | PRESS | NUMPAD);
	keyState.registerEvent(0x79, (uint32)'+' | PRESS | NUMPAD);
	keyState.registerEvent(0x7B, (uint32)'-' | PRESS | NUMPAD);
	keyState.registerEvent(0x7C, (uint32)'*' | PRESS | NUMPAD);
	keyState.registerEvent(0x71, (uint32)'.' | PRESS | NUMPAD);

	keyState.registerEvent(0xE0, 0);
	keyState.doEvent(0xE0);
		keyState.registerEvent(0x4A, (uint32)'/' | PRESS | NUMPAD);
		keyState.registerEvent(0x5A, (uint32)'\n' | PRESS | NUMPAD);
	keyState.doEvent(0xFF);

	keyState.registerEvent(0xF0, 0);
	keyState.doEvent(0xF0);

	keyState.registerEvent(0x70, (uint32)'0' | RELEASE | NUMPAD);
	keyState.registerEvent(0x69, (uint32)'1' | RELEASE | NUMPAD);
	keyState.registerEvent(0x72, (uint32)'2' | RELEASE | NUMPAD);
	keyState.registerEvent(0x7A, (uint32)'3' | RELEASE | NUMPAD);
	keyState.registerEvent(0x6B, (uint32)'4' | RELEASE | NUMPAD);
	keyState.registerEvent(0x73, (uint32)'5' | RELEASE | NUMPAD);
	keyState.registerEvent(0x74, (uint32)'6' | RELEASE | NUMPAD);
	keyState.registerEvent(0x6C, (uint32)'7' | RELEASE | NUMPAD);
	keyState.registerEvent(0x75, (uint32)'8' | RELEASE | NUMPAD);
	keyState.registerEvent(0x7D, (uint32)'9' | RELEASE | NUMPAD);
	keyState.registerEvent(0x79, (uint32)'+' | RELEASE | NUMPAD);
	keyState.registerEvent(0x7B, (uint32)'-' | RELEASE | NUMPAD);
	keyState.registerEvent(0x7C, (uint32)'*' | RELEASE | NUMPAD);
	keyState.registerEvent(0x71, (uint32)'.' | RELEASE | NUMPAD);

	keyState.doEvent(0xFF);

	keyState.registerEvent(0xE0, 0);
	keyState.doEvent(0xE0);

		keyState.registerEvent(0xF0, 0);
		keyState.doEvent(0xF0);

			keyState.registerEvent(0x4A, (uint32)'/' | RELEASE | NUMPAD);
			keyState.registerEvent(0x5A, (uint32)'\n' | RELEASE | NUMPAD);

			keyState.registerEvent(0x37, POWER_RELEASE);
			keyState.registerEvent(0x3F, SLEEP_RELEASE);
			keyState.registerEvent(0x5E, WAKE_RELEASE);

			keyState.registerEvent(0x10, NOT_USED_KEY); 		
			// 0xE0, 0xF0, 0x10 	(multimedia) WWW search released
			keyState.registerEvent(0x15, NOT_USED_KEY); 	
			// 0xE0, 0xF0, 0x15 	(multimedia) previous track released
			keyState.registerEvent(0x18, NOT_USED_KEY); 				
			// 0xE0, 0xF0, 0x18 	(multimedia) WWW favourites released 						
			keyState.registerEvent(0x20, NOT_USED_KEY);
			// 0xE0, 0xF0, 0x20 	(multimedia) WWW refresh released 	
			keyState.registerEvent(0x21, NOT_USED_KEY);
			// 0xE0, 0xF0, 0x21 	(multimedia) volume down released
			keyState.registerEvent(0x23, NOT_USED_KEY); 			
			// 0xE0, 0xF0, 0x23 	(multimedia) mute released
			keyState.registerEvent(0x28, NOT_USED_KEY);
			// 0xE0, 0xF0, 0x28 	(multimedia) WWW stop released 				
			keyState.registerEvent(0x2B, NOT_USED_KEY);	
			// 0xE0, 0xF0, 0x2B 	(multimedia) calculator released
			keyState.registerEvent(0x30, NOT_USED_KEY);
			// 0xE0, 0xF0, 0x30 	(multimedia) WWW forward released 			
			keyState.registerEvent(0x32, NOT_USED_KEY);
			// 0xE0, 0xF0, 0x32 	(multimedia) volume up released
			keyState.registerEvent(0x34, NOT_USED_KEY); 		
			// 0xE0, 0xF0, 0x34 	(multimedia) play/pause released
			keyState.registerEvent(0x38, NOT_USED_KEY); 					
			// 0xE0, 0xF0, 0x38 	(multimedia) WWW back released
			keyState.registerEvent(0x3A, NOT_USED_KEY); 			
			// 0xE0, 0xF0, 0x3A 	(multimedia) WWW home released
			keyState.registerEvent(0x3B, NOT_USED_KEY); 	
			// 0xE0, 0xF0, 0x3B 	(multimedia) stop released
			keyState.registerEvent(0x40, NOT_USED_KEY);
			// 0xE0, 0xF0, 0x40 	(multimedia) my computer released
			keyState.registerEvent(0x48, NOT_USED_KEY); 						
			// 0xE0, 0xF0, 0x48 	(multimedia) email released 	
			keyState.registerEvent(0x4D, NOT_USED_KEY);		
			// 0xE0, 0xF0, 0x4D 	(multimedia) next track released
			keyState.registerEvent(0x50, NOT_USED_KEY); 				
			// 0xE0, 0xF0, 0x50 	(multimedia) media select released

		keyState.doEvent(0xFF);
	keyState.doEvent(0xFF);

	keyState.registerEvent(0xE0, 0);
	keyState.doEvent(0xE0);

		keyState.registerEvent(0x37, POWER_PRESS);
		keyState.registerEvent(0x3F, SLEEP_PRESS);
		keyState.registerEvent(0x5E, WAKE_PRESS);

		keyState.registerEvent(0x10, NOT_USED_KEY);
		// 0xE0, 0x10 			(multimedia) WWW search pressed
		keyState.registerEvent(0x15, NOT_USED_KEY); 	
		// 0xE0, 0x15 			(multimedia) previous track pressed
		keyState.registerEvent(0x18, NOT_USED_KEY); 				
		// 0xE0, 0x18 			(multimedia) WWW favourites pressed
		keyState.registerEvent(0x20, NOT_USED_KEY); 						
		// 0xE0, 0x20 			(multimedia) WWW refresh pressed 
		keyState.registerEvent(0x21, NOT_USED_KEY);	
		// 0xE0, 0x21 			(multimedia) volume down pressed
		keyState.registerEvent(0x23, NOT_USED_KEY); 			
		// 0xE0, 0x23 			(multimedia) mute pressed
		keyState.registerEvent(0x28, NOT_USED_KEY);
		// 0xE0, 0x28 			(multimedia) WWW stop pressed
		keyState.registerEvent(0x2B, NOT_USED_KEY); 					
		// 0xE0, 0x2B 			(multimedia) calculator pressed
		keyState.registerEvent(0x30, NOT_USED_KEY);
		// 0xE0, 0x30 			(multimedia) WWW forward pressed
		keyState.registerEvent(0x32, NOT_USED_KEY); 			
		// 0xE0, 0x32 			(multimedia) volume up pressed
		keyState.registerEvent(0x34, NOT_USED_KEY); 		
		// 0xE0, 0x34 			(multimedia) play/pause pressed
		keyState.registerEvent(0x38, NOT_USED_KEY); 					
		// 0xE0, 0x38 			(multimedia) WWW back pressed
		keyState.registerEvent(0x3A, NOT_USED_KEY); 			
		// 0xE0, 0x3A 			(multimedia) WWW home pressed
		keyState.registerEvent(0x3B, NOT_USED_KEY); 	
		// 0xE0, 0x3B 			(multimedia) stop pressed
		keyState.registerEvent(0x40, NOT_USED_KEY);
		// 0xE0, 0x40 			(multimedia) my computer pressed
		keyState.registerEvent(0x48, NOT_USED_KEY); 						
		// 0xE0, 0x48 			(multimedia) email pressed
		keyState.registerEvent(0x4D, NOT_USED_KEY); 			
		// 0xE0, 0x4D 			(multimedia) next track pressed
		keyState.registerEvent(0x50, NOT_USED_KEY); 				
		// 0xE0, 0x50 			(multimedia) media select pressed 	

	keyState.doEvent(0xFF);
}
