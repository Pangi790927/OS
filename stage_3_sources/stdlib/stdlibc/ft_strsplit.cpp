#include "libft.h"

static size_t	my_strclen(const char *str, char c)
{
	size_t size;

	size = 0;
	while (str[size] != '\0' && str[size] != c)
		size++;
	return (size);
}

static size_t	my_count_words(const char *str, char c, size_t *a, size_t *b)
{
	size_t word_size;
	size_t count;
	size_t it;

	*a = 0;
	*b = 0;
	it = 0;
	count = 0;
	while (str[it] != '\0')
	{
		while (str[it] != '\0' && str[it] == c)
			it++;
		word_size = my_strclen(str + it, c);
		if (word_size != 0)
		{
			count++;
			it += word_size;
		}
	}
	return (count);
}

static void		my_strccpy(char *dest, const char *src, char c)
{
	while (*src != '\0' && *src != c)
	{
		*dest = *src;
		src++;
		dest++;
	}
}

char			**strsplit(char const *s, char c)
{
	char	**wt;
	size_t	wc;
	size_t	it;
	size_t	word_it;
	size_t	ws;

	if (s == NULL)
		return (NULL);
	wc = my_count_words(s, c, &word_it, &it);
	if ((wt = (char **)malloc(sizeof(char *) * (wc + 1))) == NULL)
		return (NULL);
	while (word_it < wc)
	{
		while (s[it] == '\0' || s[it] == c)
			it++;
		ws = my_strclen(s + it, c);
		if ((wt[word_it] = (char *)malloc(sizeof(char) * (ws + 1))) == NULL)
			return (NULL);
		my_strccpy(wt[word_it], s + it, c);
		wt[word_it][ws] = '\0';
		it += ws + 0 * (word_it++);
	}
	wt[wc] = NULL;
	return (wt);
}
