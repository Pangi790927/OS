#include "libft.h"

extern "C" void	striter(char *s, void (*f)(char *))
{
	size_t	index;

	if (s == NULL || f == NULL)
		return ;
	index = 0;
	while (s[index] != '\0')
	{
		(*f)(s + index);
		index++;
	}
}
