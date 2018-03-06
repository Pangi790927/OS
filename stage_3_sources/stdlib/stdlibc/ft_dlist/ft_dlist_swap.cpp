#include "libft.h"

void	ft_dlist_swap(t_dlist *first, t_dlist *second)
{
	if (first == NULL || second == NULL)
		return ;
	first->next->prev = second;
	first->prev->next = second;
	second->prev->next = first;
	second->next->prev = first;
	ft_dlist_ptr_swap(&(first->next), &(second->next));
	ft_dlist_ptr_swap(&(first->prev), &(second->prev));
}
