#include "IntreruptDescriptor.h"
#include "c_asm_func.h"

extern void irq0() asm("irq0");
extern void irq1() asm("irq1");
extern void irq2() asm("irq2");
extern void irq3() asm("irq3");
extern void irq4() asm("irq4");
extern void irq5() asm("irq5");
extern void irq6() asm("irq6");
extern void irq7() asm("irq7");
extern void irq8() asm("irq8");
extern void irq9() asm("irq9");
extern void irq10() asm("irq10");
extern void irq11() asm("irq11");
extern void irq12() asm("irq12");
extern void irq13() asm("irq13");
extern void irq14() asm("irq14");
extern void irq15() asm("irq15");

class PIC {
public:
	IDT &table;

	constexpr static const u_int_8	MASTER_OFFSET = 0x20;
	constexpr static const u_int_8	SLAVE_OFFSET = 0x28;

	constexpr static const u_int_16	MASTER_COMMAND = 0x20;
	constexpr static const u_int_16	MASTER_DATA = 0x21;

	constexpr static const u_int_16	SLAVE_COMMAND = 0xA0;
	constexpr static const u_int_16	SLAVE_DATA = 0xA1;

	constexpr static const u_int_8  COMM_EOI = 0x20;
	constexpr static const u_int_8  COMM_INIT = 0x11;

	constexpr static const u_int_8	COMM_READ_IRR = 0x0a;
	constexpr static const u_int_8	COMM_READ_ISR = 0x0b;

	constexpr static const u_int_8  DATA_MODE = 0x01; /* 8086/88 (MCS-80/85) mode */

	PIC (IDT& table) : table(table) {
		setGates();
		PIC::remap(PIC::MASTER_OFFSET, PIC::SLAVE_OFFSET);
	}

	void setGates() {
		table.setGate(0x20, (u_int_32)irq0 , 0x08, 0x8E);
		table.setGate(0x21, (u_int_32)irq1 , 0x08, 0x8E);
		table.setGate(0x22, (u_int_32)irq2 , 0x08, 0x8E);
		table.setGate(0x23, (u_int_32)irq3 , 0x08, 0x8E);
		table.setGate(0x24, (u_int_32)irq4 , 0x08, 0x8E);
		table.setGate(0x25, (u_int_32)irq5 , 0x08, 0x8E);
		table.setGate(0x26, (u_int_32)irq6 , 0x08, 0x8E);
		table.setGate(0x27, (u_int_32)irq7 , 0x08, 0x8E);
		table.setGate(0x28, (u_int_32)irq8 , 0x08, 0x8E);
		table.setGate(0x29, (u_int_32)irq9 , 0x08, 0x8E);
		table.setGate(0x2a, (u_int_32)irq10, 0x08, 0x8E);
		table.setGate(0x2b, (u_int_32)irq11, 0x08, 0x8E);
		table.setGate(0x2c, (u_int_32)irq12, 0x08, 0x8E);
		table.setGate(0x2d, (u_int_32)irq13, 0x08, 0x8E);
		table.setGate(0x2e, (u_int_32)irq14, 0x08, 0x8E);
		table.setGate(0x2f, (u_int_32)irq15, 0x08, 0x8E);
	}

	static void remap (u_int_8 offsetMaster, u_int_8 offsetSlave) {
		u_int_8 master = 0, slave = 0;

		master = port_byte_in(MASTER_DATA);		/// save what master
		slave = port_byte_in(SLAVE_DATA);		/// and slave said

		port_byte_out(MASTER_COMMAND, COMM_INIT);
		io_wait();
		port_byte_out(SLAVE_COMMAND, COMM_INIT);
		io_wait();
		
		port_byte_out(MASTER_DATA, offsetMaster);
		io_wait();
		port_byte_out(SLAVE_DATA, offsetSlave);
		io_wait();

		port_byte_out(MASTER_DATA, 4);  // ICW3: tell Master PIC that there 
		io_wait();						// is a slave PIC at IRQ2 (0000 0100)
		port_byte_out(SLAVE_DATA, 2);   // ICW3: tell Slave PIC its 
		io_wait();						// cascade identity (0000 0010)


		port_byte_out(MASTER_DATA, DATA_MODE);
		io_wait();
		port_byte_out(SLAVE_DATA, DATA_MODE);
		io_wait();

		port_byte_out(MASTER_DATA, master);	// unmask all master
		port_byte_out(SLAVE_DATA, slave);	// unmask all slave
	}

	static void endOfInterrupt (u_int_8 irq) {
		if (irq >= 8)
			port_byte_out(SLAVE_COMMAND, COMM_EOI);

		port_byte_out(MASTER_COMMAND, COMM_EOI);
	}

	static u_int_16 getIrqRegisters (u_int_32 ocw3) {
		port_byte_out(MASTER_COMMAND, ocw3);
		port_byte_out(SLAVE_COMMAND, ocw3);

		return ((port_byte_in(SLAVE_COMMAND) << 8) | (port_byte_in(MASTER_COMMAND)));
	}

	static u_int_16 getIrr (void) {
		return getIrqRegisters(COMM_READ_IRR);
	}

	static u_int_16 getIsr (void) {
		return getIrqRegisters(COMM_READ_ISR);
	}
};