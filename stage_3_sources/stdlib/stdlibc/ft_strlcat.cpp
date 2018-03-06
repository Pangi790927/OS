#include "libft.h"

size_t	strlcat(char *dest, const char *src, size_t size)
{
	size_t i;
	size_t dest_size;
	size_t src_size;

	src_size = strlen(src);
	i = 0;
	while (dest[i] != '\0')
	{
		if (i >= size)
			return (src_size + size);
		i++;
	}
	dest_size = i;
	i = 0;
	while (dest_size + 1 + i < size && src[i] != '\0')
	{
		dest[dest_size + i] = src[i];
		i++;
	}
	if (i + dest_size < size)
		dest[dest_size + i] = '\0';
	return (dest_size + src_size);
}
