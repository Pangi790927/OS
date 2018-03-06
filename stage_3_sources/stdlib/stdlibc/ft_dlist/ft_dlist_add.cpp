#include "libft.h"

void	ft_dlist_add(t_dlist **start_node, t_dlist *new_node)
{
	new_node->next = (*start_node);
	if (*start_node != NULL)
		(*start_node)->prev = new_node;
	(*start_node) = new_node;
}
