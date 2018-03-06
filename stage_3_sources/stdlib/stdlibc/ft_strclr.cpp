#include "libft.h"

void	strclr(char *s)
{
	size_t	index;

	if (s == NULL)
		return ;
	index = 0;
	while (s[index] != '\0')
	{
		s[index] = '\0';
		index++;
	}
}
