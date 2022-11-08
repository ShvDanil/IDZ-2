#include <stdio.h>
#include <string.h>

void input(char *str) {
    int i = 0;
    int ch;
    do {
        ch = fgetc(stdin);
        str[i] = ch;
        ++i;
    } while (ch != -1 && i < 50000);
    str[i - 1] = '\0';
}

void changeString(char *str) {
    int str_size = strlen(str);
    for (int i = 0; i < str_size; ++i) {
        if (str[i] < 91 && str[i] > 64) {
            str[i] += 32;
        } else if (str[i] < 123 && str[i] > 96) {
            str[i] -= 32;
        }
    }
}

int main() {
    char buffer[50000];
    input(buffer);
    changeString(buffer);
    printf("\nFinal string: %s", buffer);
    return 0;
}

