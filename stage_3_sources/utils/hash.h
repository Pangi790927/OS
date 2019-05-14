#ifndef HASH_H
#define HASH_H

#include "Types.h"

namespace util
{
	const uint32 fnv_prime = (1 << 24) + (1 << 8) + 0x93;
	const uint32 fnv_off_base = 2166136261;

	inline uint32 fnv_1a (uint8 *data, uint32 len) {
		uint32 hash = fnv_off_base;
		for (uint32 i = 0; i < len; i++) {
			hash = hash ^ data[i];
			hash = hash * fnv_prime;
		}
		return hash;
	}

	template <typename Index, typename Type, int size>
	struct hash_table_t {
		uint8 buffer[size][sizeof(std::pair<Index, Type>)];
		std::pair<Index, Type> *table[size];
		size_t used_size = 0;

		hash_table_t() {
			for (size_t i = 0; i < size; i++)
				table[i] = NULL;
		}

		int hash (uint8 *buff, size_t len) {
			return fnv_1a(buff, len) % size;
		}

		std::pair<Index, Type> *new_entry(int place,
				const std::pair<Index, Type>& obj)
		{
			return new (buffer[place]) std::pair<Index, Type>(obj);
		}

		int insert(const std::pair<Index, Type>& obj) {
			if (used_size == size / 2)
				return -1;
			int hash_res = hash((uint8 *)&obj.first, sizeof(obj.first));
			int tries = 10;
			while (table[hash_res] != NULL && tries) {
				if (table[hash_res]->first == obj.first)
					return -1;
				hash_res = hash((uint8 *)&hash_res, sizeof(hash_res));
				tries--;
			}
			if (table[hash_res] != NULL)
				return -1;
			table[hash_res] = new_entry(hash_res, obj);
			used_size++;
			return 0;
		}

		std::pair<Index, Type> *find (const Index& ind) {
			int hash_res = hash((uint8 *)&ind, sizeof(ind));
			int tries = 10;
			while (table[hash_res] && table[hash_res]->first != ind && tries) {
				hash_res = hash((uint8 *)&hash_res, sizeof(hash_res));
				tries--;
			}
			if (!table[hash_res])
				return NULL;
			if (table[hash_res]->first != ind)
				return NULL;
			return table[hash_res];
		}

		~hash_table_t() {
			using PairType = std::pair<Index, Type>;
			for (size_t i = 0; i < size; i++)
				if (table[i])
					table[i]->~PairType();
		}
	};
}

#endif