#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <strings.h>

int ft_strcmp(const char *s1, const char *s2);
int ft_strcpy(char *dest, const char *src);
ssize_t ft_write(int fd, const void *buf, size_t count);

char s1[7];
char s2[] = "coucouaa";

// char s3[7];
// char s4[] = "couccc";

int main () {
    // memset(s1, 0, 7);
    // memset(s3, 0, 7);

    // strcpy(s1, s2);
    // ft_strcpy(s1, s2);
    // printf("%s\n", s3);
    // printf("%s\n", s1);
    int res;
    res = write(-1, "coucou", 6);
    printf("%d\n", res);
    perror("write");

    write(1, NULL, 6);
    perror("write");

    res = ft_write(-1, "coucou", 6);
    printf("%d\n", res);
    perror("write");

    res = ft_write(1, NULL, 6);
    printf("%d\n", res);
    perror("write");

}