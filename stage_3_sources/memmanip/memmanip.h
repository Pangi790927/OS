
#ifndef MEMMANIP_H
#define MEMMANIP_H

#include "Types.h"
#include "stdio.h"

namespace memmanip
{
	const uint32 MIN_CHUNK_SIZE = sizeof(uint32) * 2 + sizeof(void *) * 2;
	const uint32 ALIGNMENT = 4;
	const uint32 FREE_BIT = 0x80'00'00'00;
	const uint32 ALLCATED_BIT = 0x00'00'00'00;

	void *sbrk (uint32 size);

	void addFreeChunkTags (void *ptr, uint32 size, void *next, void *prev);
	void init (void *buffer);
	void addFreeChunkTags (void *ptr, uint32 wordCount, void *next, void *prev);
	void addAllocChunkTags (void *ptr, uint32 wordCount);
	uint32 getSize (void *ptr);
	bool getFreeStatus (void *ptr);
	void *getNext (void *ptr);
	void *getPrev (void *ptr);
	void setNext (void *ptr, void *next);
	void setPrev (void *ptr, void *prev);
	void setFreeStatus (void *ptr, uint32 status);
	void *malloc (uint32 size);
	void freeChunk (void *chunkPtr, uint32 size);
	void free (void *ptr);
	void printMemory();
}

void *malloc (size_t size);
void free (void *ptr);

void *operator new (size_t count);
void *operator new [] (size_t count);
void operator delete (void* ptr);
void operator delete [] (void* ptr);

#endif