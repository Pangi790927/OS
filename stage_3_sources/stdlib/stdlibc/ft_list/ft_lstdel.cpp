#include "libft.h"

void	ft_lstdel(t_list **alst, void (*del)(void *, size_t))
{
	t_list	*next_node;

	if (alst == NULL)
		return ;
	if ((*alst) == NULL)
		return ;
	next_node = (*alst)->next;
	ft_lstdelone(alst, del);
	ft_lstdel(&next_node, del);
}
