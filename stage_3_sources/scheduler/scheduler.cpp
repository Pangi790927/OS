#include "scheduler.h"
#include "gdt.h"
#include "c_asm_func.h"
#include "kiostream.h"

namespace scheduler
{
	Process proc_vec[MAX_PROCESS_COUNT];
	uint32 proc_cnt;
	uint32 curr_pid;
	ProcessIdQue ready_que;
	ProcessIdQue wait_que;
	uint32 switch_cnt;

	void init (uint32 kernel_esp, uint32 kernel_eip) {
		new (&ready_que) ProcessIdQue ();
		new (&wait_que) ProcessIdQue ();
		switch_cnt = 0;
		proc_cnt = 0;
		for (int i = 0; i < MAX_PROCESS_COUNT; i++)
			proc_vec[i].dead = true;
		curr_pid = addProcess(kernel_esp, kernel_eip,
				KERNEL_DATA_SEL, KERNEL_CODE_SEL, K_PAGING, 100);
		ready_que.pop_front(); // first process will not be in ready que
	}

	int addProcess (uint32 esp, uint32 eip, uint32 ss, uint32 cs,
			uint32 cr3, uint32 time)
	{
		asm volatile("cli");
		uint32 pid = 0;

		while (pid < MAX_PROCESS_COUNT && proc_vec[pid].dead == false)
			pid++;

		if (proc_vec[pid].dead)
			proc_cnt++;
		else
			return -1;

		/// push on the process stack the registers:
		esp -= sizeof(task_stack_t);
		task_stack_t *task_stack = (task_stack_t *)esp;
		
		task_stack->edi = 0;
		task_stack->esi = 0;
		task_stack->ebp = 0;
		task_stack->esp = esp + 32;	// actually ignored

		task_stack->ebx = 0;
		task_stack->edx = 0;
		task_stack->ecx = 0;
		task_stack->eax = 0;

		task_stack->it_eip = eip;
		task_stack->it_cs = cs;
		task_stack->it_flags = __getRegEFLAGS() | 0x200;
		task_stack->it_esp = esp + sizeof(task_stack_t);
		task_stack->it_ss = ss;
		
		proc_vec[pid].stack = *task_stack;
		proc_vec[pid].esp = esp;
		proc_vec[pid].dead = false;
		proc_vec[pid].time_left = time;
		proc_vec[pid].time_given = time;
		proc_vec[pid].pid = pid;
		proc_vec[pid].cr3 = cr3;
		proc_vec[pid].priv_level = cs & 3;	// first 3 should 

		ready_que.push_back(pid);

		asm volatile("sti");
		return pid;
	}

	// probably needs protection
	void kill (uint32 pid) {
		asm volatile("cli");
		proc_vec[pid].dead = true;
		asm volatile("sti");
	}

	// probably needs protection
	uint32 getPid() {
		asm volatile("sti");
		uint32 ret_pid = curr_pid;
		asm volatile("cli");
		return ret_pid;
	}

	uint32 update (uint32 esp) {
		proc_vec[curr_pid].time_left--;
		
		if (proc_vec[curr_pid].time_left <= 0 || proc_vec[curr_pid].dead) {
			switch_cnt++;

			uint32 prev_pid = curr_pid;
			ready_que.push_back(prev_pid);

			uint32 next_pid = ready_que.front();
			ready_que.pop_front();

			while (proc_vec[next_pid].dead) {
				next_pid = ready_que.front();
				ready_que.pop_front();
			}

			if (prev_pid != next_pid) {
				curr_pid = next_pid;

				task_stack_t *task_stack = (task_stack_t *)esp;

				if (proc_vec[prev_pid].priv_level == 3) {
					proc_vec[prev_pid].stack = *task_stack;
				}
				else {
					proc_vec[prev_pid].esp = esp;	
				}
				
				proc_vec[next_pid].time_left = proc_vec[next_pid].time_given;
				__setCR3(proc_vec[next_pid].cr3);

				if (proc_vec[next_pid].priv_level == 3) {
					return (uint32)&proc_vec[next_pid].stack;
				}
				else {
					return proc_vec[next_pid].esp;
				}
			}
		}
		return esp;
	}
}
