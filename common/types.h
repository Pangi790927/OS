#ifndef TYPES_H
#define TYPES_H

typedef	unsigned	char		uint8_t;
typedef	unsigned	short		uint16_t;
typedef	unsigned	int			uint32_t;
typedef	unsigned	long long	uint64_t;

typedef				char		int8_t;
typedef				short		int16_t;
typedef				int			int32_t;
typedef				long long	int64_t;

typedef	unsigned	int			size_t;
typedef	unsigned	int			uint;

static_assert(sizeof(uint8_t) == 1, "type sizes mismatch");
static_assert(sizeof(uint16_t) == 2, "type sizes mismatch");
static_assert(sizeof(uint32_t) == 4, "type sizes mismatch");
static_assert(sizeof(uint64_t) == 8, "type sizes mismatch");

static_assert(sizeof(int8_t) == 1, "type sizes mismatch");
static_assert(sizeof(int16_t) == 2, "type sizes mismatch");
static_assert(sizeof(int32_t) == 4, "type sizes mismatch");
static_assert(sizeof(int64_t) == 8, "type sizes mismatch");

#define NULL (0)

using alloc_fn_t = void *(*)(size_t);
using free_fn_t = void (*)(void *);

#endif
