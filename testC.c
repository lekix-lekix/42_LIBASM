#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <strings.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdlib.h>

int ft_strlen(const char *str);
int ft_strcmp(const char *s1, const char *s2);
int ft_strcpy(char *dest, const char *src);
ssize_t ft_write(int fildes, const void *buf, size_t count);
ssize_t ft_read(int fildes, void *buf, size_t nbytes);
int ft_atoi_base(char *str, char *base);
char *ft_strdup(const char *str);

char s1[7];
char s2[7];

// char s3[7];
// char s4[] = "couccc";

int main (int argc, char **argv) {
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

    printf("%d\n", ft_strlen("cocou"));


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
    int nb = ft_atoi_base("15", argv[1]);
    printf("%d\n", nb);
    // int fd = open("./testC.c", O_RDONLY);
    // read(fd, s1, -1);
    // perror("read");
    // ft_read(fd, s2, -1);
    // perror("read");
    // printf("%s\n", s1);
    // printf("%s\n", s2);
}