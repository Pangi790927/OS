#include "libft.h"

extern "C" int	isalnum(int c)
{
	return (isalpha(c) || isdigit(c));
}
