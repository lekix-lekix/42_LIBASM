#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <sys/stat.h>
#include <unistd.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

int					ft_strlen(const char *str);
int					ft_strcmp(const char *s1, const char *s2);
int					ft_strcpy(char *dest, const char *src);
ssize_t				ft_write(int fildes, const void *buf, size_t count);
ssize_t				ft_read(int fildes, void *buf, size_t nbytes);
int					ft_atoi_base(char *str, char *base);
char				*ft_strdup(const char *str);
void				ft_list_push_front(t_list **begin_list, void *data);

char				s1[7];
char				s2[7];

// char s3[7];
// char s4[] = "couccc";

t_list	*new_node(void *data)
{
	t_list	*node;

	node = malloc(sizeof(t_list));
	if (!node)
		return (NULL);
	node->data = data;
	node->next = NULL;
}

void	print_list(t_list **lst)
{
	t_list	*curr;

	curr = *lst;
	while (curr)
	{
		// int *data = curr->data;
		printf("data = %d\n", *((int *)curr->data));
		curr = curr->next;
	}
}

int	main(int argc, char **argv)
{
	// memset(s1, 0, 7);
	// memset(s3, 0, 7);

	// strcpy(s1, s2);
	// ft_strcpy(s1, s2);
	// printf("%s\n", s3);
	// printf("%s\n", s1);
	// int res;
	// res = ft_write(1, "coucou", 6);
	// printf("%d\n", res);
	// perror("write");

	(void)argc;
	t_list *lst = NULL;
	int *elem = malloc(sizeof(int));
	*elem = 1;

	ft_list_push_front(&lst, (void*)elem);
	print_list(&lst);
	// printf("%d\n", ft_strlen("cocou"));

	// printf("%d\n", ft_strlen("coucou"));
	// res = ft_write(-1, "coucou", 6);
	// printf("%d\n", res);
	// perror("write");

	// // write(1, NULL, 6);
	// // perror("write");

	// res = ft_write(-1, "coucou", 6);
	// printf("%d\n", res);
	// perror("write");

	// res = write(-1, "coucou", 0);
	// printf("%d\n", res);
	// perror("write");

	// res = ft_write(-1, "coucou", 0);
	// printf("%d\n", res);
	// perror("write");

	// res = ft_write(1, NULL, 6);
	// printf("%d\n", res);
	// perror("write");

	// printf("len = %d\n", ft_strlen("coucou toi la vache"));
	// // printf("strdup = %d\n", ft_strdup("hey"));
	// char *str = ft_strdup("coucou toi la vache");
	// printf("%s\n", str);
	// free(str);
	// char base[] = "01";
	// int nb = ft_atoi_base(argv[1], argv[2]);
	// printf("%d\n", nb);

	// int fd = open("./testC.c", O_RDONLY);
	// read(fd, s1, -1);
	// perror("read");
	// ft_read(fd, s2, -1);
	// perror("read");
	// printf("%s\n", s1);
	// printf("%s\n", s2);
}