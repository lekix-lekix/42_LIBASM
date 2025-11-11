/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kipouliq <kipouliq@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/11 12:45:04 by kipouliq          #+#    #+#             */
/*   Updated: 2025/11/11 16:40:46 by kipouliq         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "./libasm.h"

#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>

int main ()
{	
	
	/**** FT_STRLEN ***/
	
	printf("/**** FT_STRLEN ****/\n\n");
	char str[] = "coucou";
	printf("strlen: %ld, ft_strlen: %ld\n", strlen(str), ft_strlen(str));
	printf("strlen: %ld, ft_strlen: %ld\n", strlen(""), ft_strlen(""));
	printf("/******************/\n\n");
	
	/**** FT_STRCPY ***/

	printf("/**** FT_STRCPY ****/\n\n");
	char s1[20] = "coucou toi";
	char s2[20];
	printf("s1 = %p, s2 = %p\n", s1, s2);
	printf("strcpy ret : %p\n", strcpy(s2, s1));
	printf("s2 content : %s\n", s2);
	bzero(s2, 20);
	printf("ft_strcpy ret : %p\n", ft_strcpy(s2, s1));
	printf("s2 content : %s\n", s2);
	printf("%s\n", s2);

	bzero(s2, 20);
	printf("strcpy ret : %p\n", strcpy(s2, ""));
	printf("s2 content : %s\n", s2);
	bzero(s2, 20);
	printf("ft_strcpy ret : %p\n", ft_strcpy(s2, ""));
	printf("s2 content : %s\n", s2);
	printf("/******************/\n\n");

	/**** FT_STRCMP ***/
	
	printf("/**** FT_STRCMP ****/\n\n");
	printf("strcmp ret : %d\n", strcmp("a", "b"));
	printf("ft_strcmp ret : %d\n", ft_strcmp("a", "b"));
	printf("strcmp ret : %d\n", strcmp("b", "a"));
	printf("ft_strcmp ret : %d\n", ft_strcmp("b", "a"));
	printf("strcmp ret : %d\n", strcmp("b", "b"));
	printf("ft_strcmp ret : %d\n", ft_strcmp("b", "b"));
	printf("strcmp ret : %d\n", strcmp("aaaab", "aaaac"));
	printf("ft_strcmp ret : %d\n", ft_strcmp("aaaab", "aaaac"));
	printf("strcmp ret : %d\n", strcmp("", ""));
	printf("ft_strcmp ret : %d\n", ft_strcmp("", ""));
	printf("/******************/\n\n");

	/**** FT_WRITE ***/
	int fd = open("./test", O_RDWR | O_CREAT, 0644);
	
	printf("/**** FT_WRITE ****/\n\n");
	printf("write = %ld\n", write(1, "coucou\n", 7));
	printf("ft_write = %ld\n", ft_write(1, "coucou\n", 7));
	printf("write = %ld\n", write(2, "error\n", 6));
	printf("ft_write = %ld\n", ft_write(2, "error\n", 6));
	printf("write = %ld\n", write(fd, "hello\n", 6));
	printf("ft_write = %ld\n", ft_write(fd, "hello\n", 6));
	printf("write = %ld\n", write(10, "hello\n", 6));
	perror("write");
	errno = 0;
	perror("errno reset");
	printf("ft_write = %ld\n", ft_write(10, "hello\n", 6));
	perror("write");
	printf("/******************/\n\n");
	
	/**** FT_READ ***/
	printf("/**** FT_READ ****/\n\n");
	char buffer[21] = {0};
	
	fd = open("./Makefile", O_RDONLY);
	printf("read = %ld\n", read(fd, buffer, 20));
	printf("buffer = %s\nlen = %ld\n", buffer, strlen(buffer));
	close(fd);
	
	fd = open("./Makefile", O_RDONLY);
	bzero(buffer, 21);
	printf("ft_read = %ld\n", ft_read(fd, buffer, 20));
	printf("buffer = %s\nlen = %ld\n", buffer, strlen(buffer));
	close(fd);
	
	printf("read = %ld\n", read(10, buffer, 20));
	printf("buffer = %s\nlen = %ld\n", buffer, strlen(buffer));
	perror("read");
	printf("\n");

	errno = 0;

	printf("ft_read = %ld\n", read(10, buffer, 20));
	printf("buffer = %s\nlen = %ld\n", buffer, strlen(buffer));
	perror("ft_read");
	printf("\n");	
	printf("/******************/\n\n");

	/**** FT_STRDUP ***/
	printf("/**** FT_READ ****/\n\n");
	char *str_ptr = strdup("coucou\n");
	printf("strdup res = %s\nlen = %ld\n", str_ptr, strlen(str_ptr));
	free(str_ptr);

	str_ptr = ft_strdup("coucou\n");
	printf("ft_strdup res = %s\nlen = %ld\n", str_ptr, strlen(str_ptr));
	free(str_ptr);

	str_ptr = strdup("");
	printf("strdup res = %s\nlen = %ld\n", str_ptr, strlen(str_ptr));
	free(str_ptr);

	str_ptr = ft_strdup("");
	printf("ft_strdup res = %s\nlen = %ld\n", str_ptr, strlen(str_ptr));
	free(str_ptr);

	// str_ptr = strdup(NULL);
	// printf("strdup res = %s\nlen = %ld\n", str_ptr, strlen(str_ptr)); // WILL CRASH

	// str_ptr = ft_strdup(NULL);
	// printf("ft_strdup res = %s\nlen = %ld\n", str_ptr, strlen(str_ptr)); // WILL CRASH
}