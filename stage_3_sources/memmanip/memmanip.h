
#ifndef MEMMANIP_H
#define MEMMANIP_H

#include "Types.h"
#include "stdio.h"

struct Node {
	void *offset;
	size_t size;
	Node *prev = NULL, *next = NULL;

	Node (void *offset, size_t size)
	: offset(offset), size(size) {}
};

namespace memmanip
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
		*((Node *)buffer) = Node((char *)buffer + sizeof(Node), size - sizeof(Node));
		rootFree = (Node *)buffer;
		rootAlloc = NULL;
	}

	void *malloc (size_t size) {
		size_t toAlloc = size + sizeof(Node); 
		Node *node = rootFree;
		while (node) {
			if (node->size < toAlloc) {
				*((Node *)node->offset) = Node(node->offset, toAlloc);
				Node *allocNode = (Node *)node->offset;
				addAllocNode(allocNode);
				node->offset = (char *)node->offset + toAlloc;
				node->size -= toAlloc;
				if (node->size == 0)
					detachFreeNode(node);
				return ((char *)allocNode->offset + sizeof(Node));
			}
			node = node->next;
		}
		return NULL;
	}

	void free (void *ptr) {
		Node *node = rootAlloc;

		while (node) {
			if ((char *)node->offset + sizeof(Node) == ptr) {
				detachAllocNode((Node *)node->offset);
				*((Node *)node->offset) = Node((char *)node->offset + sizeof(Node),
							node->size - sizeof(Node));
				addFreeNode((Node *)node->offset);
				return ;
			}
			node = node->next;
		}
		printf("Bad free\n");
	}
}

void *malloc (size_t size) {
	return memmanip::malloc(size);
}

void free (void *ptr) {
	memmanip::free(ptr);
}

#endif