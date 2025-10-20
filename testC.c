#include <stdio.h>
#include <string.h>

int ft_strcmp(const char *s1, const char *s2);

char s1[] = "a";
char s2[] = "b";

int main () {
    printf("%d\n", strcmp(s1, s2));
    printf("%d\n", ft_strcmp(s1, s2));
}