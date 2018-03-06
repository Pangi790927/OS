#include "libft.h"

t_dlist	*ft_dlist_new(void const *content, size_t content_size)
{
	t_dlist			*new_node;
	unsigned int	i;

	new_node = (t_dlist*)malloc(sizeof(t_dlist));
	i = 0;
	if (new_node == NULL)
		return (NULL);
	if (content_size != 0 && content != NULL)
	{
		new_node->content = malloc(sizeof(unsigned char) * content_size);
		while (i < content_size)
		{
			((unsigned char*)new_node->content)[i] =
					((unsigned char*)content)[i];
			i++;
		}
	}
	else
		new_node->content = NULL;
	new_node->content_size = (content == NULL) ? 0 : content_size;
	new_node->next = NULL;
	new_node->prev = NULL;
	return (new_node);
}
