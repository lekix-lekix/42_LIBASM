NAME = libasm.a

SRCS = ./ft_strlen.s \ 
		./test.s

OBJS = $(SRCS:.s=.o)

CC = nasm -felf64

all: $(NAME)	

%.o: %.s
	$(CC) $< -o $@

$(NAME): $(OBJS)	
	ar -rcs $(NAME) $(OBJS) 

clean:
	rm -f *.o

fclean: clean
	rm -f $(NAME)

re: fclean
	make all

.PHONY: all clean fclean re bonus