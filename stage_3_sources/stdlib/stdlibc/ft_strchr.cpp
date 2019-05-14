#include "libft.h"

extern "C" char	*strchr(const char *s, int c)
{
	unsigned int	index;
	char			*tmp;

	index = 0;
	while (s[index])
	{
		if (s[index] == (char)c)
		{
			tmp = (char *)&(s[index]);
			return (tmp);
		}
		index++;
	}
	if (s[index] == c)
	{
		return (char *)&(s[index]);
	}
	return (NULL);
}
