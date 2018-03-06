#include "libft.h"

static int	min(int a, int b)
{
	return (a < b ? a : b);
}

static void	set_ij(size_t *i, size_t *j)
{
	*i = 0;
	*j = 0;
}

static void	set_j_start_icpy(size_t *j, size_t *s, size_t *c, size_t i)
{
	*j = 0;
	*s = i;
	*c = i;
}

static void	inc_icpy_j(size_t *icpy, size_t *j)
{
	(*icpy)++;
	(*j)++;
}

char		*strnstr(const char *haystack, const char *needle, size_t n)
{
	size_t	i;
	size_t	j;
	size_t	start;
	size_t	icpy;
	char	*ptr;

	set_ij(&i, &j);
	ptr = (char *)haystack;
	if (*haystack == '\0' && *needle == '\0')
		return (ptr + min(strlen(haystack), n));
	if (*needle == '\0')
		return ((char *)haystack);
	while (haystack[i] != '\0' && i + strlen(needle) - 1 < n)
	{
		set_j_start_icpy(&j, &start, &icpy, i);
		while (haystack[icpy] == needle[j] && haystack[icpy] != '\0' &&
				needle[j] != '\0')
			inc_icpy_j(&icpy, &j);
		if (needle[j] == '\0')
			return ((char *)haystack + start);
		i++;
	}
	return (NULL);
}
