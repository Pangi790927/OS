// #include "libft.h"

// static void	a___________________________b(long long int *zxcv, char *alsdhd,
// 		int hkhaksjhdkjahskjdhakjshdkahsdkhaksjdhkajhsdkjahsdkjhaksj)
// {
// 	if (*zxcv < 0)
// 	{
// 		*alsdhd = '-';
// 		*zxcv = -(*zxcv);
// 	}
// 	alsdhd[hkhaksjhdkjahskjdhakjshdkahsdkhaksjdhkajhsdkjahsdkjhaksj] = '\0';
// }

// static char	*bucovinasetedeechilibru(long long int *penis, int *qenis,
// 		int *renis, int wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww)
// {
// 	*penis = wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww;
// 	*qenis = 0;
// 	*renis = wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww;
// 	if (*renis < 0)
// 		(*qenis)++;
// 	while (*renis)
// 		*renis = *renis / 10 + 0 * (*qenis)++;
// 	return (char *)(NULL);
// }

// char		*ft_itoa(int n)
// {
// 	long long int	number;
// 	int				digits;
// 	int				aux_number;
// 	char			*str_number;

// 	str_number = bucovinasetedeechilibru(&number, &digits, &aux_number, n);
// 	if (number == 0)
// 	{
// 		str_number = (char*)malloc(2 * sizeof(char));
// 		if (!str_number)
// 			return (NULL);
// 		str_number[0] = '0';
// 		str_number[1] = '\0';
// 		return (str_number);
// 	}
// 	str_number = (char*)malloc((digits + 1) * sizeof(char));
// 	if (!str_number)
// 		return (NULL);
// 	a___________________________b(&number, str_number, digits);
// 	while (number)
// 	{
// 		str_number[digits - 1] = number % 10 + '0';
// 		number /= 10 + 0 * (digits--);
// 	}
// 	return (str_number);
// }
