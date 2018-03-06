#include "libft.h"

void	ft_lstadd(t_list **alst, t_list *new_node)
{
	if (new_node)
		new_node->next = (*alst);
	(*alst) = new_node;
}
