#include "libft.h"

extern "C" int	isdigit(int c)
{
	if ('0' <= c && c <= '9')
		return (1);
	return (0);
}
