#include "libft.h"

void	striteri(char *s, void (*f)(unsigned int, char *))
{
	unsigned int	index;

	if (s == NULL || f == NULL)
		return ;
	index = 0;
	while (s[index] != '\0')
	{
		(*f)(index, &(s[index]));
		index++;
	}
}
