#include "libft.h"

static void	increase_shit(int *a, int *b)
{
	(*a)++;
	(*b)++;
}

static void	make_shit_zero(int *a, int *b)
{
	(*a) = 0;
	(*b) = 0;
}

static void	makejzerostartiicpyi(int *j, int *start, int *icpy, int i)
{
	(*j) = 0;
	(*start) = i;
	(*icpy) = i;
}

extern "C" char		*strstr(const char *haystack, const char *needle)
{
	int		i;
	int		j;
	int		start;
	int		icpy;
	char	*ptr;

	make_shit_zero(&i, &j);
	ptr = (char *)haystack;
	if (*haystack == '\0' && *needle == '\0')
		return (ptr + strlen(haystack));
	if (*needle == '\0')
		return ((char *)haystack);
	while (haystack[i] != '\0')
	{
		makejzerostartiicpyi(&j, &start, &icpy, i);
		while (haystack[icpy] == needle[j] && haystack[icpy] != '\0' &&
				needle[j] != '\0')
		{
			increase_shit(&icpy, &j);
		}
		if (needle[j] == '\0')
			return ((char *)haystack + start);
		i++;
	}
	return (NULL);
}
