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
char				*ft_strcpy(char *dest, const char *src);
ssize_t				ft_write(int fildes, const void *buf, size_t count);
ssize_t				ft_read(int fildes, void *buf, size_t nbytes);
int					ft_atoi_base(char *str, char *base);
char				*ft_strdup(const char *str);
void				ft_list_push_front(t_list **begin_list, void *data);
int					ft_list_size(t_list *begin);
void				ft_list_sort(t_list **begin, int (*cmp)());
void				ft_list_remove_if(t_list **begin_list, void *data_ref,
						int (*cmp)(), void (*free_fct)(void *));

typedef int			(*func)();
typedef void		(*free_func)(void *);

char				s1[7];
char				s2[7];

// int		cmp(void *a, void *b)
// {
// 	if (*(int *)a < *(int *)b)
// 		return (-1);
// 	else if (*(int *)a > *(int *)b)
// 		return (1);
// 	return (0);
// }

int	cmp(int a, int b)
{
	if (a < b)
		return (-1);
	else if (a > b)
		return (1);
	return (0);
}

int	int_cmp(void *a, void *b)
{
	if (*(int *)a < *(int *)b)
		return (-1);
	else if (*(int *)a > *(int *)b)
		return (1);
	return (0);
}

void	print_list_int(t_list **lst)
{
	t_list	*curr;
	int		*data;

	// void	*data;
	curr = *lst;
	while (curr)
	{
		// if (curr->data)
		// {
		// 	data = curr->data;
		// 	printf("data = %d\n", data);
		// 	// printf("data = %d\n", *((int *)curr->data));
		// }
		
		printf("data = %d\n", *((int *)curr->data));
		curr = curr->next;
	}
}

void	print_list_str(t_list **lst)
{
	t_list	*curr;

	// void	*data;
	curr = *lst;
	while (curr)
	{
		if (curr->data)
		{
			// int *data = curr->data;
			printf("data = %s\n", (char *)curr->data);
			// printf("data = %d\n", *((int *)curr->data));
		}
		curr = curr->next;
	}
}

int	lower(void *d1, void *d2)
{
	return ((long long)d1 > (long long)d2);
}

int	main(void)
{
	t_list *list = NULL;

	// ft_list_push_front(&lst, (void *)1);
	for (int i = 0; i < 10; i++)
	{
		int *nb = malloc(sizeof(int));
		*nb = i;
		ft_list_push_front(&list, nb);
	}
	print_list_int(&list);
	printf("============\n");
	ft_list_sort(&list, lower);
	print_list_int(&list);
	for (int i = 0; i < 10; i++)
	{
		ft_list_remove_if(&list, &i, lower, free);
	}
	print_list_int(&list);
	// ft_list_remove_if(&list, (void *)0, )
}