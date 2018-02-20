#include "keyboard.h"
#include "irq.h"
#include "stdio.h"
#include "c_asm_func.h"

const int queue_max = 256;

int queue_left = 0;
int queue_right = 0;
int queue[queue_max];

bool keyboard_empty() {
	return queue_left == queue_right;
}

int keyboard_peak_last() {
	if (queue_right != queue_left) 
		return queue[queue_right - 1];
	else
		return -1;
}

void keyboard_pop_last() {
	if (keyboard_empty())
		return ;
	
	queue_left--;
	queue_left %= queue_max;
}

int keyboard_pop() {
	if (keyboard_empty())
		return -1;

	int val = queue[queue_left++];
	queue_left %= queue_max;
	return val;
}

void keyboard_push(int val) {
	queue[queue_right++] = val;
	queue_right %= queue_max;

	if (queue_right == queue_left) {
		queue_left++;
		queue_left %= queue_max;
	}
}

void keyboard_callback (registers_irq& regs) {
	keyboard_push(port_byte_in(KEYBOARD_ADDR));
	
	// printf("KEY1: %x \n", keyboard_peak_last());
}

bool keyboard_send_byte (u_int_8 byte) {
	int i = 20;
	while (i--) {
		if (!(port_byte_in(KEYBOARD_AVAILABLE_ADDR) & 0x02)) {
			port_byte_out(KEYBOARD_ADDR, byte);
			return true;
		}
	}
	return false;
}

bool keyboard_recv_byte (u_int_8 &byte) {
	int i = 20;
	while (i--) {
		if (!(port_byte_in(KEYBOARD_AVAILABLE_ADDR) & 0x01)) {
			byte = port_byte_in(KEYBOARD_ADDR);
			return true;
		}
	}
	return false;
}

bool recv_ack() {
	int i = 10;
	while (i--) {
		if (keyboard_peak_last() == KEYBOARD_ACK) {
			keyboard_pop_last();
			return true;
		}
	}
	return false;
}

bool send_byte_with_ack(u_int_8 byte) {
	int retry = 3;
	while (retry) {
		if (!keyboard_send_byte(byte))
			return false;

		if (!recv_ack()) {
			retry--;
			printf(" . err . . .\n");
		}
		else 
			return true;
	}
}

bool enable_scanning() {
	return send_byte_with_ack(KEYBOARD_ENABLE_SCANNING);
}

bool set_scan_code(u_int_8 scan_code) {
	int retry = 3;
	while (retry) {
		if (!keyboard_send_byte(KEYBOARD_SCAN_COMM))
			return false;

		if (!keyboard_send_byte(scan_code))
			return false;

		if (!recv_ack()) {
			retry--;
			printf(" . err . . .\n");
		}
		else 
			return true;
	}
	return false;
}

void init_keyboard () {
	register_callback(KEYBOARD_IRQ, &keyboard_callback);

	// if (!enable_scanning())
	// 	printf("Failed to enable scanning ... \n");

	if (!set_scan_code(KEYBOARD_SET_SCAN_2))
		printf("Failed to change scan code ... \n");
}

char keyboard_to_ASCII (int code) {
	switch (code) {
		case Key_0: return '0';
		case Key_1: return '1';
		case Key_2: return '2';
		case Key_3: return '3';
		case Key_4: return '4';
		case Key_5: return '5';
		case Key_6: return '6';
		case Key_7: return '7';
		case Key_8: return '8';
		case Key_9: return '9';

		case Key_RELEASE: return '_';
		
		default: return '?';
	}
}


// not implemented yet
// 0xE0, 0x10 	(multimedia) WWW search pressed 	
// 0xE0, 0x11 	right alt pressed 				
// 0xE0, 0x14 	right control pressed 	
// 0xE0, 0x15 	(multimedia) previous track pressed 				
// 0xE0, 0x18 	(multimedia) WWW favourites pressed 						
// 0xE0, 0x1F 	left GUI pressed
// 0xE0, 0x20 	(multimedia) WWW refresh pressed 	
// 0xE0, 0x21 	(multimedia) volume down pressed 			
// 0xE0, 0x23 	(multimedia) mute pressed
// 0xE0, 0x27 	right GUI pressed
// 0xE0, 0x28 	(multimedia) WWW stop pressed 					
// 0xE0, 0x2B 	(multimedia) calculator pressed
// 0xE0, 0x2F 	apps pressed
// 0xE0, 0x30 	(multimedia) WWW forward pressed 			
// 0xE0, 0x32 	(multimedia) volume up pressed 		
// 0xE0, 0x34 	(multimedia) play/pause pressed 					
// 0xE0, 0x37 	(ACPI) power pressed
// 0xE0, 0x38 	(multimedia) WWW back pressed 			
// 0xE0, 0x3A 	(multimedia) WWW home pressed 	
// 0xE0, 0x3B 	(multimedia) stop pressed
// 0xE0, 0x3F 	(ACPI) sleep pressed
// 0xE0, 0x40 	(multimedia) my computer pressed 						
// 0xE0, 0x48 	(multimedia) email pressed 			
// 0xE0, 0x4A 	(keypad) / pressed 		
// 0xE0, 0x4D 	(multimedia) next track pressed 				
// 0xE0, 0x50 	(multimedia) media select pressed 						
// 0xE0, 0x5A 	(keypad) enter pressed 		
// 0xE0, 0x5E 	(ACPI) wake pressed 		
// 0xE0, 0x69 	end pressed 			
// 0xE0, 0x6B 	cursor left pressed
// 0xE0, 0x6C 	home pressed 						
// 0xE0, 0x70 	insert pressed 	
// 0xE0, 0x71 	delete pressed 	
// 0xE0, 0x72 	cursor down pressed 		
// 0xE0, 0x74 	cursor right pressed 	
// 0xE0, 0x75 	cursor up pressed 				
// 0xE0, 0x7A 	page down pressed 		
// 0xE0, 0x7D 	page up pressed 				
// not implemented yet
// 0xE0, 0x12, 0xE0, 0x7C 	print screen pressed 						
// 0xE0, 0xF0, 0x10 	(multimedia) WWW search released 	
// 0xE0, 0xF0, 0x11 	right alt released 				
// 0xE0, 0xF0, 0x14 	right control released 	
// 0xE0, 0xF0, 0x15 	(multimedia) previous track released 				
// 0xE0, 0xF0, 0x18 	(multimedia) WWW favourites released 						
// 0xE0, 0xF0, 0x1F 	left GUI released
// 0xE0, 0xF0, 0x20 	(multimedia) WWW refresh released 	
// 0xE0, 0xF0, 0x21 	(multimedia) volume down released 			
// 0xE0, 0xF0, 0x23 	(multimedia) mute released
// 0xE0, 0xF0, 0x27 	right GUI released
// 0xE0, 0xF0, 0x28 	(multimedia) WWW stop released 					
// 0xE0, 0xF0, 0x2B 	(multimedia) calculator released
// 0xE0, 0xF0, 0x2F 	apps released
// 0xE0, 0xF0, 0x30 	(multimedia) WWW forward released 			
// 0xE0, 0xF0, 0x32 	(multimedia) volume up released 		
// 0xE0, 0xF0, 0x34 	(multimedia) play/pause released 					
// 0xE0, 0xF0, 0x37 	(ACPI) power released
// 0xE0, 0xF0, 0x38 	(multimedia) WWW back released 			
// 0xE0, 0xF0, 0x3A 	(multimedia) WWW home released 	
// 0xE0, 0xF0, 0x3B 	(multimedia) stop released
// 0xE0, 0xF0, 0x3F 	(ACPI) sleep released
// 0xE0, 0xF0, 0x40 	(multimedia) my computer released 						
// 0xE0, 0xF0, 0x48 	(multimedia) email released 			
// 0xE0, 0xF0, 0x4A 	(keypad) / released 		
// 0xE0, 0xF0, 0x4D 	(multimedia) next track released 				
// 0xE0, 0xF0, 0x50 	(multimedia) media select released 						
// 0xE0, 0xF0, 0x5A 	(keypad) enter released 		
// 0xE0, 0xF0, 0x5E 	(ACPI) wake released 		
// 0xE0, 0xF0, 0x69 	end released 			
// 0xE0, 0xF0, 0x6B 	cursor left released
// 0xE0, 0xF0, 0x6C 	home released 						
// 0xE0, 0xF0, 0x70 	insert released 	
// 0xE0, 0xF0, 0x71 	delete released 	
// 0xE0, 0xF0, 0x72 	cursor down released 		
// 0xE0, 0xF0, 0x74 	cursor right released 	
// 0xE0, 0xF0, 0x75 	cursor up released 				
// 0xE0, 0xF0, 0x7A 	page down released 		
// 0xE0, 0xF0, 0x7D 	page up released 				
// 0xE0, 0xF0, 0x7C, 0xE0, 0xF0, 0x12 	print screen released 		
// 0xE1, 0x14, 0x77, 0xE1, 0xF0, 0x14, 0xF0, 0x77 	pause pressed

/*
0x01 	F9 pressed 			
0x03 	F5 pressed
0x04 	F3 pressed 	
0x05 	F1 pressed 	
0x06 	F2 pressed 	
0x07 	F12 pressed 
0x09 	F10 pressed 	
0x0A 	F8 pressed 	
0x0B 	F6 pressed
0x0C 	F4 pressed 	
0x0D 	tab pressed 	
0x0E 	` (back tick) pressed 		
0x11 	left alt pressed 
0x12 	left shift pressed 		
0x14 	left control pressed 	
0x15 	Q pressed 	
0x16 	1 pressed 		
0x1A 	Z pressed 	
0x1B 	S pressed
0x1C 	A pressed 	
0x1D 	W pressed 	
0x1E 	2 pressed 		
0x21 	C pressed 	
0x22 	X pressed 	
0x23 	D pressed
0x24 	E pressed 	
0x25 	4 pressed 	
0x26 	3 pressed 		
0x29 	space pressed 	
0x2A 	V pressed 	
0x2B 	F pressed
0x2C 	T pressed 	
0x2D 	R pressed 	
0x2E 	5 pressed 		
0x31 	N pressed 	
0x32 	B pressed 	
0x33 	H pressed
0x34 	G pressed 	
0x35 	Y pressed 	
0x36 	6 pressed 		
0x3A 	M pressed 	
0x3B 	J pressed
0x3C 	U pressed 	
0x3D 	7 pressed 	
0x3E 	8 pressed 		
0x41 	, pressed 	
0x42 	K pressed 	
0x43 	I pressed
0x44 	O pressed 	
0x45 	0 (zero) pressed 	
0x46 	9 pressed 		
0x49 	. pressed 	
0x4A 	/ pressed 	
0x4B 	L pressed
0x4C 	 ; pressed 	
0x4D 	P pressed 	
0x4E 	- pressed 		
0x52 	' pressed 		'
0x54 	[ pressed 	
0x55 	= pressed 				
0x58 	CapsLock pressed 	
0x59 	right shift pressed 	
0x5A 	enter pressed 	
0x5B 	] pressed
0x5D 	\ pressed 				
0x66 	backspace pressed 		
0x69 	(keypad) 1 pressed 			
0x6B 	(keypad) 4 pressed
0x6C 	(keypad) 7 pressed 						
0x70 	(keypad) 0 pressed 	
0x71 	(keypad) . pressed 	
0x72 	(keypad) 2 pressed 	
0x73 	(keypad) 5 pressed
0x74 	(keypad) 6 pressed 	
0x75 	(keypad) 8 pressed 	
0x76 	escape pressed 	
0x77 	NumberLock pressed
0x78 	F11 pressed 	
0x79 	(keypad) + pressed 	
0x7A 	(keypad) 3 pressed 	
0x7B 	(keypad) - pressed
0x7C 	(keypad) * pressed 	
0x7D 	(keypad) 9 pressed 	
0x7E 	ScrollLock pressed 		
0x83 	F7 pressed
0xE0, 0x10 	(multimedia) WWW search pressed 	
0xE0, 0x11 	right alt pressed 				
0xE0, 0x14 	right control pressed 	
0xE0, 0x15 	(multimedia) previous track pressed 				
0xE0, 0x18 	(multimedia) WWW favourites pressed 						
0xE0, 0x1F 	left GUI pressed
0xE0, 0x20 	(multimedia) WWW refresh pressed 	
0xE0, 0x21 	(multimedia) volume down pressed 			
0xE0, 0x23 	(multimedia) mute pressed
0xE0, 0x27 	right GUI pressed
0xE0, 0x28 	(multimedia) WWW stop pressed 					
0xE0, 0x2B 	(multimedia) calculator pressed
0xE0, 0x2F 	apps pressed
0xE0, 0x30 	(multimedia) WWW forward pressed 			
0xE0, 0x32 	(multimedia) volume up pressed 		
0xE0, 0x34 	(multimedia) play/pause pressed 					
0xE0, 0x37 	(ACPI) power pressed
0xE0, 0x38 	(multimedia) WWW back pressed 			
0xE0, 0x3A 	(multimedia) WWW home pressed 	
0xE0, 0x3B 	(multimedia) stop pressed
0xE0, 0x3F 	(ACPI) sleep pressed
0xE0, 0x40 	(multimedia) my computer pressed 						
0xE0, 0x48 	(multimedia) email pressed 			
0xE0, 0x4A 	(keypad) / pressed 		
0xE0, 0x4D 	(multimedia) next track pressed 				
0xE0, 0x50 	(multimedia) media select pressed 						
0xE0, 0x5A 	(keypad) enter pressed 		
0xE0, 0x5E 	(ACPI) wake pressed 		
0xE0, 0x69 	end pressed 			
0xE0, 0x6B 	cursor left pressed
0xE0, 0x6C 	home pressed 						
0xE0, 0x70 	insert pressed 	
0xE0, 0x71 	delete pressed 	
0xE0, 0x72 	cursor down pressed 		
0xE0, 0x74 	cursor right pressed 	
0xE0, 0x75 	cursor up pressed 				
0xE0, 0x7A 	page down pressed 		
0xE0, 0x7D 	page up pressed 				
0xF0, 0x01 	F9 released 			
0xF0, 0x03 	F5 released
0xF0, 0x04 	F3 released 	
0xF0, 0x05 	F1 released 	
0xF0, 0x06 	F2 released 	
0xF0, 0x07 	F12 released
0xF0, 0x09 	F10 released 	
0xF0, 0x0A 	F8 released 	
0xF0, 0x0B 	F6 released
0xF0, 0x0C 	F4 released 	
0xF0, 0x0D 	tab released 	
0xF0, 0x0E 	` (back tick) released 		
0xF0, 0x11 	left alt released 	
0xF0, 0x12 	left shift released 		
0xF0, 0x14 	left control released 	
0xF0, 0x15 	Q released 	
0xF0, 0x16 	1 released 		
0xF0, 0x1A 	Z released 	
0xF0, 0x1B 	S released
0xF0, 0x1C 	A released 	
0xF0, 0x1D 	W released 	
0xF0, 0x1E 	2 released 		
0xF0, 0x21 	C released 
0xF0, 0x22 	X released 	
0xF0, 0x23 	D released
0xF0, 0x24 	E released 	
0xF0, 0x25 	4 released 	
0xF0, 0x26 	3 released 		
0xF0, 0x29 	space released 	
0xF0, 0x2A 	V released 	
0xF0, 0x2B 	F released
0xF0, 0x2C 	T released 	
0xF0, 0x2D 	R released 	
0xF0, 0x2E 	5 released 		
0xF0, 0x31 	N released 	
0xF0, 0x32 	B released 	
0xF0, 0x33 	H released
0xF0, 0x34 	G released 	
0xF0, 0x35 	Y released 	
0xF0, 0x36 	6 released 		
0xF0, 0x3A 	M released 	
0xF0, 0x3B 	J released
0xF0, 0x3C 	U released 
0xF0, 0x3D 	7 released 	
0xF0, 0x3E 	8 released 		
0xF0, 0x41 	, released 	
0xF0, 0x42 	K released 	
0xF0, 0x43 	I released
0xF0, 0x44 	O released 	
0xF0, 0x45 	0 (zero) released 	
0xF0, 0x46 	9 released 		
0xF0, 0x49 	. released 	
0xF0, 0x4A 	/ released 	
0xF0, 0x4B 	L released
0xF0, 0x4C 	 ; released 	
0xF0, 0x4D 	P released 	
0xF0, 0x4E 	- released 		
0xF0, 0x52 	' released 		'
0xF0, 0x54 	[ released 	
0xF0, 0x55 	= released 				
0xF0, 0x58 	CapsLock released 	
0xF0, 0x59 	right shift released 	
0xF0, 0x5A 	enter released 	
0xF0, 0x5B 	] released
0xF0, 0x5D 	\ released 				
0xF0, 0x66 	backspace released 		
0xF0, 0x69 	(keypad) 1 released 			
0xF0, 0x6B 	(keypad) 4 released
0xF0, 0x6C 	(keypad) 7 released 						
0xF0, 0x70 	(keypad) 0 released 	
0xF0, 0x71 	(keypad) . released 	
0xF0, 0x72 	(keypad) 2 released 	
0xF0, 0x73 	(keypad) 5 released
0xF0, 0x74 	(keypad) 6 released 	
0xF0, 0x75 	(keypad) 8 released 	
0xF0, 0x76 	escape released 	
0xF0, 0x77 	NumberLock released
0xF0, 0x78 	F11 released 	
0xF0, 0x79 	(keypad) + released 	
0xF0, 0x7A 	(keypad) 3 released 	
0xF0, 0x7B 	(keypad) - released
0xF0, 0x7C 	(keypad) * released 	
0xF0, 0x7D 	(keypad) 9 released 	
0xF0, 0x7E 	ScrollLock released 		
0xF0, 0x83 	F7 released
0xE0, 0x12, 0xE0, 0x7C 	print screen pressed 						
0xE0, 0xF0, 0x10 	(multimedia) WWW search released 	
0xE0, 0xF0, 0x11 	right alt released 				
0xE0, 0xF0, 0x14 	right control released 	
0xE0, 0xF0, 0x15 	(multimedia) previous track released 				
0xE0, 0xF0, 0x18 	(multimedia) WWW favourites released 						
0xE0, 0xF0, 0x1F 	left GUI released
0xE0, 0xF0, 0x20 	(multimedia) WWW refresh released 	
0xE0, 0xF0, 0x21 	(multimedia) volume down released 			
0xE0, 0xF0, 0x23 	(multimedia) mute released
0xE0, 0xF0, 0x27 	right GUI released
0xE0, 0xF0, 0x28 	(multimedia) WWW stop released 					
0xE0, 0xF0, 0x2B 	(multimedia) calculator released
0xE0, 0xF0, 0x2F 	apps released
0xE0, 0xF0, 0x30 	(multimedia) WWW forward released 			
0xE0, 0xF0, 0x32 	(multimedia) volume up released 		
0xE0, 0xF0, 0x34 	(multimedia) play/pause released 					
0xE0, 0xF0, 0x37 	(ACPI) power released
0xE0, 0xF0, 0x38 	(multimedia) WWW back released 			
0xE0, 0xF0, 0x3A 	(multimedia) WWW home released 	
0xE0, 0xF0, 0x3B 	(multimedia) stop released
0xE0, 0xF0, 0x3F 	(ACPI) sleep released
0xE0, 0xF0, 0x40 	(multimedia) my computer released 						
0xE0, 0xF0, 0x48 	(multimedia) email released 			
0xE0, 0xF0, 0x4A 	(keypad) / released 		
0xE0, 0xF0, 0x4D 	(multimedia) next track released 				
0xE0, 0xF0, 0x50 	(multimedia) media select released 						
0xE0, 0xF0, 0x5A 	(keypad) enter released 		
0xE0, 0xF0, 0x5E 	(ACPI) wake released 		
0xE0, 0xF0, 0x69 	end released 			
0xE0, 0xF0, 0x6B 	cursor left released
0xE0, 0xF0, 0x6C 	home released 						
0xE0, 0xF0, 0x70 	insert released 	
0xE0, 0xF0, 0x71 	delete released 	
0xE0, 0xF0, 0x72 	cursor down released 		
0xE0, 0xF0, 0x74 	cursor right released 	
0xE0, 0xF0, 0x75 	cursor up released 				
0xE0, 0xF0, 0x7A 	page down released 		
0xE0, 0xF0, 0x7D 	page up released 				
0xE0, 0xF0, 0x7C, 0xE0, 0xF0, 0x12 	print screen released 		
0xE1, 0x14, 0x77, 0xE1, 0xF0, 0x14, 0xF0, 0x77 	pause pressed

**/