#include "libft.h"

extern "C" int	strcmp(const char *str1, const char *str2)
{
	int	i;

	i = 0;
	while (str1[i] && str2[i] && str1[i] == str2[i])
		i++;
	if (str1[i] == 0 && str2[i] == 0)
		return (0);
	if (str1[i] == 0 && str2[i] != 0)
		return ((unsigned char)str2[i] * (-1));
	if (str1[i] != 0 && str2[i] == 0)
		return ((unsigned char)str1[i]);
	if (str1[i] != 0 && str2[i] != 0)
		return ((unsigned char)str1[i] - (unsigned char)str2[i]);
	return (0);
}
