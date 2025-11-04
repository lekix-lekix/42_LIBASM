#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

int					ft_strlen(const char *str);
int					ft_strcmp(const char *s1, const char *s2);
int					ft_strcpy(char *dest, const char *src);
ssize_t				ft_write(int fildes, const void *buf, size_t count);
ssize_t				ft_read(int fildes, void *buf, size_t nbytes);
int					ft_atoi_base(char *str, char *base);
char				*ft_strdup(const char *str);
void				ft_list_push_front(t_list **begin_list, void *data);
int					ft_list_size(t_list *begin);
void				ft_list_sort(t_list **begin, int (*cmp)());

typedef int (*func)(int, int);

char				s1[7];
char				s2[7];

int		cmp(int a, int b)
{
	if (a < b)
		return (-1);
	else if (a > b)
		return (1);
	return (0);
}

void	print_list(t_list **lst)
{
	t_list	*curr;
	int		*data;

	curr = *lst;
	while (curr)
	{
		// int *data = curr->data;
		if (curr->data)
		{
			data = curr->data;
			printf("data = %d\n", *data);
			// printf("data = %d\n", *((int *)curr->data));
		}
		curr = curr->next;
	}
}

int	main(void)
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
	t_list *lst = NULL;
	srand(time(NULL)); // Initialization, should only be called once.
	// for (int i = 0; i < 30; i++)
	// {
		// int *elem = malloc(sizeof(int));
		// int r = rand();   
			// Returns a pseudo-random integer between 0 and RAND_MAX.
		// *elem = r % 20;
		// ft_list_push_front(&lst, elem);
	// }

	int *elem = malloc(sizeof(int));
	*elem = 3;
	ft_list_push_front(&lst, elem);

	elem = malloc(sizeof(int));
	*elem = 2;
	ft_list_push_front(&lst, elem);

	elem = malloc(sizeof(int));
	*elem = 1;
	ft_list_push_front(&lst, elem);

	print_list(&lst);
	// printf("size = %d\n", ft_list_size(NULL));
	ft_list_sort(&lst, cmp);
	print_list(&lst);

	for (t_list *curr = lst; curr;)
	{
		t_list *prev = curr;
		free(curr->data);
		curr = curr->next;
		free(prev);
	}
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