#include "libft.h"

static int		my_issep(char c, const char *sep)
{
	while (*sep)
	{
		if (c == *sep)
			return (1);
		sep++;
	}
	return (0);
}

static size_t	my_strslen(const char *str, const char *sep)
{
	size_t size;

	size = 0;
	while (str[size] != '\0' && !my_issep(str[size], sep))
		size++;
	return (size);
}

static size_t	my_count_words(const char *str, const char *sep,
		size_t *a, size_t *b)
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
		while (str[it] != '\0' && my_issep(str[it], sep))
			it++;
		word_size = my_strslen(str + it, sep);
		if (word_size != 0)
		{
			count++;
			it += word_size;
		}
	}
	return (count);
}

static void		my_strscpy(char *dest, const char *src, const char *sep)
{
	while (*src != '\0' && !my_issep(*src, sep))
	{
		*dest = *src;
		src++;
		dest++;
	}
}

char			**strssplit(char const *s, const char *sep)
{
	char	**wt;
	size_t	wc;
	size_t	it;
	size_t	word_it;
	size_t	ws;

	if (s == NULL)
		return (NULL);
	wc = my_count_words(s, sep, &word_it, &it);
	if ((wt = (char **)malloc(sizeof(char *) * (wc + 1))) == NULL)
		return (NULL);
	while (word_it < wc)
	{
		while (s[it] != '\0' && my_issep(s[it], sep))
			it++;
		ws = my_strslen(s + it, sep);
		if ((wt[word_it] = (char *)malloc(sizeof(char) * (ws + 1))) == NULL)
			return (NULL);
		my_strscpy(wt[word_it], s + it, sep);
		wt[word_it][ws] = '\0';
		it += ws + 0 * (word_it++);
	}
	wt[wc] = NULL;
	return (wt);
}
