#include "libft.h"

extern "C" char	*strdup(const char *s)
{
	char	*new_str;
	int		i;

	i = 0;
	while (*(s + i) != '\0')
		i++;
	new_str = (char *)malloc(sizeof(char) * (i + 1));
	if (new_str == NULL)
		return (NULL);
	i = 0;
	while (*(s + i) != '\0')
	{
		*(new_str + i) = *(s + i);
		i++;
	}
	*(new_str + i) = '\0';
	return (new_str);
}
