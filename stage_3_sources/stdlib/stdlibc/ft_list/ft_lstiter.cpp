#include "libft.h"

void	ft_lstiter(t_list *lst, void (*f)(t_list *elem))
{
	int		first_iter;
	t_list	*current_node;

	if (f == NULL)
		return ;
	first_iter = 1;
	current_node = lst;
	while (current_node && (current_node != lst || first_iter))
	{
		first_iter = 0;
		f(current_node);
		current_node = current_node->next;
	}
}
