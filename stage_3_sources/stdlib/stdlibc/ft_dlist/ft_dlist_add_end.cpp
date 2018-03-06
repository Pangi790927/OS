#include "libft.h"

void	ft_dlist_add_end(t_dlist **end_node, t_dlist *new_node)
{
	new_node->prev = (*end_node);
	if (*end_node != NULL)
		(*end_node)->next = new_node;
	(*end_node) = new_node;
}
