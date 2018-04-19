#ifndef VECTOR_H
#define VECTOR_H

#include <initializer_list>
#include "algorithm.h"
#include "utility.h"
#include "libft.h"

namespace std
{
	template <class Type>
	class vector {
		static const size_t min_add = std::max(sizeof(void *) * 4, sizeof(Type) * 4);

		uint8 *buffer = NULL;
		size_t count = 0;
		size_t containerSize = 0;

		Type *allocAt (unsigned int index);
		void freeAt (unsigned int index);

	public:
		typedef Type* iterator;
		
		vector();
		vector (std::initializer_list<Type> list);
		vector (size_t count);
		vector (size_t count, const Type &initial);
		vector (const vector<Type> &other);
		vector (const vector<Type> &&other);

		vector<Type> & operator=(const vector<Type> &other);
		vector<Type> & operator=(const vector<Type> &&other);

		Type& operator [] (unsigned int index);

		iterator begin();
		iterator end();

		Type& front();
		Type& back();

		void push_back (const Type &toInsert);
		void pop_back();

		size_t capacity();
		size_t size();
		bool empty();

		void reserve (size_t capacity);
		void resize (size_t size, const Type& value  = Type());

		void clear();

		~vector();
	};
}

template <typename Type>
std::vector<Type>::vector() {}

template <typename Type>
std::vector<Type>::vector (std::initializer_list<Type> list) {
	for (auto&& elem : list)
		push_back(elem);
}

template <typename Type>
std::vector<Type>::vector (size_t count) : count(count) {
	reserve(count * sizeof(Type) + std::max(min_add, count * sizeof(Type) / 2));
	for (size_t i = 0; i < count; i++)
		allocAt(i);
}

template <typename Type>
std::vector<Type>::vector (size_t count, const Type &initial) : count(count) {
	reserve(count * sizeof(Type) + std::max(min_add, count * sizeof(Type) / 2));
	for (size_t i = 0; i < count; i++) 
		*(Type *)allocAt(i) = initial;
}

template <typename Type>
std::vector<Type>::vector (const vector<Type>& other) : count(other.count) {
	reserve(other.containerSize);
	memcpy(buffer, other.buffer, containerSize);
}

template <typename Type>
std::vector<Type>::vector (const vector<Type>&& other) : count(other.count) {
	reserve(other.containerSize);
	memcpy(buffer, other.buffer, containerSize);
}

template <typename Type>
std::vector<Type> &std::vector<Type>::operator = (const vector<Type> &other) {
	clear();
	count = other.count;
	reserve(other.containerSize);
	memcpy(buffer, other.buffer, count * sizeof(Type));
	return (*this);
}

template <typename Type>
std::vector<Type> &std::vector<Type>::operator = (const vector<Type> &&other) {
	clear();
	count = other.count;
	reserve(other.containerSize);
	memcpy(buffer, other.buffer, count * sizeof(Type));
	return (*this);
}

template <typename Type>
std::vector<Type>::~vector() {
	clear();
}

template <typename Type>
Type *std::vector<Type>::allocAt (unsigned int index) {
	return new ((Type *)((uint8 *)buffer + index * sizeof(Type))) Type();
}

template <typename Type>
void std::vector<Type>::freeAt (unsigned int index) {
	Type *ptr = (Type *)((uint8 *)buffer + index * sizeof(Type));
	ptr->~Type();
	// delete (ptr, ptr); not usefull and I don't really know how to use it anyway
}

template <typename Type>
void std::vector<Type>::reserve (size_t capacity) {
	uint8 *newBuffer = new uint8 [containerSize + capacity];

	if (buffer) {
		memcpy(newBuffer, buffer, count * sizeof(Type));
		delete [] buffer;
	}

	buffer = newBuffer;
	containerSize = containerSize + capacity;
}

template <typename Type>
void std::vector<Type>::clear () {
	for (size_t i = 0; i < count; i++)
		freeAt(i);
	count = 0;
	containerSize = 0;
	delete [] buffer;
	buffer = NULL;
}

template <typename Type>
void std::vector<Type>::resize (size_t size, const Type &value) {
	if (size * sizeof(Type) >= containerSize) {
		reserve((size - count) * sizeof(Type) +
				std::max(min_add, (size - count) * sizeof(Type) / 2));
	}
	
	if (size < count) {
		for (size_t i = size; i < count; i++)
			freeAt(i);
	}
	else {
		for (size_t i = count; i < size; i++)
			*(Type *)allocAt(i) = value;
	}
	count = size;
}

template <typename Type>
void std::vector<Type>::push_back (const Type &toInsert) {
	resize(count + 1);
	back() = toInsert;
}

template <typename Type>
void std::vector<Type>::pop_back() {
	resize(count - 1);
}

template <typename Type>
Type &std::vector<Type>::operator [] (unsigned int index) {
	return ((Type *)buffer)[index];
}

template <typename Type>
typename std::vector<Type>::iterator std::vector<Type>::begin() {
	return (iterator)((Type *)buffer); 
}

template <typename Type>
typename std::vector<Type>::iterator std::vector<Type>::end() {
	return (iterator)((Type *)buffer + size());
}

template <typename Type>
Type& std::vector<Type>::front() {
	return (*this)[0];
}

template <typename Type>
Type& std::vector<Type>::back() {
	return (*this)[count - 1];
}

template <typename Type>
size_t std::vector<Type>::capacity() {
	return containerSize;
}

template <typename Type>
size_t std::vector<Type>::size() {
	return count;
}

template <typename Type>
bool std::vector<Type>::empty() {
	return count == 0;
}

#endif
