#ifndef KCOND_VAR_H
#define KCOND_VAR_H

namespace kthread
{
	struct CondVar {
		void init();
		void wait();
		void notify_one();
		void notify_all();
	};
}

#endif