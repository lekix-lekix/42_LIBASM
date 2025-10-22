NAME = libasm.a

SRCS = ./ft_strlen.s \
		./ft_strcpy.s \
		./ft_strcmp.s \
		./ft_write.s \
		./ft_read.s \
		./ft_strdup.s

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

.PHONY: all clean fclean re bonus