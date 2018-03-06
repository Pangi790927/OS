#include "libft.h"

void	ft_dlist_add_after(t_dlist *node, t_dlist *new_node)
{
	t_dlist *next;

	next = NULL;
	if (!new_node || !node)
		return ;
	next = node->next;
	node->next = new_node;
	new_node->prev = node;
	new_node->next = next;
	if (next)
		next->prev = new_node;
}
