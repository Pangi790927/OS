#include "libft.h"

static size_t	my_strlen(const char *str)
{
	size_t size;

	size = 0;
	while (str[size] != '\0')
		size++;
	return (size);
}

static int		my_isspace(char chr)
{
	return (chr == ' ' || chr == '\t' || chr == '\n');
}

static char		*my_str_alloc_empty(void)
{
	char *new_str;

	new_str = (char *)malloc(1 * sizeof(char));
	new_str[0] = '\0';
	return (new_str);
}

extern "C" char			*strtrim(char const *s)
{
	char	*new_str;
	int		i;
	int		left;
	int		right;

	if (s == NULL)
		return (NULL);
	left = 0;
	while (s[left] != '\0' && my_isspace(s[left]))
		left++;
	right = my_strlen(s) - 1;
	while (right >= 0 && my_isspace(s[right]))
		right--;
	if (right < left)
		return (my_str_alloc_empty());
	if ((new_str = (char *)malloc((right - left + 2) * sizeof(char))) == NULL)
		return (NULL);
	i = left;
	while (i <= right)
	{
		new_str[i - left] = s[i];
		i++;
	}
	new_str[right - left + 1] = '\0';
	return (new_str);
}
