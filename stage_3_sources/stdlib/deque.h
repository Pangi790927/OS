#ifndef DEQUE_H
#define DEQUE_H

#include <initializer_list>
#include "memory.h"
#include "utility.h"

namespace std
{
	template <typename Type>
	class __dequeNode {
	public:
		Type data;
		std::shared_ptr<__dequeNode<Type>> next;
		std::shared_ptr<__dequeNode<Type>> prev;

		__dequeNode () {}
		__dequeNode (const Type& data) : data(data) {}
	};

	template <typename Type>
	class deque {
	public:
		class iterator {
		public:
			std::shared_ptr<__dequeNode<Type>> ptr;

			iterator (std::shared_ptr<__dequeNode<Type>> ptr
					= nullptr) : ptr(ptr) {}

			iterator& operator = (std::shared_ptr<__dequeNode<Type>> ptr) {
				this->ptr = ptr;
			}

			operator std::shared_ptr<__dequeNode<Type>> () {
				return ptr;
			}

			iterator& operator ++ () {
				if (ptr)
					ptr = ptr->next;
				return (*this);
			}

			iterator& operator -- () {
				if (ptr)
					ptr = ptr->prev;
				return (*this);
			}

			iterator operator ++ (int) {
				auto orig = (*this);
				if (ptr)
					ptr = ptr->next;
				return orig;
			}

			iterator operator -- (int) {
				auto orig = (*this);
				if (ptr)
					ptr = ptr->prev;
				return orig;
			}

			Type* operator -> () const {
				return &(ptr.get()->data);
			}

			Type& operator * () const {
				return ptr->data;
			}

			bool operator == (const iterator& other) {
				return other.ptr == ptr;
			}

			bool operator != (const iterator& other) {
				return other.ptr != ptr;
			}
		};

		std::shared_ptr<__dequeNode<Type>> start;
		std::shared_ptr<__dequeNode<Type>> stop;
		size_t count = 0;

		deque () {}
		deque (std::initializer_list<Type> list) {
			for (auto&& elem : list)
				push_back(elem);
		}
		
		deque (const deque& other) {
			iterator it = other.begin();
			while (*it) {
				push_back(it->data);
				it++;
			}
		}

		deque (const deque&& other) {
			start = std::move(other.start);
			stop = std::move(other.stop);
		}

		deque& operator = (const deque& other) {
			iterator it = other.begin();
			while (*it) {
				push_back(it->data);
				it++;
			}
		}

		deque& operator = (const deque&& other) {
			start = std::move(other.start);
			stop = std::move(other.stop);
			count = std::move(other.count);	
		}

		~deque () {
			while (!empty())
				pop_back();
		}

		size_t size() {
			return count;
		}

		bool empty() {
			return count == 0;
		}

		void insert (iterator it, const Type& value) {
			count++;
		}

		void erase (iterator it) {
			if (start == it) {
				pop_front();
				return ;
			}
			else if (stop == it) {
				pop_back();
				return ;
			}
			if (it->next)
				it->next->prev = it->prev;
			if (it->prev)
				it->prev->next = it->next;
			it->next = (it->prev = nullptr);

			count--;
		}
		
		void push_back (const Type& value) {
			if (!start) {
				start = (stop = std::shared_ptr<__dequeNode<Type>>(
					new __dequeNode<Type>(value)));
			}
			else {
				auto newNode = std::shared_ptr<__dequeNode<Type>>(
					new __dequeNode<Type>(value));
				stop->next = newNode;
				newNode->prev = stop;
				stop = newNode;
			}
			count++;
		}
		
		void push_front (const Type& value) {
			if (!start) {
				start = (stop = std::shared_ptr<__dequeNode<Type>>(
					new __dequeNode<Type>(value)));
			}
			else {
				auto newNode = std::shared_ptr<__dequeNode<Type>>(
					new __dequeNode<Type>(value));
				start->prev = newNode;
				newNode->next = start;
				start = newNode;
			}
			count++;
		}
		
		void pop_back() {
			if (start == stop) {
				start = (stop = nullptr);
				if (start) {
					start->next = nullptr;
					start->prev = nullptr;
				}
			}
			
			if (stop) {
				stop = stop->prev;
				stop->next->prev = nullptr;
				stop->next = nullptr;	/// this should delete last node
			}
			count--;
		}

		void pop_front() {
			if (start == stop) {
				if (start) {
					start->next = nullptr;
					start->prev = nullptr;
				}
				start = (stop = nullptr);
			}

			if (start) {
				start = start->next;
				if (start->next) {
					start->prev->next = nullptr;
					start->prev = nullptr;
				}
				// printf("%x\n", start);printf("%x\n", stop);
			}
			count--;
		}

		iterator begin() {
			return iterator(start);
		}
		
		iterator end() {
			return iterator(nullptr);
		}

		Type& front() {
			return start->data;
		}

		Type& back() {
			return stop->data;
		}
	};
}

#endif