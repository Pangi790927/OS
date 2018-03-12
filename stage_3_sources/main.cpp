#include "icxxabi.h"
#include "kstdio.h"
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
#include "c_asm_func.h"
#include "kiobuf.h"
#include "ostream.h"

/*
	Posible tasks:
		* File system
		* Read/Write with DMA
		* VGA Graphics Mode
		* Memory: paging 
		* Task Scheduler
		* Input functions
		* Shell
		* More advanced graphics 
		* Network Driver
*/

int main()
{
	kclear_screen();
	kprintf("Stage 3!\n");

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
	{
		std::kiobuf<char> buff(256);
		std::ostream cout(buff);

		cout << "this" << std::endl;
	}
	memmanip::printMemory();

	keyboard::KeyState keyState;
	keyboard::init2KeyState(keyState);

	std::deque<uint32> keyList;

	bool kernel_alive = true;
	while (kernel_alive) {
		/* main kernel loop */
		if (keyboard::hasNewKey()) {
			while (keyboard::keyCount()) {
				using namespace keyboard;
				
				uint32 intkey = getKey();
				uint32 key = keyState.doEvent(intkey);
				if (key) {
					if (key & PRESS) {
						if (!(key & NON_ASCII_KEY))
							keyList.push_back(key);
						kprintf("%c", (char)key);
						
						if ((char)key == '\n') {
							for (auto&& keyElem : keyList) {
								kprintf("%c", (char)(keyElem));
							}
							kprintf("\n%d\n", keyList.size());
							kprintf("\n");
						}
					}
					if (key == ESCAPE_PRESS) {
						kernel_alive = false;
					}
				}
				keyboard::popKey();
			}
			keyboard::ackKey();
		}
	}
	kprintf("Tring to exit ... \n");
	
} // this is so the deconstructors are called
	kprintf("Exiting ... \n");
	outb(0xf4, 0x00);
	return 0;
}