#include "libft.h"

void	ft_dlist_iter(t_dlist *start_node, void (*f)(t_dlist *elem))
{
	int		first_iter;
	t_dlist	*current_node;

	first_iter = 1;
	current_node = start_node;
	while (current_node && (current_node != start_node || first_iter))
	{
		first_iter = 0;
		f(current_node);
		current_node = current_node->next;
	}
}
