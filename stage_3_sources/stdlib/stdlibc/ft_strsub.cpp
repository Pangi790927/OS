#include "libft.h"

extern "C" char	*strsub(char const *s, unsigned int start, size_t len)
{
	char	*str;
	size_t	index;

	if (s == NULL)
		return (NULL);
	str = (char *)malloc(sizeof(char) * (len + 1));
	if (str == NULL)
		return (NULL);
	index = 0;
	while (index < len)
	{
		str[index] = s[start + index];
		index++;
	}
	str[index] = '\0';
	return (str);
}
