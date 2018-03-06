#include "libft.h"

t_list	*ft_lstnew(void const *content, size_t content_size)
{
	t_list			*new_node;
	unsigned int	i;

	new_node = (t_list *)malloc(sizeof(t_list));
	i = 0;
	if (new_node == NULL)
		return (NULL);
	if (content_size != 0 && content != NULL)
	{
		new_node->content = malloc(sizeof(unsigned char) * content_size);
		while (i < content_size)
		{
			((unsigned char *)new_node->content)[i] =
					((unsigned char *)content)[i];
			i++;
		}
	}
	else
	{
		new_node->content = NULL;
	}
	new_node->content_size = (content == NULL) ? 0 : content_size;
	new_node->next = NULL;
	return (new_node);
}
