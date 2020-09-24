#ifndef STDLIB_H
#define STDLIB_H

static unsigned short lfsr = 0xACE1u;
static unsigned bit;

inline void ksrand(unsigned b) {
	lfsr = 0xACE1u;
	bit = b;
}

inline unsigned krand() {
	bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ) & 1;
	return lfsr =  (lfsr >> 1) | (bit << 15);
}

inline void memset(void *ptr, int value, int cnt) {
	for (int i = 0; i < cnt; i++)
		((char *)ptr)[i] = value;
}

inline void	*memmove(void *dest, const void *src, size_t n)
{
	size_t i;

	if (dest > src && dest < (char *)src + n)
	{
		i = n - 1;
		while (i >= (size_t)((char *)dest - (char *)src))
		{
			*((char *)dest + i) = *((char *)src + i);
			i--;
		}
		n = (char *)dest - (char *)src;
	}
	i = 0;
	while (i < n)
	{
		*((char *)dest + i) = *((char *)src + i);
		i++;
	}
	return (dest);
}

inline void	*memcpy(void *dest, const void *src, size_t n)
{
	size_t	i;

	i = 0;
	while (i < n)
	{
		*((char *)dest + i) = *((char *)src + i);
		i++;
	}
	return (dest);
}

inline size_t strlen(const char *str)
{
	size_t size;

	size = 0;
	while (str[size])
	{
		size++;
	}
	return (size);
}

inline int strcmp(const char *str1, const char *str2)
{
	int	i;

	i = 0;
	while (str1[i] && str2[i] && str1[i] == str2[i])
		i++;
	if (str1[i] == 0 && str2[i] == 0)
		return (0);
	if (str1[i] == 0 && str2[i] != 0)
		return ((unsigned char)str2[i] * (-1));
	if (str1[i] != 0 && str2[i] == 0)
		return ((unsigned char)str1[i]);
	if (str1[i] != 0 && str2[i] != 0)
		return ((unsigned char)str1[i] - (unsigned char)str2[i]);
	return (0);
}

inline char *strcpy(char *dest, const char *src)
{
	int i;

	i = 0;
	while (src[i] != '\0')
	{
		dest[i] = src[i];
		i++;
	}
	dest[i] = '\0';
	return (dest);
}

inline double sqrt (double x) {
	double res;
	asm volatile ("fsqrt" : "=t" (res) : "0" (x));
	return res;
}

#endif
