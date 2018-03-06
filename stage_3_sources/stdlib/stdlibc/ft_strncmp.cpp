#include "libft.h"

int	strncmp(const char *str1, const char *str2, size_t num)
{
	size_t i;

	if (num == 0)
		return (0);
	i = 1;
	while (*str1 == *str2 && *str1 != 0 && *str2 != 0 && i < num)
	{
		str1++;
		str2++;
		i++;
	}
	if (*str1 == 0 && *str2 != 0)
		return (-1 * (int)(unsigned char)(*str2));
	if (*str2 == 0 && *str1 != 0)
		return (int)(unsigned char)(*str1);
	if (*str1 == *str2)
		return (0);
	return ((int)(unsigned char)(*str1) - (int)(unsigned char)(*str2));
}
