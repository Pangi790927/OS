#include "memmanip.h"
#include "algorithm.h"

void *operator new (size_t size, void *p) { 
	return p; 
}

void *operator new [] (size_t size, void *p) {
	return p; 
}

void  operator delete (void *, void *) {

};

void  operator delete [] (void *, void *) {

};

void *operator new (size_t count) {
	return malloc(count);
}

void *operator new [] (size_t count) {
	return malloc(count);	
}

void operator delete (void* ptr) {
    free(ptr);
}

void operator delete [] (void* ptr) {
    free(ptr);
}

void operator delete (void* ptr, size_t) {
    free(ptr);
}

void operator delete [] (void* ptr, size_t) {
    free(ptr);
}

void *malloc (size_t size) {
	return memmanip::malloc(size);
}

void free (void *ptr) {
	memmanip::free(ptr);
}

namespace memmanip
{
	void *start;
	void *end;

	void *firstFree;
	void *lastFree;
}

void *memmanip::sbrk (uint32 size) {
	void *ret = end;
	end = (char *)end + size;
	return ret;
}

void memmanip::init (void *buffer) {
	start = end = buffer;	// this enables sbrk
	addFreeChunkTags(firstFree = lastFree = sbrk(MIN_CHUNK_SIZE), 
			MIN_CHUNK_SIZE / ALIGNMENT, NULL, NULL);
}

void memmanip::addFreeChunkTags (void *ptr, uint32 wordCount,
			void *next, void *prev)
{
	*(uint32 *)ptr = wordCount | FREE_BIT;
	*(void **)((char *)ptr + sizeof(uint32)) = next;
	*(void **)((char *)ptr + sizeof(uint32) + sizeof(void *)) = prev;
	*(uint32 *)((char *)ptr + wordCount * ALIGNMENT - sizeof(uint32)) = wordCount | FREE_BIT;
}

void memmanip::addAllocChunkTags (void *ptr, uint32 wordCount) {
	*(uint32 *)((char *)ptr + wordCount * ALIGNMENT - sizeof(uint32)) =
			wordCount | ALLCATED_BIT;
	*(uint32 *)ptr = wordCount | ALLCATED_BIT;
	*(uint32 *)((char *)ptr + sizeof(uint32)) = 0x33;
	*(uint32 *)((char *)ptr + sizeof(uint32) + sizeof(void *)) = 0x33;
}

uint32 memmanip::getSize (void *ptr) {
	return ((*(uint32 *)ptr) & ~(FREE_BIT)) * ALIGNMENT;
}

bool memmanip::getFreeStatus (void *ptr) {
	return (*(uint32 *)ptr) & FREE_BIT;
}

void *memmanip::getNext (void *ptr) {
	return *(void **)((char *)ptr + sizeof(uint32));
}

void *memmanip::getPrev (void *ptr) {
	return *(void **)((char *)ptr + sizeof(uint32) + sizeof(void *));	
}

void memmanip::setNext (void *ptr, void *next) {
	*(void **)((char *)ptr + sizeof(uint32)) = next;	
}

void memmanip::setPrev (void *ptr, void *prev) {
	*(void **)((char *)ptr + sizeof(uint32) + sizeof(void *)) = prev;	
}

void *memmanip::malloc (uint32 size) {
	size = (size + ALIGNMENT - 1) & -ALIGNMENT;
	size += sizeof(uint32) * 2;
	size = std::max(size, MIN_CHUNK_SIZE);
	for (void *current = firstFree; current; current = getNext(current)) {
		uint32 chunk_size = 0;
		if ((chunk_size = getSize(current)) >= size) {
			if (chunk_size <= size + MIN_CHUNK_SIZE) {
				// will use current as allocated
				removeNode(current);

				addAllocChunkTags(current, getSize(current) / ALIGNMENT);
				return (char *)current + sizeof(uint32);
			}
			else {
				// will split current in free and allocated
				void *freePart = (char *)current + size;

				removeNode(current);
				addFreeChunkTags(freePart, (chunk_size - size) / ALIGNMENT, NULL, NULL);
				pushNode(freePart);
				
				addAllocChunkTags(current, size / ALIGNMENT);

				return (char *)current + sizeof(uint32);
			}
		}
	}
	// at this point we couldn't get a free chunk with enough memory
	void *result = NULL;
	addAllocChunkTags(result = sbrk(size), size / ALIGNMENT);

	return (char *)result + sizeof(uint32);
}

void memmanip::removeNode (void *node) {
	if (!node)
		return ;

	if (getPrev(node))
		setNext(getPrev(node), getNext(node));
	if (getNext(node))
		setPrev(getNext(node), getPrev(node));

	if (lastFree == node)
		lastFree = getPrev(node);
	if (firstFree == node)
		firstFree = getNext(node);
}

void memmanip::pushNode (void *node) {
	if (lastFree) {
		setNext(lastFree, node);
		setPrev(node, lastFree);
		lastFree = node;
	}
	else {
		lastFree = firstFree = node;
		setNext(node, NULL);
		setPrev(node, NULL);
	}
}

void memmanip::freeChunk (void *chunkPtr, uint32 size, bool isNode) {
	if ((char *)chunkPtr - sizeof(uint32) > start) {
		uint32 sizeLeft = *(uint32 *)((char *)chunkPtr - sizeof(uint32));
		if (sizeLeft & FREE_BIT) {
			// we expand this chunck with the left one) 
			void *leftChunk = (char *)chunkPtr - (sizeLeft & ~FREE_BIT) * ALIGNMENT;
			uint32 newSize = (getSize(leftChunk) + size);

			if (isNode)
				removeNode(chunkPtr);
			removeNode(leftChunk);
			addFreeChunkTags(leftChunk, newSize / ALIGNMENT, NULL, NULL);
			pushNode(leftChunk);

			freeChunk(leftChunk, newSize, true);
			return ;
		}
	}
	if (*(uint32 *)((char *)chunkPtr + size) & FREE_BIT) {
		// we expand this chunk with the right one 
		void *rightChunk = (char *)chunkPtr + size;
		uint32 sizeRight = getSize(rightChunk);
		uint32 newSize = (sizeRight + size);

		if (isNode)
			removeNode(chunkPtr);
		removeNode(rightChunk);
		addFreeChunkTags(chunkPtr, newSize / ALIGNMENT, NULL, NULL);
		pushNode(chunkPtr);
		
		freeChunk(chunkPtr, newSize, true);
		return ;
	}
	if (isNode)
		return ;
	addFreeChunkTags(chunkPtr, size / ALIGNMENT, NULL, lastFree);
	pushNode(chunkPtr);
}

void memmanip::free (void *ptr) {
	void *chunkPtr = (char *)ptr - sizeof(uint32);
	if (getFreeStatus(chunkPtr)) {
		printf("Bad free, %p, %d\n", chunkPtr, (uint32)((char *)chunkPtr -
				(char *)start));
		return ;
	}
	uint32 size = getSize(chunkPtr);
	freeChunk(chunkPtr, size);
}

void memmanip::printMemory() {
	printf("(count, offset, size, free, next, prev); first: %x last: %x\n", firstFree, lastFree);	
	void *current = start;
	int count = 1;
	while (current < end) {
		printf("(%d, %d, %d, %d, %x, %x)\n",
				count++, (uint32)((char *)current - (char *)start), 
				getSize(current), (uint32)getFreeStatus(current),
				getNext(current), getPrev(current));
		
		if (getSize(current) == 0) {
			printf("Bad chunk\n");
			return ;
		}
		current = (char *)current + getSize(current);
	}
}