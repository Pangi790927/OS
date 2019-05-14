#include "libft.h"

extern "C" size_t	strlen(const char *str)
{
	size_t size;

	size = 0;
	while (str[size])
	{
		size++;
	}
	return (size);
}
