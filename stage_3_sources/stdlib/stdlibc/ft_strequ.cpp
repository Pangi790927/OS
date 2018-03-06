#include "libft.h"

int	strequ(char const *s1, char const *s2)
{
	size_t	index;

	if (s1 == NULL && s2 == NULL)
		return (1);
	if (s1 == NULL || s2 == NULL)
		return (0);
	index = 0;
	while (s1[index] == s2[index] && s1[index] != '\0' && s2[index] != '\0')
		index++;
	if (s1[index] == '\0' && s2[index] == '\0')
		return (1);
	return (0);
}
