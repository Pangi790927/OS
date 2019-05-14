#include "libft.h"

static size_t	get_len(char const *s)
{
	size_t	size;

	size = 0;
	while (s[size] != '\0')
		size++;
	return (size);
}

static void		set_sunu_sdoi(const char **s1, const char **s2)
{
	if (*s1 == NULL)
		*s1 = "";
	if (*s2 == NULL)
		*s2 = "";
}

extern "C" char			*strjoin(char const *s1, char const *s2)
{
	char	*str;
	size_t	index;
	size_t	offset;
	size_t	size;

	set_sunu_sdoi(&s1, &s2);
	size = get_len(s1) + get_len(s2);
	str = (char *)malloc(sizeof(char) * (size + 1));
	if (str == NULL)
		return (NULL);
	index = 0;
	while (s1[index] != '\0')
	{
		str[index] = s1[index];
		index++;
	}
	offset = index;
	index = 0;
	while (s2[index] != '\0')
	{
		str[offset + index] = s2[index];
		index++;
	}
	str[offset + index] = '\0';
	return (str);
}
