#ifndef BITMAP_H
#define BITMAP_H

struct Bitmap {
	uint8_t *addr = NULL;
	uint32_t byte_cnt = 0;
	uint32_t start = 0;

	Bitmap(char *addr = 0, uint32_t byte_cnt = 0, uint32_t start = 0)
	: addr((uint8_t *)addr), byte_cnt(byte_cnt), start(start) {}

	void reset() {
		for (uint32_t i = 0; i < byte_cnt; i++)
			addr[i] = 0;
	}

	bool get(int index) const {
		index -= start;
		if (!valid_index(index))
			return false;
		uint8_t bit_index = index & 0x7;
		uint32_t glob_index = index >> 3;
		return addr[glob_index] & (1 << (bit_index));
	}

	void set(int index, bool val) {
		index -= start;
		if (!valid_index(index))
			return ;
		uint8_t bit_index = index & 0x7;
		uint32_t glob_index = index >> 3;
		addr[glob_index] = (addr[glob_index] & ~(1 << (bit_index))) |
				(val << (bit_index));
	}

	int get_first_free() const {
		if (!addr)
			return -1;
		for (uint32_t i = 0; i < byte_cnt; i++) {
			if (addr[i] != 0xff) {
				for (int j = 0; j < 8; j++) {
					if (!((1 << (j)) & addr[i])) {
						return i * 8 + j + start;
					}
				}
			}
		}
		return -1;
	}

	bool valid_index(int index) const {
		if (!addr)
			return false;
		if (index < 0 || (uint32_t)index / 8 >= byte_cnt)
			return false;
		return true;
	}

	// std::string to_string() const {
	// 	char cstr[byte_cnt * 8 + byte_cnt + byte_cnt / 8 + 1]{0};
	// 	for (int i = 0, j = 0; j < byte_cnt * 8;) {
	// 		if (j % 64 == 0 && j != 0)
	// 			cstr[i++] = '\n';
	// 		if (j % 8 == 0 && j % 64 != 0)
	// 			cstr[i++] = '\'';
	// 		cstr[i++] = '0' + get(j++);
	// 	}
	// 	return cstr;
	// }
};

#endif
