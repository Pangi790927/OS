#ifndef STATIC_ALLOC_H
#define STATIC_ALLOC_H

namespace util
{
	template <size_t elem_size, size_t len>
	struct static_alloc_t {
		uint32 free_stack[len];
		uint8 data_vec[len][elem_size];
		uint32 stack_end = 0;
		uint32 last_unused = 0;
		uint32 size = 0;

		void *alloc() {
			int new_data_index = 0;
			if (!stack_empty()) {
				new_data_index = stack_pop();
			}
			else {
				new_data_index = last_unused++;
				if (last_unused == len) {
					kprintf("Disaster in static allocator!!!\n");
					while (true)
						{}
				}
			}
			return &data_vec[new_data_index];
		}

		void free(void *ptr) {
			uint32 data_index = ((uint8 *)data_vec - (uint8 *)ptr) / elem_size;
			stack_push(data_index);
		}

		uint32 stack_pop() {
			return free_stack[stack_end--];
		}

		void stack_push(uint32 data_index) {
			free_stack[stack_end++] = data_index;
		}

		bool stack_empty() {
			return !stack_end;
		}
	};
}

#endif