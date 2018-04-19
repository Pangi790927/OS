#include "scheduler.h"
#include "gdt.h"
#include "c_asm_func.h"
#include "kiostream.h"

namespace scheduler
{
	Process processVec[MAX_PROCESS_COUNT];
	uint32 processCount;
	uint32 currentProcess;
	std::deque<uint32> readyQue;
	std::deque<uint32> waitQue;
	uint32 switchCount;

	void init (uint32 kernel_esp, uint32 kernel_eip) {
		// are here till we will be able to call global constructors
		new (&readyQue) std::deque<uint32> ();
		new (&waitQue) std::deque<uint32> ();
		switchCount = 0;
		processCount = 0;
		for (int i = 0; i < MAX_PROCESS_COUNT; i++)
			processVec[i].dead = true;
		currentProcess = addProcess(kernel_esp, kernel_eip,
				KERNEL_DATA_SEL, KERNEL_CODE_SEL, K_PAGING, 100);
	}

	int addProcess (uint32 esp, uint32 eip, uint32 ss, uint32 cs,
			uint32 cr3, uint32 time)
	{
		uint32 pid = 0;

		while (pid < MAX_PROCESS_COUNT && processVec[pid].dead == false)
			pid++;

		if (processVec[pid].dead)
			processCount++;
		else
			return -1;

		processVec[pid].eax = 0;
		processVec[pid].ecx = 0;
		processVec[pid].edx = 0;
		processVec[pid].ebx = 0;
		processVec[pid].ebp = 0;
		processVec[pid].esi = 0;
		processVec[pid].edi = 0;
		processVec[pid].cr3 = cr3;
		processVec[pid].eip = eip;
		processVec[pid].esp = esp;
		processVec[pid].ss = ss;
		processVec[pid].cs = cs;
		processVec[pid].dead = false;
		processVec[pid].timeLeft = time;
		processVec[pid].timeGiven = time;
		processVec[pid].pid = pid;

		readyQue.push_back(pid);

		return pid;
	}

	void update (uint32 intBase) {
		kprintf("%x\n", intBase);
		kprintf("  %x\n", ((uint32 *)intBase)[6]);
		kprintf("  %x\n", ((uint32 *)intBase)[7]);
		kprintf(": %x\n", ((uint32 *)intBase)[8]);
		kprintf(": %x\n", ((uint32 *)intBase)[9]);
		kprintf(": %b\n", ((uint32 *)intBase)[10]);
		kprintf(": %x\n", ((uint32 *)intBase)[11]);
		kprintf(": %x\n", ((uint32 *)intBase)[12]);
		kprintf("  %x\n", ((uint32 *)intBase)[13]);
		kprintf("  %x\n", ((uint32 *)intBase)[14]);
		kprintf("s  %x\n", __getRegSS());
		kprintf("s  %x\n", __getRegCS());
		
		processVec[currentProcess].timeLeft--;
		if (processVec[currentProcess].timeLeft <= 0) {
			// while(true);
			switchCount++;
			// kprintf("%x\n", processVec[currentProcess].eip);
			// kprintf("%x\n", processVec[currentProcess].cs);
			// kprintf("%x\n", processVec[currentProcess].eflags);
			// kprintf("%x\n", processVec[currentProcess].esp);
			// kprintf("%x\n", processVec[currentProcess].ss);
			
			// std::cout << "-------------------------------" << std::endl;
			// kprintf("%x\n", processVec[currentProcess].eip);
			// kprintf("%x\n", processVec[currentProcess].cs);
			// kprintf("%x\n", processVec[currentProcess].eflags);
			// kprintf("%x\n", processVec[currentProcess].esp);
			// kprintf("%x\n", processVec[currentProcess].ss);

			uint32 lastProcess = currentProcess;
			uint32 newProcess = readyQue.front();
			readyQue.push_back(readyQue.front());
			readyQue.pop_front();
			if (lastProcess != newProcess) {
				// save last process data
				kprintf("switching %d, %d\n", lastProcess, newProcess);


				processVec[currentProcess].edi = ((uint32 *)intBase)[0];
				processVec[currentProcess].esi = ((uint32 *)intBase)[1];
				processVec[currentProcess].ebp = ((uint32 *)intBase)[2];
				// esp (we get esp from what interr pushed)			 3
				processVec[currentProcess].ebx = ((uint32 *)intBase)[4];
				processVec[currentProcess].edx = ((uint32 *)intBase)[5];
				processVec[currentProcess].ecx = ((uint32 *)intBase)[6];
				processVec[currentProcess].eax = ((uint32 *)intBase)[7];
				
				processVec[currentProcess].eip = ((uint32 *)intBase)[8];
				processVec[currentProcess].cs = ((uint32 *)intBase)[9];
				processVec[currentProcess].eflags = ((uint32 *)intBase)[10];
				processVec[currentProcess].esp = ((uint32 *)intBase)[11];
				processVec[currentProcess].ss = ((uint32 *)intBase)[12];
	
				// put new process data
				currentProcess = newProcess;
				processVec[currentProcess].timeLeft = processVec[currentProcess].timeGiven;
				__setCR3(processVec[currentProcess].cr3);
				
				((uint32 *)intBase)[0] = processVec[currentProcess].edi;
				((uint32 *)intBase)[1] = processVec[currentProcess].esi;
				((uint32 *)intBase)[2] = processVec[currentProcess].ebp;
				// esp				3
				((uint32 *)intBase)[4] = processVec[currentProcess].ebx;
				((uint32 *)intBase)[5] = processVec[currentProcess].edx;
				((uint32 *)intBase)[6] = processVec[currentProcess].ecx;
				((uint32 *)intBase)[7] = processVec[currentProcess].eax;

				((uint32 *)intBase)[8] = processVec[currentProcess].eip;
				((uint32 *)intBase)[9] = processVec[currentProcess].cs;
				((uint32 *)intBase)[10] = processVec[currentProcess].eflags;
				((uint32 *)intBase)[11] = processVec[currentProcess].esp;
				((uint32 *)intBase)[12] = processVec[currentProcess].ss;
			}
			
			// std::cout << "-------------------------------" << std::endl;
			// kprintf(": %x\n", ((uint32 *)intBase)[0]);
			// kprintf(": %x\n", ((uint32 *)intBase)[1]);
			// kprintf(": %x\n", ((uint32 *)intBase)[2]);
			// kprintf(": %x\n", ((uint32 *)intBase)[3]);
			// kprintf(": %x\n", ((uint32 *)intBase)[4]);
			// while (true);
		}
	}
}