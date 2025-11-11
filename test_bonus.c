/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kipouliq <kipouliq@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/11 18:15:52 by kipouliq          #+#    #+#             */
/*   Updated: 2025/11/11 18:34:15 by kipouliq         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "./libasm_bonus.h"

#include <string.h>
#include <stdio.h>

int main()
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

    
}