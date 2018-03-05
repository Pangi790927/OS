#ifndef MEMALLOC_H
#define MEMALLOC_H

#include "type.h"

struct Node {
	void *offset;
	size_t size;
	Node *prev = NULL, *next = NULL;

	Node (void *offset, size_t size)
	: offset(offset), size(size) {}
};

namespace memalloc
{
	Node *rootFree;
	Node *rootAlloc;

	void addAllocNode (Node *node) {
		Node *currNode = rootAlloc;

		while (currNode) {
			
		}
	}

	void detachAllocNode (Node *node) {
		// TO DO:
	}

	void addFreeNode (Node *node) {
		// TO DO:
	}

	void detachFreeNode (Node *node) {
		// TO DO:
	} 

	void malloc_init (void *buffer, size_t size) {
		*((Node *)buffer) = Node(buffer + sizeof(Node), size - sizeof(Node));
		rootFree = buffer;
		rootAlloc = NULL;
	}

	void *malloc (size_t size) {
		size_t toAlloc = size + sizeof(Node); 
		Node *node = rootFree;
		while (node) {
			if (node->size < toAlloc) {
				*((Node *)node->offset) = Node(node->offset, toAlloc);
				Node *allocNode = node->offset;
				addAllocNode(allocNode);
				node->offset = node->offset + toAlloc;
				node->size -= toAlloc;
				if (node->size == 0)
					detachFreeNode(node);
				return (allocNode->offset + sizeof(Node));
			}
			node = node->next;
		}
		return NULL;
	}

	void free (void *ptr) {
		Node *node = rootAlloc;

		while (node) {
			if (node->offset + sizeof(Node) == ptr) {
				detachAllocNode(node->offset);
				*((Node *)node->offset) = Node(node->offset + sizeof(Node),
							node->size - sizeof(Node));
				addFreeNode(node->offset);
				return ;
			}
			node = node->next;
		}
		printf("Bad free\n");
	}
}


void *malloc (size_t size) {
	return memalloc::malloc(size);
}

void free (void *ptr) {
	memalloc::free(size);
}

#endif