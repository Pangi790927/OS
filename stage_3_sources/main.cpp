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
#include "gdtInit.h"
#include "pci.h"

/*
	Tasks:
		* Memory: paging
		* Task Scheduler
	Posible tasks:
		* File system
		* Read/Write with DMA from HDD
		* support multiple media for boot
		* VGA Graphics Mode
		* More advanced graphics 
		* Network Driver
		* Shell
		* Global constructors
*/

extern int _init() asm("_init");
extern int _fini() asm("_fini");

extern void switchToRing3 (int dataSel, int codeSel, int stack, int instrPtr)
		asm ("switchToRing3");

void hexdump (std::vector<std::string> args) {
	if (args.size() != 3) {
		kprintf("hexdump address size\n");
		return ;
	}
	kprintf("WIP\n");
}

void printUserMode() asm ("printUserMode");

void printUserMode() {
	std::kiobuf<char> buff(256);
	std::ostream cout(buff);
	std::istream cin(buff);

	cout << "Wellcome to user mode" << std::endl;
	cout << "Commands are ready to be typed" << std::endl;

	keyboard::KeyState keyState;
	keyboard::init2KeyState(keyState);
	keyboard::KeyTranslator keyTranslate;

	std::deque<uint32> keyList;
	cout << "os$ ";
	cout.flush();

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
						if (keyList.size()) {
							keyList.pop_back();
							VGA::backspace();
						}

					}
					else if ((c = keyTranslate.translate(key))) {
						if (key & PRESS) {
							keyList.push_back(c);
							cout << c;
							cout.flush();
						}
					}

					if ((char)key == '\n' && !(key & NON_ASCII_KEY) 
							&& (key & PRESS))
					{
						for (auto&& keyElem : keyList) {
							buff.readIn((char)(keyElem));	
						}
						while (keyList.size())
							keyList.pop_back();
						
						std::string command;
						std::getline(cin, command);

						auto tokenVec = tokenize(command, " ");
						if (tokenVec.size() != 0) {
							if (tokenVec[0] == "pci")
								pci::printBusses();
							else if (tokenVec[0] == "clear")
								kclear_screen();
							else if (tokenVec[0] == "memprint")
								memmanip::printMemory();
							else if (tokenVec[0] == "hexdump")
								hexdump(tokenVec);
							else
								cout << "command not found: " << tokenVec[0] << std::endl;
							cout << "os$ ";
							cout.flush();
						}
						else {
							cout << "os$ ";
							cout.flush();
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
	cout << "Tring to exit ... " << std::endl;

	kprintf("Exiting ... \n");
	outb(0xf4, 0x00);
}

int main()
{
	kclear_screen();

	gdt::init_gdt();
	gdt::load_gdt();
	gdt::flush_tss(KERNEL_TSS_SEL | 3);

	memmanip::init((void *)HEAP_START);

	// _init(); // !@#$ global constructors don't work

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

	__setIOPL(3);

	switchToRing3(USER_DATA_SEL | 3, USER_CODE_SEL | 3,
			K_STACK_START, (uint32)&printUserMode);

	// we will never get here, 
	// 
	// 
	// 
	// 
	// usually ...
	while (true)
		asm volatile ("");
	return 0;
}