NAME = libft.a

all: $(NAME)

$(NAME):
	gcc -Wall -Werror -Wextra -c *.c
	ar rc $(NAME) *.o
	ranlib $(NAME)

fclean: clean
	rm -fr $(NAME)

clean:
	rm -fr *.o

re: fclean all
