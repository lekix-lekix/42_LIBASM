NAME = libasm.a

SRCS = ./ft_strlen.s \
		./ft_strcpy.s \
		./ft_strcmp.s \
		./ft_write.s \
		./ft_read.s \
		./ft_strdup.s

SRCS_BONUS = ./ft_atoi_base_bonus.s \
				./ft_list_push_front_bonus.s \
				./ft_list_size_bonus.s \
				./ft_list_sort_bonus.s \
				./ft_list_remove_if_bonus.s

OBJS_DIR = .objs/

OBJ = $(SRCS:.s=.o)

OBJ_BONUS = $(SRCS_BONUS:.s=.o)

OBJS = $(addprefix $(OBJS_DIR), $(OBJ))

OBJS_BONUS = $(addprefix $(OBJS_DIR), $(OBJ_BONUS))

CC = nasm -felf64

all: $(NAME)

$(OBJS_DIR)%.o: %.s
	mkdir -p $(@D)
	$(CC) $< -o $@

$(NAME): $(OBJS)	
	ar -rcs $(NAME) $(OBJS)

bonus: $(OBJS_BONUS)
	ar -rcs $(NAME) $(OBJS_BONUS)

clean:
	rm -rf $(OBJS_DIR)
	rm -rf ./a.out

fclean: clean
	rm -f $(NAME)
	rm -f ./test

re: fclean
	make all

test: all
	gcc -Wall -Wextra -Werror main.c ./$(NAME) -g

testnoflags:
	gcc test.c ./$(NAME) -g

test_bonus: all 
	make bonus
	gcc -Wall -Wextra -Werror main_bonus.c ./$(NAME) -g

.PHONY: all clean fclean re bonus test test_bonus