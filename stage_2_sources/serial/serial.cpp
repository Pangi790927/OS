#include "serial.h"
#include "Types.h"
#include "c_asm_func.h"
#include "stdio.h"

namespace serial
{
	/* http://www.webcitation.org/5ugQv5JOw */

	static const uint32 COM1 = 0x3F8;
	static const uint32 THR = COM1 + 0;	// Transmitter Holding Register
	static const uint32 IER = COM1 + 1;	// Interrupt Enable Register
	static const uint32 DL_LO = COM1 + 0;	// Divisor Latch
	static const uint32 DL_HI = COM1 + 1;	// Divisor Latch
	static const uint32 FCR = COM1 + 2;	// FIFO Control Register
	static const uint32 LCR = COM1 + 3;	// Line Control Register
	static const uint32 LSR = COM1 + 5;	// Line Status Register

	static const uint8 DLAB_BIT = 0b1000'0000;
	static const uint8 _8N1 = 0b0000'0011;


	static const uint8 FIFO_TRIG_LVL = 0b1100'0000;
	static const uint8 FIFO_EN_BITS = 0b0000'0001;
	static const uint8 FIFO_RX_CLEAR_BIT = 0b0000'0010;
	static const uint8 FIFO_TX_CLEAR_BIT = 0b0000'0100;

	static const uint8 TX_READY = 0b0010'0000;

	void init() {
		outb(LCR, 0);
		outb(IER, 0);
		outb(LCR, DLAB_BIT);
		outb(DL_LO, 1);
		outb(DL_HI, 0);
		outb(LCR, _8N1);
		outb(FCR, FIFO_EN_BITS | FIFO_TRIG_LVL |
				FIFO_RX_CLEAR_BIT | FIFO_TX_CLEAR_BIT);
	}

	void uninit() {
		// ...
	}

	void sendchr (char chr) {
		while (!(inb(LSR) & TX_READY))
			{}
		outb(THR, chr);
	}

	void sendstr (char *str) {
		if (!str)
			return;
		while (*str) {
			sendchr(*str);
			str++;
		}
	}
}