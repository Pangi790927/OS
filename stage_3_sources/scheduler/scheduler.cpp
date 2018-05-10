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

		/// push on the process stack the registers:
		esp -= 48;
		((uint32 *)esp)[0] = 0;							// edi
		((uint32 *)esp)[1] = 0;							// esi
		((uint32 *)esp)[2] = 0;							// ebp
		((uint32 *)esp)[3] = esp + 48;					// esp
		
		((uint32 *)esp)[4] = 0;							// ebx
		((uint32 *)esp)[5] = 0;							// edx
		((uint32 *)esp)[6] = 0;							// ecx
		((uint32 *)esp)[7] = 0;							// eax

		((uint32 *)esp)[8] = eip;						// eip
		((uint32 *)esp)[9] = cs;						// cs
		((uint32 *)esp)[10] = __getRegEFLAGS() | 0x200;	// eflags
		((uint32 *)esp)[11] = esp;						// esp
		((uint32 *)esp)[12] = ss;						// ss

		processVec[pid].esp = esp;
		processVec[pid].dead = false;
		processVec[pid].timeLeft = time;
		processVec[pid].timeGiven = time;
		processVec[pid].pid = pid;
		processVec[pid].cr3 = cr3;

		readyQue.push_back(pid);

		return pid;
	}

	uint32 update (uint32 esp) {
		processVec[currentProcess].timeLeft--;
		if (processVec[currentProcess].timeLeft <= 0) {
			switchCount++;

			uint32 lastProcess = currentProcess;
			uint32 newProcess = readyQue.front();
			readyQue.push_back(readyQue.front());
			readyQue.pop_front();

			if (lastProcess != newProcess) {
				processVec[currentProcess].esp = esp;

				currentProcess = newProcess;
				processVec[currentProcess].timeLeft =
						processVec[currentProcess].timeGiven;
				__setCR3(processVec[currentProcess].cr3);

				return processVec[currentProcess].esp;
			}
		}
		return esp;
	}
}