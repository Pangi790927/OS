#include "memmanip.h"

namespace memmanip
{
	void *start;
	void *end;

	void *firstFree;
	void *lastFree;
}

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

template <typename Type>
static Type max (Type a, Type b) {
	return a > b ? a : b;
}

template <typename Type>
static Type min (Type a, Type b) {
	return a < b ? a : b;
}

void *malloc (size_t size) {
	return memmanip::malloc(size);
}

void free (void *ptr) {
	memmanip::free(ptr);
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
	*(uint32 *)((char *)ptr + wordCount * ALIGNMENT - sizeof(uint32)) =
			wordCount | FREE_BIT;
	*(uint32 *)ptr = wordCount | FREE_BIT;
	*(void **)((char *)ptr + sizeof(uint32)) = next;
	*(void **)((char *)ptr + sizeof(uint32) + sizeof(void *)) = prev;
}

void memmanip::addAllocChunkTags (void *ptr, uint32 wordCount) {
	*(uint32 *)((char *)ptr + wordCount * ALIGNMENT - sizeof(uint32)) =
			wordCount | ALLCATED_BIT;
	*(uint32 *)ptr = wordCount | ALLCATED_BIT;
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

void memmanip::setFreeStatus (void *ptr, uint32 status) {
	uint32 size = *(uint32 *)ptr & ~FREE_BIT;
	*(uint32 *)ptr = size | status;
	*(uint32 *)((char *)ptr + size * ALIGNMENT) = size | status;	
}

void *memmanip::malloc (uint32 size) {
	size = (size + ALIGNMENT - 1) & -ALIGNMENT;
	size += sizeof(uint32) * 2;
	size = max(size, MIN_CHUNK_SIZE);
	for (void *current = firstFree; current; current = getNext(current)) {
		uint32 chunk_size = 0;
		if ((chunk_size = getSize(current)) >= size) {
			if (chunk_size <= size + MIN_CHUNK_SIZE) {
				// will use current as allocated
				if (firstFree == current && lastFree == current)
					firstFree = lastFree = NULL;

				if (getPrev(current))
					setNext(getPrev(current), getNext(current));
				
				if (getNext(current))
					setNext(getNext(current), getPrev(current));

				setFreeStatus(current, ALLCATED_BIT);

				return (char *)current + sizeof(uint32);
			}
			else {
				// will split current in free and allocated
				void *freePart = (char *)current + size;

				if (getPrev(current))
					setNext(getPrev(current), freePart);
				
				if (getNext(current))
					setNext(getNext(current), freePart);

				addFreeChunkTags(freePart, (chunk_size - size) / ALIGNMENT,
						getNext(current), getPrev(current));
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

void memmanip::freeChunk (void *chunkPtr, uint32 size) {
	if ((char *)chunkPtr - sizeof(uint32) > start) {
		uint32 sizeLeft = *(uint32 *)((char *)chunkPtr - sizeof(uint32));
		if (sizeLeft & FREE_BIT) {
			// we expand the left chunk with the right one (this one) 
			void *leftChunk = (char *)chunkPtr - (sizeLeft & ~FREE_BIT) * ALIGNMENT;
			uint32 newSize = (getSize(leftChunk) + size);

			addFreeChunkTags(leftChunk, newSize / ALIGNMENT,
					getNext(leftChunk), getPrev(leftChunk));

			freeChunk(leftChunk, newSize);
			return ;
		}
	}
	if (*(uint32 *)((char *)chunkPtr + size) & FREE_BIT) {
		void *rightChunk = (char *)chunkPtr + size;
		uint32 sizeRight = getSize(rightChunk);
		uint32 newSize = (sizeRight + size);

		addFreeChunkTags(chunkPtr, newSize / ALIGNMENT, getNext(rightChunk),
			getPrev(rightChunk));
		
		freeChunk(chunkPtr, newSize);
		return ;
	}
	addFreeChunkTags(chunkPtr, size / ALIGNMENT, NULL, lastFree);
	if (lastFree) {
		setNext(lastFree, chunkPtr);
		lastFree = chunkPtr;
	}
	else {
		lastFree = firstFree = chunkPtr;
	}
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
	printf("(count, offset, size, free)\n");
	void *current = start;
	int count = 1;
	while (current < end) {
		printf("(%d, %d, %d, %d)\n",
				count++, (uint32)((char *)current - (char *)start), 
				getSize(current), (uint32)getFreeStatus(current));
		
		if (getSize(current) == 0) {
			printf("Bad chunk\n");
			return ;
		}
		current = (char *)current + getSize(current);
	}
}