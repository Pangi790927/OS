#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "irq.h"

const int KEYBOARD_IRQ = 1;
const int IRQ1 = KEYBOARD_IRQ;

const int KEYBOARD_ADDR = 0x60;
const int KEYBOARD_AVAILABLE_ADDR = 0x64;

const int KEYBOARD_SCAN_COMM = 0xF0;
const int KEYBOARD_SET_SCAN_2 = 2;
const int KEYBOARD_ACK = 0xFA;
const int KEYBOARD_RESEND = 0xFE;
const int KEYBOARD_ENABLE_SCANNING = 0xF4;

void keyboard_callback (registers_irq& regs);
void init_keyboard ();
bool keyboard_empty();
int keyboard_peak_last();
int keyboard_pop();
void keyboard_push (int val);
char keyboard_to_ASCII (int code);

#define Key_RELEASE 		0xF0

#define Key_F1				0x05
#define Key_F2				0x06
#define Key_F3				0x04
#define Key_F4				0x0c
#define Key_F5 				0x03
#define Key_F6				0x0b
#define Key_F7				0x83 	
#define Key_F8				0x0a
#define Key_F9 				0x01
#define Key_F10				0x09
#define Key_F11				0x78 	
#define Key_F12				0x07

#define Key_LEFT_ALT		0x11
#define Key_LEFT_CTRL		0x14
#define Key_LEFT_SHIFT		0x12
#define Key_RIGHT_SHIFT		0x59 	


#define Key_BACKSPACE		0x66 	
#define Key_SPACE			0x29 
#define Key_ENTER			0x5A 	
#define Key_TAB				0x0d
#define Key_ESCAPE			0x76 	// does not have release counterpart

#define Key_CAPSLOCK		0x58 	
#define Key_SCROLL			0x7E 	
#define Key_NUMLOCK			0x77 	

#define Key_COMMA			0x41 	
#define Key_BACK_TICK		0x0e
#define Key_FULL_STOP		0x49 	
#define Key_SLASH			0x4A 	
#define Key_MINUS			0x4E 	
#define Key_QUOTE			0x52 	
#define Key_BRACK_OPPEN		0x54 	
#define Key_EQUAL			0x55 	
#define Key_BRACK_CLOSE		0x5B 	
#define Key_BACKSLASH		0x5D 	
#define Key_SEMICOLON		0x4C 	

#define Key_NUM_STOP		0x71 	
#define Key_NUM_PLUS		0x79 	
#define Key_NUM_MINUS		0x7B 	
#define Key_NUM_MUL			0x7C 	

#define Key_1				0x16
#define Key_2				0x1E
#define Key_3				0x26 
#define Key_4				0x25 
#define Key_5				0x2E 
#define Key_6				0x36 
#define Key_7				0x3D 
#define Key_8				0x3E 	
#define Key_9				0x46 
#define Key_0				0x45 	

#define Key_A				0x1C
#define Key_B				0x32 
#define Key_C				0x21
#define Key_D 				0x23 
#define Key_E				0x24 
#define Key_F				0x2B 
#define Key_G				0x34 
#define Key_H				0x33 
#define Key_I				0x43 
#define Key_J				0x3B 
#define Key_K				0x42 
#define Key_L				0x4B 	
#define Key_M				0x3A 
#define Key_N				0x31 
#define Key_O				0x44 	
#define Key_P				0x4D 	
#define Key_Q				0x15
#define Key_R				0x2D 
#define Key_U				0x3C 
#define Key_S				0x1B
#define Key_T				0x2C 
#define Key_V				0x2A 
#define Key_W				0x1D
#define Key_X				0x22
#define Key_Y				0x35 
#define Key_Z				0x1A


#define Key_NUM1			0x69 	
#define Key_NUM4			0x6B 	
#define Key_NUM7			0x6C 	
#define Key_NUM0			0x70 	
#define Key_NUM2			0x72 	
#define Key_NUM5			0x73 	
#define Key_NUM6			0x74 	
#define Key_NUM8			0x75 	
#define Key_NUM3			0x7A 	
#define Key_NUM_9			0x7D

#endif