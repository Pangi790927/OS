#ifndef DEV_IF_HELPER_H
#define DEV_IF_HELPER_H

#include "types.h"

inline void *operator new(size_t, void *p)     throw() { return p; }
inline void *operator new[](size_t, void *p)   throw() { return p; }
inline void  operator delete  (void *, void *) throw() { };
inline void  operator delete[](void *, void *) throw() { };

/* this instance will should be mainly used to hold vtables */
template <typename Type>
struct if_instance {
	char buff[sizeof(Type) + 16];

	void init() {
		new (get()) Type{};
	}

	void uninit() {
		get()->~Type();
	}

	Type *get() {
		uint32_t addr = (uint32_t)buff;
		if (addr % 16 == 0)
			return (Type *)buff;
		else
			return (Type *)(16 - addr % 16 + buff);
	}
};


#endif