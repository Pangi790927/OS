#include "scheduler.h"
#include "gdt.h"
#include "c_asm_func.h"
#include "kiostream.h"
#include "static_avl.h"

namespace scheduler
{
	Process proc_vec[MAX_PROCESS_COUNT];
	uint32 proc_cnt;
	uint32 curr_pid;
	ProcessIdQue ready_que;
	ProcessIdQue wait_que;
	uint32 switch_cnt;
	uint64 curr_tick = 0;
	util::static_avl_t<time_pid_t, bool, 1024> block_time;

	void init (uint32 kernel_esp, uint32 kernel_eip) {
		new (&ready_que) ProcessIdQue ();
		new (&wait_que) ProcessIdQue ();
		new (&block_time) util::static_avl_t<time_pid_t, bool, 1024>();
		switch_cnt = 0;
		proc_cnt = 0;
		for (int i = 0; i < MAX_PROCESS_COUNT; i++)
			proc_vec[i].dead = true;
		curr_pid = addProcess(kernel_esp, kernel_eip,
				KERNEL_DATA_SEL, KERNEL_CODE_SEL, K_PAGING, 10);
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

		proc_vec[pid].block_reason = NOT_BLOCKED;
		proc_vec[pid].awake_reason = NOT_UNBLOCKED;
		proc_vec[pid].in_queue = true;

		ready_que.push_back(pid);

		asm volatile("sti");
		return pid;
	}

	static uint32 pop() {
		uint32 next_pid = ready_que.front();
		proc_vec[next_pid].in_queue = false;
		ready_que.pop_front();
		return next_pid;
	}

	static bool is_inactive (uint32 pid) {
		return proc_vec[pid].dead || proc_vec[pid].block_reason != NOT_BLOCKED;
	}

	static void push (uint32 pid) {
		if (!is_inactive(pid)) {
			proc_vec[pid].in_queue = true;
			ready_que.push_back(pid);
		}
	}

	void kill (uint32 pid) {
		bool switch_task = false;

		asm volatile("cli");
		proc_vec[pid].dead = true;
		proc_cnt--;
		if (pid == curr_pid)
			switch_task = true;
		asm volatile("sti");

		/* We will now call the scheduler update interrupt (function bellow) */
		if (switch_task)
			asm volatile("int $32");
	}

	void yield() {
		asm volatile("cli");
		proc_vec[curr_pid].time_left = 0;
		asm volatile("sti");

		/* We will now call the scheduler update interrupt (function bellow) */
		asm volatile("int $32");

		/* A better system may be required because with this one we are
		skipping sleep counts and we might call the update twice because a
		task switch might happen right before the execution of int 32 */
	}

	uint32 block (uint32 pid, int reason, kthread::Lock *lk, uint32 ticks) {
		bool swtch_task = false;

		asm volatile("cli");
		if (!reason)
			reason = ANY;
		if (ticks) {
			block_time.insert(time_pid_t(curr_tick + ticks, pid), 0);
		}
		proc_vec[pid].block_reason = reason;
		proc_vec[pid].awake_reason = NOT_UNBLOCKED;
		if (pid == curr_pid)
			swtch_task = true;
		if (lk) {
			lk->unlock();
		}
		asm volatile("sti");

		if (swtch_task)
			asm volatile("int $32");

		return proc_vec[pid].awake_reason;
	}

	void unblock (uint32 pid, int reason) {
		(void)reason;
		asm volatile("cli");
		proc_vec[pid].block_reason = NOT_BLOCKED;
		proc_vec[pid].awake_reason = UNBLOCK;
		if (!proc_vec[pid].in_queue)
			push(pid);
		asm volatile("sti");
	}

	uint32 getPid() {
		asm volatile("sti");
		uint32 ret_pid = curr_pid;
		asm volatile("cli");
		return ret_pid;
	}

	uint32 unblock_reason (uint32 pid) {
		asm volatile("sti");
		uint32 reason = proc_vec[pid].awake_reason;
		asm volatile("cli");
		return reason;
	}

	void unblock_time_blocked() {
		bool done = false;
		while (!done) {
			done = true;
			if (block_time.size() > 0) {
				time_pid_t time_pid = block_time.get_min_key();
				if (time_pid.unblock_time < curr_tick) {
					done = false;
					proc_vec[time_pid.pid].block_reason = NOT_BLOCKED;
					if (!proc_vec[time_pid.pid].in_queue)
						push(time_pid.pid);
					proc_vec[time_pid.pid].awake_reason = TIME_UNBLOCK;
					block_time.remove(time_pid);
				}
			}
		}
	}

	uint32 update (uint32 esp) {
		proc_vec[curr_pid].time_left--;
		curr_tick++;

		if (proc_vec[curr_pid].time_left <= 0 || is_inactive(curr_pid))
		{
			unblock_time_blocked();
			switch_cnt++;

			if (proc_cnt <= 0)
				kprintf("how did you manage to kill all pid's?");

			uint32 prev_pid = curr_pid;
			push(prev_pid);

			uint32 next_pid = pop();
			while (is_inactive(next_pid))
				next_pid = pop();

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

	std::vector<uint32> active_pids() {
		std::vector<uint32> pid_list;
		asm volatile("cli");
		for (int i = ready_que.start; i != ready_que.end + 1;
				i = (i + 1) % MAX_PROCESS_COUNT)
		{
			pid_list.push_back(ready_que.que[i]);
		}
		asm volatile("sti");
		return pid_list;
	}
}
