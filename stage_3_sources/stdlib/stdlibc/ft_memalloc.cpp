#include "libft.h"

void	*memalloc(size_t size)
{
	void	*ptr;
	size_t	index;

	ptr = malloc(size);
	if (ptr == NULL)
		return (NULL);
	index = 0;
	while (index < size)
	{
		*((char *)ptr + index) = '\0';
		index++;
	}
	return (ptr);
}
