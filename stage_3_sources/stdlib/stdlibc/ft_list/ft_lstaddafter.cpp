#include "libft.h"

void	ft_lstaddafter(t_list *node, t_list *new_node)
{
	t_list *next;

	next = NULL;
	if (!new_node || !node)
		return ;
	next = node->next;
	node->next = new_node;
	new_node->next = next;
}
