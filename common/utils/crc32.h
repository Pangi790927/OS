#ifndef CRC32_H
#define CRC32_H

inline uint32_t crc32(char *data, uint32_t len) {
	uint32_t crc = 0xffff'ffff;
	for (uint32_t i = 0; i < len; i++) {
		uint32_t byte = data[i];
		crc = crc ^ byte;
		for (int j = 7; j >= 0; j--) {
			uint32_t mask = -(crc & 1);
			crc = (crc >> 1) ^ (0xEDB88320 & mask);
		}
	}
	return ~crc;
}

#endif