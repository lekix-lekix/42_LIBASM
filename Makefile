NAME = libasm.a

SRCS = ./ft_strlen.s \
		./ft_strcpy.s \
		./ft_strcmp.s \
		./ft_write.s \
		./ft_read.s \
		./ft_strdup.s \
		./ft_atoi_base.s \
		./ft_list_push_front.s \
		./ft_list_size.s \
		./ft_list_sort.s \
		./ft_list_remove_if.s

OBJS = $(SRCS:.s=.o)

CC = nasm -felf64

all: $(NAME)

%.o: %.s
	$(CC) $< -o $@

$(NAME): $(OBJS)	
	ar -rcs $(NAME) $(OBJS)
	make clean

clean:
	rm -f *.o

fclean: clean
	rm -f $(NAME)

re: fclean
	make all

test: all
	gcc  test.c ./$(NAME) -g

.PHONY: all clean fclean re bonus