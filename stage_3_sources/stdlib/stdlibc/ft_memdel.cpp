#include "libft.h"

extern "C" void	memdel(void **ap)
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
