#ifndef KSEM_H
#define KSEM_H

namespace kthread
{
	struct Sem {
		int var; // with an initial var

		/* add sched block, and unblock on reason */
		void signal() {
			/* still atomically */
			var++;
		}

		void wait() {
			/* atomically */
			while (!var)
				{}
			var--;
		}
	};
}

#endif