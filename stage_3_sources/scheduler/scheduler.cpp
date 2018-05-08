#include "scheduler.h"
#include "gdt.h"
#include "c_asm_func.h"
#include "kiostream.h"

namespace scheduler
{
	Process processVec[MAX_PROCESS_COUNT];
	uint32 processCount;
	uint32 currentProcess;
	ProcessIdQue readyQue;
	ProcessIdQue waitQue;
	uint32 switchCount;

	void init (uint32 kernel_esp, uint32 kernel_eip) {
		new (&readyQue) ProcessIdQue ();
		new (&waitQue) ProcessIdQue ();
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
		processVec[currentProcess].timeLeft--;
		if (processVec[currentProcess].timeLeft <= 0) {
			switchCount++;
			
			uint32 lastProcess = currentProcess;
			uint32 newProcess = readyQue.front();
			readyQue.push_back(readyQue.front());
			readyQue.pop_front();
			
			if (lastProcess != newProcess) {
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
				processVec[currentProcess].eflags = ((uint32 *)intBase)[10] | 0x200;
				processVec[currentProcess].esp = ((uint32 *)intBase)[11];
				processVec[currentProcess].ss = ((uint32 *)intBase)[12];
	
				currentProcess = newProcess;
				processVec[currentProcess].timeLeft =
						processVec[currentProcess].timeGiven;
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
				((uint32 *)intBase)[10] = processVec[currentProcess].eflags | 0x200;
				((uint32 *)intBase)[11] = processVec[currentProcess].esp;
				((uint32 *)intBase)[12] = processVec[currentProcess].ss;
			}
		}
	}
}