#include "libft.h"

void	ft_dlist_add_before(t_dlist *node, t_dlist *new_node)
{
	t_dlist	*prev;

	prev = NULL;
	if (!new_node || !node)
		return ;
	prev = node->prev;
	node->prev = new_node;
	new_node->next = node;
	new_node->prev = prev;
	if (prev)
		prev->next = new_node;
}
