#include "libft.h"

int	iswhitespace (char c) {
	return c == ' ' || c == '\f' || c == '\n' ||
			c == '\r' || c == '\t' || c == '\v'; 
}