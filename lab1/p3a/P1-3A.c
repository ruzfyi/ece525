#include <stdio.h>

unsigned char next_char(char in) {
	return in + 1;
}

void main() {
	printf("Next Character= %c\n", next_char('A'));
}
