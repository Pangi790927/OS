#include "libft.h"

char	*strnew(size_t size)
{
	char	*ptr;
	size_t	index;

	ptr = (char *)malloc((size + 1) * sizeof(char));
	if (ptr == NULL)
		return (NULL);
	index = 0;
	while (index < size + 1)
	{
		ptr[index] = '\0';
		index++;
	}
	return (ptr);
}
