#ifndef DEV_IF_HELPER_H
#define DEV_IF_HELPER_H

#include "types.h"

inline void *operator new(size_t, void *p)     throw() { return p; }
inline void *operator new[](size_t, void *p)   throw() { return p; }
inline void  operator delete  (void *, void *) throw() { };
inline void  operator delete[](void *, void *) throw() { };

/* this instance will should be mainly used to hold vtables
obs: underlying address should be alligned */
// template <typename Type>
// struct obj_instance {
// 	char buff[sizeof(Type) + 16];

// 	void init() {
// 		new (get()) Type{};
// 	}

// 	void uninit() {
// 		get()->~Type();
// 	}

// 	Type *get() {
// 		uint32_t addr = (uint32_t)buff;
// 		if (addr % 16 == 0)
// 			return (Type *)buff;
// 		else
// 			return (Type *)(16 - addr % 16 + buff);
// 	}
// };

// template <typename Type>
// obj_instance<Type> *alloc_instance(alloc_fn_t alloc) {
// 	auto *objp = (obj_instance<Type> *)alloc(sizeof(obj_instance<Type>));
// 	if (!objp)
// 		return NULL;
// 	objp->init();
// 	return objp;
// }

/* alloc obj assumes alignment 16 of the return of alloc */
template <typename Type>
Type *alloc_obj(alloc_fn_t alloc) {
	auto *objp = (Type *)alloc(sizeof(Type));
	if (!objp)
		return NULL;
	new (objp) Type{};
	return objp;
}

// template <typename Type>
// void free_instance(free_fn_t free, obj_instance<Type> *t) {
// 	t->uninit();
// 	free(t);
// }

template <typename Type>
void free_obj(free_fn_t free, Type *t) {
	t->~Type();
	free(t);
}

#endif