#include "libft.h"

t_dlist	*ft_dlist_new_no_copy(void *content, size_t content_size)
{
	t_dlist *new_node;

	new_node = (t_dlist*)malloc(sizeof(t_dlist));
	if (new_node == NULL)
		return (NULL);
	new_node->content = content;
	new_node->content_size = (content == NULL) ? 0 : content_size;
	new_node->next = NULL;
	new_node->prev = NULL;
	return (new_node);
}
