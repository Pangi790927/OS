#include "libft.h"

extern "C" int	isprint(int c)
{
	return ('\x1f' < c && c < '\x7f');
}
