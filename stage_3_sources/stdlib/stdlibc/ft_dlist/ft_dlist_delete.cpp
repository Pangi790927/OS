#include "libft.h"

void	ft_dlist_delete(t_dlist **node, void (*del)(void *, size_t))
{
	if (*node == NULL)
		return ;
	del((*node)->content, (*node)->content_size);
	if ((*node)->prev != NULL)
		(*node)->prev->next = (*node)->next;
	if ((*node)->next != NULL)
		(*node)->next->prev = (*node)->prev;
	free(*node);
	*node = NULL;
}
