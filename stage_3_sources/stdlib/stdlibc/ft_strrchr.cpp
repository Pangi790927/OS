#include "libft.h"

char	*strrchr(const char *s, int c)
{
	size_t	index;
	char	*tmp;

	tmp = NULL;
	index = 0;
	while (s[index])
	{
		if (s[index] == (char)c)
			tmp = (char *)&(s[index]);
		index++;
	}
	if (tmp != NULL)
		return (tmp);
	if (s[index] == (char)c)
		return ((char *)&(s[index]));
	return (NULL);
}
