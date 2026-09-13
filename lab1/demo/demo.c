#include <stdio.h>

extern int add(int a, int b);
extern int sub(int a, int b);
extern int mul(int a, int b);
extern int div(int a, int b, int *rem);

unsigned char op = ' ';
signed int op1 = 0;
signed int op2 = 0;
signed int result = 0;

int main(void) {	
	printf("Calculator Program\nEnter a number to start, -1 to exit...");
	while (1) {
		printf("\nProblem: ");
		scanf(" %d %c %d", &op1, &op, &op2);

		switch (op) {
			case '+':
				result = add(op1, op2);
				break;
			case '-':
				result = sub(op1, op2);
				break;
			case '*':
				result = mul(op1, op2);
				break;
			case '/':
				if (op2 == 0) {
					printf("Error: Division by zero\n");
					break;
				}
				int rem;
				result = div(op1, op2, &rem);
				printf("Result: %d Remainder: %d\n", result, rem);
				continue;
			default:
				printf("Error: Invalid operator\n");
				continue;
		}

		printf("Result: %d\n", result);
	}
	
	return 0;
}
