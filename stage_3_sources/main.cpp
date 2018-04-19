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
#include "boot_data.h"
#include "kiostream.h"
#include "scheduler.h"

/*
	Tasks:
		* Fix bug in hexdump
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

void hexdump (std::vector<std::string> &args) {
	if (args.size() != 3) {
		kprintf("hexdump address size\n");
		return ;
	}
	uint8 *address = (uint8 *)atoi(args[1].c_str());
	uint32 size = atoi(args[2].c_str());
	uint32 printedCount = 0;

	std::string last = "";
	std::string current = "";
	bool printedStar = false;

	char hex[] = "0123456789abcdef";
	auto printNext = [&]() {
		if (printedCount != size) {
			current += hex[(address[printedCount] >> 4) & 0xf];
			current += hex[address[printedCount] & 0xf];
			printedCount++;
		}
	};
	auto hexToStrPadded = [&](uint32 number, int padding) {
		std::string strNumber;

		while (number) {
			strNumber = hex[number % 16] + strNumber;
			number /= 16;
			padding--;
		}
		while (padding > 0) {
			strNumber = "0" + strNumber;
			padding--;
		}
		return strNumber;
	};
	while (printedCount != size) {
		for (int i = 0; i < 8 && printedCount != size; i++) {
			current += " ";
			printNext();
			printNext();
		}
		if (current == last) {
			if (!printedStar) {
				printedStar = true;
				std::cout << "*" << std::endl;
			}
		}
		else {
			last = current;
			std::cout << hexToStrPadded(printedCount / 16, 8) << "0";
			std::cout << current << std::endl;
			printedStar = false;
		}
		current = "";
	}
	/// strange bug here if args is not a reference 
}

bool commandExecute (std::vector<std::string> &args) {
	if (args[0] == "pci")
		pci::printBusses();
	else if (args[0] == "clear")
		kclear_screen();
	else if (args[0] == "memprint")
		memmanip::printMemory();
	else if (args[0] == "hexdump")
		hexdump(args);
	else if (args[0] == "exit")
		return false;
	else if (args[0] == "switchCount")
		std::cout << scheduler::switchCount << std::endl;
	else if (args[0] == "ss")
		kprintf("%b\n", __getRegSS());
	else if (args[0] == "ramsize")
		std::cout << " * " << boot::get_ram_size() / 1024 / 1024 <<
				"Mb" << std::endl;
	else if (args[0] == "help") {
		std::cout << " * pci            - print pci status" << std::endl;
		std::cout << " * clear          - clears the screen" << std::endl;
		std::cout << " * memprint       - prints heap memory information" << std::endl;
		std::cout << " * hexdump        - print memory at "
				"address: hexdump [addr] [size]" << std::endl;
		std::cout << " * exit           - closes the computer" << std::endl;
		std::cout << " * ramsize        - print the size of RAM" << std::endl;
		std::cout << " * help           - prints this help" << std::endl;
		std::cout << " * switchCount    - prints total task switches" << std::endl;
	}
	else
		std::cout << "command not found: " << args[0] << std::endl;
	return true;
}

// void printUserMode() asm ("printUserMode");

void printUserMode() {
	std::cout << "Wellcome to user mode" << std::endl;
	std::cout << "Commands are ready to be typed" << std::endl;

	keyboard::KeyState keyState;
	keyboard::init2KeyState(keyState);
	keyboard::KeyTranslator keyTranslate;

	std::deque<uint32> keyList;
	std::cout << "os$ ";
	std::cout.flush();

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
							std::cout << c;
							std::cout.flush();
						}
					}

					if ((char)key == '\n' && !(key & NON_ASCII_KEY) 
							&& (key & PRESS))
					{
						for (auto&& keyElem : keyList) {
							std::buff.readIn((char)(keyElem));	
						}
						while (keyList.size())
							keyList.pop_back();
						
						std::string command;
						std::getline(std::cin, command);

						auto tokenVec = tokenize(command, " ");
						if (tokenVec.size() != 0) {
							if (!commandExecute(tokenVec))
								kernel_alive = false;
							std::cout << "os$ ";
							std::cout.flush();
						}
						else {
							std::cout << "os$ ";
							std::cout.flush();
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
	std::cout << "Tring to exit ..." << std::endl;

	kprintf("Exiting ... \n");
	outb(0xf4, 0x00);
}

void putCharAt() {
	while (true) {
		VGA::_char_val_at(20, 20)++;
	}
}

int main()
{
	kclear_screen();

	gdt::init_gdt();
	gdt::load_gdt();
	gdt::flush_tss(KERNEL_TSS_SEL | 3);

	memmanip::init((void *)V_HEAP_START);

	/* Global constructors till we are able to call them automaticaly*/
	new (&std::buff) std::kiobuf<char>(256);
	new (&std::cout) std::ostream(std::buff);
	new (&std::cin) std::istream(std::buff);
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

		__setIOPL(3);
		scheduler::init(V_K_STACK_START, (uint32)&printUserMode);
		// scheduler::addProcess(V_K_STACK_START, (uint32)&printUserMode,
		// 		USER_DATA_SEL | 3, USER_CODE_SEL | 3, K_PAGING, 100);
	asm volatile ("sti");
	__switchToProcess(USER_DATA_SEL | 3, USER_CODE_SEL | 3,
			V_K_STACK_START, (uint32)&printUserMode);

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