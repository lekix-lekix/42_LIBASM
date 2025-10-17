#include <stdio.h>

int main () {
    extern ft_strlen();
    int len = ft_strlen("coucou");
    printf("%d\n", len);
}