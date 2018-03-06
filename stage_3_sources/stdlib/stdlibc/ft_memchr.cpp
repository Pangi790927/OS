#include "libft.h"

void	*memchr(const void *s, int c, size_t n)
{
	size_t			i;
	unsigned char	chr;
	unsigned char	*p;

	p = (unsigned char *)s;
	chr = (unsigned char)c;
	i = 0;
	while (i < n)
	{
		if (*(unsigned char *)(p + i) == chr)
		{
			return (p + i);
		}
		i++;
	}
	return (NULL);
}
