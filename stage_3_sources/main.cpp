#include "icxxabi.h"
#include "stdio.h"
#include "isr.h"
#include "error_isr.h"
#include "irq_isr.h"
#include "pit.h"
#include "memmanip.h"
#include "global_defines.h"
#include "vector.h"
#include "memory.h"
#include "deque.h"
#include "string.h"
#include "keyboard.h"

class Construct {
public:
	Construct() {
		clear_screen();
		printf("Object wasa constructed ... \n");
		asm volatile("hlt");
	}

	~Construct() {
		clear_screen();
		printf("Object wasa deconstructed ... \n");
		asm volatile("hlt");
	}
};

Construct obj;

int main()
{
	clear_screen();
	printf("Stage 3!\n");

	asm volatile ("cli");
		set_error_ISR();
		set_irq_ISR();
		
		idt::loadIDT();
		
		irq_isr::remap();
		irq_isr::sendMasterMask(0b1111'1100);
		irq_isr::sendSlaveMask(0xff);
		
		keyboard::init();
		
		pit::initDefault(1000);
	asm volatile ("sti");

	memmanip::init((void *)HEAP_START);

/*	INITIALIZERS ABOVE ^^^ -------------------------------------------------- */

	{
		std::string msg = "Ana are mere";
		msg += " si george are masini";

		printf("%s\n", msg.c_str());
	}
	memmanip::printMemory();

	while (true) {
		if (keyboard::hasNewKey()) {
			while (keyboard::keyCount()) {
				printf("%x ", keyboard::getKey());
				keyboard::popKey();
			}
			keyboard::ackKey();
		}
	}

	__cxa_finalize(0);

	// memmanip::printMemory();
	// printf("can continue...\n");

	while (true)
		asm volatile("hlt");
	return 0;
}