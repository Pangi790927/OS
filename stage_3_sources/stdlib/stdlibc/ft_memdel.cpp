#include "libft.h"

void	memdel(void **ap)
{
	if (ap != NULL)
	{
		if (*ap != NULL)
		{
			free(*ap);
			*ap = NULL;
		}
	}
}
