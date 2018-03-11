#ifndef MEMORY_H
#define MEMORY_H

#include "utility.h"

namespace std
{
	template <typename Type>
	struct default_deleter {
		void operator() (Type* dataPtr) const {
			delete dataPtr;
		}
	};

	template <typename Type, typename Deleter = default_deleter<Type>>
	class shared_ptr {
	public:
		struct Storage {
			int count = 0;

			Type *dataPtr = NULL;
			Deleter deleter;

			Storage (Type *dataPtr, Deleter deleter) : dataPtr(dataPtr),
					deleter(deleter) {}

			void dec () {
				if (count == 1)
					if (dataPtr != NULL)
						deleter(dataPtr);
				count--;
			}

			void inc() {
				count++;
			}
		};

		Storage *storagePtr = NULL;

		shared_ptr() {}
		shared_ptr (nullptr_t) {}

		shared_ptr (Type *dataPtr, Deleter deleter = Deleter()) {
			storagePtr = new Storage(dataPtr, deleter);
			inc();
		}

		shared_ptr (const shared_ptr& other) {
			storagePtr = other.storagePtr;
			inc();
		}

		shared_ptr (const shared_ptr&& other) {
			storagePtr = other.storagePtr;
			inc();
		}

		void dec() {
			if (storagePtr)
				storagePtr->dec();
			if (storagePtr && storagePtr->count == 0) {
				delete storagePtr;
			}
			storagePtr = NULL;
		}

		void inc() {
			if (storagePtr)
				storagePtr->inc();
		}

		shared_ptr& operator = (const shared_ptr& other) {
			dec();
			storagePtr = other.storagePtr;
			inc();
			return (*this);
		} 

		shared_ptr& operator = (const shared_ptr&& other) {
			dec();
			storagePtr = other.storagePtr;
			inc();
			return (*this);
		}

		shared_ptr& operator = (nullptr_t) {
			dec();
			storagePtr = nullptr;
			return (*this);
		} 

		operator bool () {
			if (storagePtr)
				return storagePtr->dataPtr != NULL;
			return false;
		}

		Type* get() const {
			if (storagePtr)
				return storagePtr->dataPtr;
			return NULL;
		}

		Type* operator -> () const {
			if (storagePtr)
				return storagePtr->dataPtr;
			return NULL;
		}

		Type& operator * () const {
			if (storagePtr)
				return *(storagePtr->dataPtr);
		}

		~shared_ptr() {
			dec();
		}

		bool operator == (const shared_ptr& other) const {
			return get() == other.get();
		}

		bool operator != (const shared_ptr& other) const {
			return get() != other.get();
		}
	};

	template <typename Type, typename Deleter = default_deleter<Type>>
	class unique_ptr {
	public:
		Type *ptr = NULL;
		Deleter deleter;

		unique_ptr() {}
		unique_ptr (Type *ptr, Deleter deleter = Deleter()) : ptr(ptr),
				deleter(deleter) {}

		unique_ptr (const unique_ptr& other) = delete;
		unique_ptr& operator = (const unique_ptr& other) = delete;
		
		unique_ptr (const unique_ptr&& other) {
			ptr = std::move(ptr);
			deleter = std::move(deleter);
		}

		unique_ptr& operator = (const unique_ptr&& other) {
			ptr = std::move(ptr);
			deleter = std::move(deleter);
			return (*this);
		}

		~unique_ptr() {
			if (ptr)
				deleter(ptr);
		}

		Type* operator -> () const {
			return ptr;
		}

		Type& operator * () const {
			return *ptr;
		}

		operator bool () {
			return ptr != NULL;
		}

		bool operator == (const unique_ptr& other) {
			return other.ptr == ptr;
		}

		bool operator != (const unique_ptr& other) {
			return other.ptr != ptr;
		}

		Type* get() {
			return *ptr;
		}
	};
}

#endif