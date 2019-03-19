#ifndef MMIO_H
#define MMIO_H

inline uint8 mmio_read8(void *addr) {
	return *(volatile uint8 *)addr;
}

inline uint16 mmio_read16(void *addr) {
	return *(volatile uint16 *)addr;
}

inline uint32 mmio_read32(void *addr) {
	return *(volatile uint32 *)addr;
}

inline void mmio_write8(void *addr, uint8 value) {
	*(volatile uint8 *)addr = value;
}

inline void mmio_write16(void *addr, uint16 value) {
	*(volatile uint16 *)addr = value;
}

inline void mmio_write32(void *addr, uint32 value) {
	*(volatile uint32 *)addr = value;
}

#endif