#include "libft.h"

extern "C" char	*strmapi(char const *s, char (*f)(unsigned int, char))
{
	size_t	size;
	size_t	index;
	char	*mapped;

	if (s == NULL)
		return (NULL);
	size = 0;
	while (s[size] != '\0')
		size++;
	mapped = (char *)malloc(sizeof(char) * (size + 1));
	if (mapped == NULL)
		return (NULL);
	index = 0;
	while (index < size)
	{
		mapped[index] = (*f)((unsigned int)index, s[index]);
		index++;
	}
	mapped[index] = '\0';
	return (mapped);
}
