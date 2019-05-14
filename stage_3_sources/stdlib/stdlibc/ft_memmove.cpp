#include "libft.h"

extern "C" void	*memmove(void *dest, const void *src, size_t n)
{
	size_t i;

	if (dest > src && dest < (char *)src + n)
	{
		i = n - 1;
		while (i >= (size_t)((char *)dest - (char *)src))
		{
			*((char *)dest + i) = *((char *)src + i);
			i--;
		}
		n = (char *)dest - (char *)src;
	}
	i = 0;
	while (i < n)
	{
		*((char *)dest + i) = *((char *)src + i);
		i++;
	}
	return (dest);
}
