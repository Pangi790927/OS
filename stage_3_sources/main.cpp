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
#include "gdtInit.h"
#include "pci.h"
#include "boot_data.h"
#include "kiostream.h"
#include "scheduler.h"
#include "net.h"
#include "netinfo.h"
#include "kthread.h"
#include "atomic32.h"
#include "time.h"
#include "netutils.h"
#include "kerndiag.h"
#include "ata_driver.h"
#include "elf.h"
#include "kern_elf.h"
#include "kblock.h"
#include "kmutex.h"
#include "kcond_var.h"
#include "hash.h"
#include "avl.h"
#include "static_avl.h"

/*
	Tasks:
		* Network Driver
		* MAKE MALLOC(done), PRINTF and other functions THREAD SAFE !!!!!!
	Posible tasks:
		* Make debbuger with elf help
		* File system
		* Read/Write with DMA from HDD
		* Shell
		* support multiple media for boot
		* VGA Graphics Mode
		* More advanced graphics 
		* Global constructors
		* Repair keyboard initialization
		# Fix bug in hexdump ??---is it fixed---??
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
			std::cout << hexToStrPadded((printedCount - 1) / 16, 8) << "0";
			std::cout << current << std::endl;
			printedStar = false;
		}
		current = "";
	}
	/// strange bug here if args is not a reference 
}

bool commandExecute (std::vector<std::string> &args) {
	if (args[0] == "pci")
		for (auto&& dev : pci::Device::getAll())
			std::cout << dev;
	else if (args[0] == "clear") {
		kclear_screen();
	}
	else if (args[0] == "memprint") {
		memmanip::printMemory();
	}
	else if (args[0] == "hexdump") {
		hexdump(args);
	}
	else if (args[0] == "exit") {
		return false;
	}
	else if (args[0] == "switchCount") {
		std::cout << scheduler::switch_cnt << std::endl;
	}
	else if (args[0] == "ss") {
		kprintf("%b\n", __getRegSS());
	}
	else if (args[0] == "ramsize") {
		std::cout << " * " << boot::get_ram_size() / 1024 / 1024 <<
				"Mb" << std::endl;
	}
	else if (args[0] == "printpd") {
		paging::printPD((uint32 *)K_PAGING);
	}
	else if (args[0] == "net") {
		std::cout << net::netinfo() << std::endl;
	}
	else if (args[0] == "ps") {
		auto pids = scheduler::active_pids();
		std::cout << "pids: ";
		for (auto pid : pids)
			std::cout << pid << ", ";
		std::cout << std::endl;
	}
	else if (args[0] == "blk") {
		if (args.size() == 2) {
			uint32 pid = atoi(args[1].c_str());
			scheduler::block(pid, scheduler::ANY);
		}
		else
			std::cout << "usage: blk pid" << std::endl;
	}
	else if (args[0] == "ublk") {
		if (args.size() == 2) {
			uint32 pid = atoi(args[1].c_str());
			scheduler::unblock(pid, scheduler::ANY);
		}
		else
			std::cout << "usage: ublk pid" << std::endl;
	}
	else if (args[0] == "kill") {
		if (args.size() == 2) {
			uint32 pid = atoi(args[1].c_str());
			scheduler::kill(pid);
		}
		else
			std::cout << "usage: kill pid" << std::endl;
	}
	else if (args[0] == "arp") {
		using namespace net;
		mac_addr_t addr;
		int res = net::arp::get_addr_v4(net::str_to_ip("10.0.0.1"), addr);
		kprintf("res: %d haddr: %s\n", res, net::eth::to_string(addr));
	}
	else if (args[0] == "printpt") {
		if (args.size() == 2) {
			paging::printPT((uint32 *)K_PAGING, atoi(args[1].c_str()));
		}
		else {
			std::cout << "usage: printpt index" << std::endl;
		}
	}
	else if (args[0] == "help") {
		std::cout << " * pci            - print pci status" << std::endl;
		std::cout << " * clear          - clears the screen" << std::endl;
		std::cout << " * memprint       - prints heap memory information"
				<< std::endl;
		std::cout << " * hexdump        - print memory at "
				"address: hexdump [addr] [size]" << std::endl;
		std::cout << " * exit           - closes the computer" << std::endl;
		std::cout << " * ramsize        - print the size of RAM" << std::endl;
		std::cout << " * help           - prints this help" << std::endl;
		std::cout << " * switchCount    - prints total task switches"
				<< std::endl;
		std::cout << " * printpd        - prints paging directory" << std::endl;
		std::cout << " * printpt        - prints paging table at index"
				<< std::endl;
		std::cout << " * net            - prints network info" << std::endl;
		std::cout << " * ps             - proc info" << std::endl;
		std::cout << " * blk            - block pid" << std::endl;
		std::cout << " * ublk           - unblock pid" << std::endl;
		std::cout << " * kill           - kill pid" << std::endl;
		std::cout << " * arp            - arp init" << std::endl;
	}
	else
		std::cout << "command not found: " << args[0] << std::endl;
	return true;
}

struct TestThreads {
	kthread::Mutex mu;
	kthread::CondVar cv;
	bool flag = false;

	TestThreads() {
		mu.init();
		cv.init();

		kthread::Thread th1(
			[](void *self) {
				TestThreads *_self = (TestThreads *)self;
				sleep(3000);
				_self->mu.lock();
				_self->flag = true;
				_self->cv.notify_one();
				_self->mu.unlock();
			},
			this
		);

		kthread::Thread th2(
			[](void *self) {
				TestThreads *_self = (TestThreads *)self;
				_self->mu.lock();
				while (!_self->flag) {
					_self->cv.wait(_self->mu);
				}
				std::cout << "hello from 2" << std::endl;
				_self->mu.unlock();
			},
			this
		);

		if (th1.joinable())
			th1.join();
		if (th2.joinable())
			th2.join();
	}
};

void printUserMode() {

	std::cout << "Wellcome to OS" << std::endl;
	std::cout << "Commands are ready to be typed" << std::endl;

	/* drivers that are not using port io can be initialized here */
	/* putting them here enables us to use interrupts in iinitialization */
	/* because in main interrupts are mainly disabled */

	net::init();
	// TestThreads();

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

	kprintf("Cleaning up ...");
	net::uninit();
	kprintf("Exiting ... \n");
	outb(0xf4, 0x00);
}

char *put_char_stack;
void putCharAt() {
	while (true) {
		VGA::_char_val_at(24, 79) = '/';
		scheduler::yield();
		VGA::_char_val_at(24, 79) = '\\';
		scheduler::yield();
	}
	scheduler::kill(scheduler::getPid());
	while (true)
		asm volatile ("");
}

int main()
{
	/* -- entry -- */
	/* gdt must be initialized first */
	/* memory and diagnostics can be second */
	/* idt, isr as soon as posible */
	/* pit before scheduler is started */
	/* drivers are initialized here (io ports will be unavailable) */
	/* -- scheduler starts -- */
	/* the rest can be initialized afterwards */

	kclear_screen();

	gdt::init_gdt();
	gdt::load_gdt();
	gdt::flush_tss(KERNEL_TSS_SEL | 3);

	memmanip::init((void *)V_HEAP_START);
	ata::init();
	elf::init_kinfo();
	kdbg::init();

	/* Global constructors till we are able to call them automaticaly*/
	new (&std::buff) std::kiobuf<char>(256);
	new (&std::cout) std::ostream(std::buff);
	new (&std::cin) std::istream(std::buff);
	// _init(); // !@#$ global constructors don't work

	asm volatile ("cli");
		set_error_ISR();
		set_irq_ISR();

		idt::loadIDT();

		irq_isr::init();
		irq_isr::sendMasterMask(0b0000'0000);
		irq_isr::sendSlaveMask(0b0000'0000);
		
		pit::initDefault(1000);
		kthread::init();
		kthread::init_block();

		keyboard::init();

		__setIOPL(3);
		scheduler::init(V_K_STACK_START, (uint32)&printUserMode);
		
		put_char_stack = new char[8192];
		scheduler::addProcess((uint32)put_char_stack, (uint32)&putCharAt,
				USER_DATA_SEL | 3, USER_CODE_SEL | 3, K_PAGING, 10);

	/// will enable interrupts:
	__switchToProcess(KERNEL_DATA_SEL, KERNEL_CODE_SEL,
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