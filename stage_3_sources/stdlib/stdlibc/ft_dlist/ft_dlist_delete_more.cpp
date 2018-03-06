#include "libft.h"

void	ft_dlist_delete_more(t_dlist **node, void (*del)(void *, size_t))
{
	t_dlist *next_node;

	if ((*node) == NULL)
		return ;
	next_node = (*node)->next;
	ft_dlist_delete(node, del);
	ft_dlist_delete_more(&next_node, del);
}
