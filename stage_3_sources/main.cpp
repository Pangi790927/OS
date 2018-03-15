#include "icxxabi.h"
#include "vga_stdio.h"
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
#include "istream.h"
#include "key_translate.h"
#include "mutex.h"

/*
	Posible tasks:
		* File system
		* Read/Write with DMA from HDD
		* support multiple media for boot
		* VGA Graphics Mode
		* More advanced graphics 
		* Network Driver
		* Memory: paging
		* Task Scheduler
		* Shell
		* Global constructors
*/

int main()
{
	kclear_screen();

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
	std::kiobuf<char> buff(256);
	std::ostream cout(buff);
	std::istream cin(buff);

	cout << "Wellcome to Stage 3 of the kernel" << std::endl;
	cout << "Commands are ready to be typed" << std::endl;

	keyboard::KeyState keyState;
	keyboard::init2KeyState(keyState);
	keyboard::KeyTranslator keyTranslate;

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
					char c = 0;
					if ((char)key == '\b' && (key & PRESS)) {
						keyList.pop_back();
						VGA::backspace();
					}
					else if ((c = keyTranslate.translate(key))) {
						if (key & PRESS) {
							keyList.push_back(c);
							cout << c;
							cout.flush();
						}
					}

					if ((char)key == '\n' && !(key & NON_ASCII_KEY) && (key & PRESS)) {
						for (auto&& keyElem : keyList) {
							buff.readIn((char)(keyElem));	
						}
						while (keyList.size())
							keyList.pop_back();
						
						std::string command;
						cin >> command;
						cout << command << std::endl;
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
	cout << "Tring to exit ... " << std::endl;
	
} // this is so the deconstructors are called
	kprintf("Exiting ... \n");
	outb(0xf4, 0x00);
	return 0;
}