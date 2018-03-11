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
#include "c_asm_func.h"

/*
	Posible tasks:
		* Repair Deque
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
	{
		using namespace std;

		class Foo {
		public:
			string str;

			Foo (string str) : str(str) {}

			void print() {
				printf("%s", str.c_str());
			}

			~Foo () {
				printf("[dead: ");
				print();
				printf("]");
			}
		};

		deque<Foo> que({Foo("1"), Foo("2"), Foo("3"), Foo("4"), Foo("5")});

		for (auto&& elem : que) {
			elem.print();
			printf("\n");
		}

		auto ptr = que.begin();
		while (que.size()) {
			que.front().print();
			que.pop_front();
		}
	}
	memmanip::printMemory();

	keyboard::KeyState keyState;
	keyboard::init2KeyState(keyState);

	std::vector<uint32> keyList;

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
						printf("%c", (char)key);
						
						if ((char)key == '\n') {
							for (auto&& keyElem : keyList) {
								printf("%c", (char)(keyElem));
							}
							printf("\n%d\n", keyList.size());
							printf("\n");
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
	printf("Tring to exit ... \n");
	
} // this is so the deconstructors are called
	printf("Exiting ... \n");
	outb(0xf4, 0x00);
	return 0;
}