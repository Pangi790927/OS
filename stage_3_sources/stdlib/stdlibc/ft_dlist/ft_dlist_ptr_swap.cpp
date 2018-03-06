#include "libft.h"

void	ft_dlist_ptr_swap(t_dlist **first, t_dlist **second)
{
	t_dlist *aux;

	aux = *first;
	*first = *second;
	*second = aux;
}
