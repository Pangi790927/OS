#include "libft.h"

static int	ft_remove_the_poo(const char *str)
{
	if (' ' == *str || '\t' == *str || '\n' == *str || '\v' == *str)
	{
		return (1);
	}
	if ('\f' == *str || '\r' == *str)
	{
		return (1);
	}
	return (0);
}

extern "C" int			atoi(const char *str)
{
	int negativ;
	int my_num;
	int count;

	count = 0;
	my_num = 0;
	negativ = 1;
	while (ft_remove_the_poo(str))
		str++;
	if (*str == '-' || *str == '+')
	{
		if (*str == '-')
			negativ = -1;
		str++;
	}
	while ('0' <= *str && *str <= '9')
	{
		my_num = my_num * 10 + *str - '0';
		str++;
		count++;
		if (count > 18)
			return (negativ == -1 ? 0 : -1);
	}
	return (my_num * negativ);
}
