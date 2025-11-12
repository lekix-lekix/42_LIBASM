/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kipouliq <kipouliq@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/11 18:15:52 by kipouliq          #+#    #+#             */
/*   Updated: 2025/11/12 14:25:28 by kipouliq         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "./libasm.h"
#include "./libasm_bonus.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void	print_list(t_list **list)
{
	t_list	*current;

	current = *list;
	while (current)
	{
		if (current->data)
			printf("%d\n", *((int *)current->data));
		current = current->next;
	}
}

void	print_list_str(t_list **list)
{
	t_list	*current;

	current = *list;
	while (current)
	{
		if (current->data)
			printf("%s\n", (char *)current->data);
		current = current->next;
	}
}

void	free_list(t_list **list)
{
	t_list	*current;
	t_list	*next;

	current = *list;
	next = NULL;
	while (current)
	{
		if (current->data)
			free(current->data);
		next = current->next;
		free(current);
		current = next;
	}
}

void	free_list_no_mlc(t_list **list)
{
	t_list	*current;
	t_list	*next;

	current = *list;
	next = NULL;
	while (current)
	{
		next = current->next;
		free(current);
		current = next;
	}
}

void	push_n_elems(t_list **list, int n)
{
	int	*data;

	for (int i = 0; i < n; i++)
	{
		data = malloc(sizeof(int));
		*data = i;
		ft_list_push_front(list, data);
	}
}

int	cmp(void *a, void *b)
{
	if (*(int *)a > *(int *)b)
		return (1);
	if (*(int *)a < *(int *)b)
		return (-1);
	return (0);
}

int	lower(void *a, void *b)
{
	return (*(int *)a < *(int *)b);
}

int	higher(void *a, void *b)
{
	return (*(int *)a > *(int *)b);
}

int	main(void)
{
	/**** FT_ATOI_BASE ***/
	char base[20] = {0};
	strcpy(base, "01");

	printf("/**** FT_ATOI_BASE ***/\n");
	printf("res = %d\n", ft_atoi_base("101010", ""));
	printf("res = %d\n", ft_atoi_base("101010", " "));
	printf("res = %d\n", ft_atoi_base("101010", "+01"));
	printf("res = %d\n", ft_atoi_base("101010", "01+"));
	printf("res = %d\n", ft_atoi_base("101010", "-01"));
	printf("res = %d\n", ft_atoi_base("101010", "01-"));
	printf("res = %d\n", ft_atoi_base("101010", "01 "));

	printf("res = %d\n", ft_atoi_base("101010", "01"));
	printf("res = %d\n", ft_atoi_base("-101010", "01"));
	printf("res = %d\n", ft_atoi_base("+101010", "01"));
	printf("res = %d\n", ft_atoi_base("FFFFF", "0123456789ABCDEFG"));
	printf("res = %d\n", ft_atoi_base("123456789", "0123456789"));
	printf("/*****************/\n\n");

	/**** FT_LIST_PUSH_FRONT ***/
	printf("/**** FT_LIST_PUSH_FRONT ****/\n");
	t_list *lst = NULL;
	ft_list_push_front(NULL, NULL);
	ft_list_push_front(&lst, NULL);
	push_n_elems(&lst, 5);
	print_list(&lst);
	free_list(&lst);
	lst = NULL;
	printf("/*****************/\n\n");

	/**** FT_LIST_SIZE ***/
	printf("/**** FT_LIST_SIZE ***/\n");
	printf("list size = %d\n", ft_list_size(lst));
	push_n_elems(&lst, 10);
	printf("list size = %d\n", ft_list_size(lst));
	free_list(&lst);
	lst = NULL;
	printf("/*****************/\n\n");

	/**** FT_LIST_SORT ***/
	printf("/**** FT_LIST_SORT ***/\n");
	ft_list_sort(NULL, NULL);
	ft_list_sort(&lst, NULL);
	push_n_elems(&lst, 10);
	print_list(&lst);
	printf("===========\n");
	ft_list_sort(&lst, cmp);
	print_list(&lst);
	free_list(&lst);
	lst = NULL;
	printf("===========\n");
	ft_list_push_front(&lst, "aaaa");
	ft_list_push_front(&lst, "aaab");
	ft_list_push_front(&lst, "aaac");
	print_list_str(&lst);
	printf("===========\n");
	ft_list_sort(&lst, strcmp);
	print_list_str(&lst);
	free_list_no_mlc(&lst);
	lst = NULL;
	printf("/*****************/\n\n");

	/**** FT_LIST_REMOVE_IF ***/
	printf("/**** FT_LIST_REMOVE_IF ***/\n");
	int data_ref = 5;
	ft_list_remove_if(NULL, NULL, NULL, NULL);
	ft_list_remove_if(&lst, NULL, NULL, NULL);
	ft_list_remove_if(&lst, &data_ref, NULL, NULL);
	ft_list_remove_if(&lst, &data_ref, NULL, free);

	push_n_elems(&lst, 10);
	print_list(&lst);
	printf("===========\n");
	ft_list_remove_if(&lst, &data_ref, lower, free);
	print_list(&lst);
	free_list(&lst);
	printf("===========\n");
	lst = NULL;

	push_n_elems(&lst, 10);
	print_list(&lst);
	printf("===========\n");
	ft_list_remove_if(&lst, &data_ref, higher, free);
	print_list(&lst);
	free_list(&lst);
	lst = NULL;
}