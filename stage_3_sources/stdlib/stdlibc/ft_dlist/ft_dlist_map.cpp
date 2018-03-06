#include "libft.h"

static t_dlist	*make_dell(int *a, t_dlist **b, t_dlist **c, t_dlist *e)
{
	*a = 1;
	*b = e;
	*c = NULL;
	return (t_dlist *)(NULL);
}

static void		aksjdhaksjdhaksjdhaksj_hakj_s(t_dlist **a, t_dlist **b,
		t_dlist *c)
{
	*a = c;
	*b = *a;
}

t_dlist			*ft_dlist_map(t_dlist *lst, t_dlist *(*f)(t_dlist *elem))
{
	int		first_iter;
	t_dlist	*current_node;
	t_dlist	*new_list_start;
	t_dlist	*new_list_end;
	t_dlist *new_node;

	new_list_end = make_dell(&first_iter, &current_node, &new_list_start, lst);
	while (current_node && (current_node != lst || first_iter))
	{
		first_iter = 0;
		new_node = f(current_node);
		if (new_node == NULL)
		{
			ft_dlist_delete_more(&new_list_start, ft_normal_delete);
			return (NULL);
		}
		if (new_list_start == NULL)
			aksjdhaksjdhaksjdhaksj_hakj_s(&new_list_start, &new_list_end,
					new_node);
		else
			ft_dlist_add_end(&new_list_end, new_node);
		current_node = current_node->next;
	}
	return (new_list_start);
}
