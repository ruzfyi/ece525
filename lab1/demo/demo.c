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
	// infinite loop to run the program in
	// this loop is equivalent to just repeatedly doing an rjmp back
	// to start as all the values remain initialized in their previous state
	
	printf("Calculator Program\nEnter a number to start, -1 to exit...\n");
	while (1) {
		printf("First operand: ");
		scanf("%d", &op1);
		
		choose_operand:
	
		printf("Operation (+, -, *, /), -1 to exit: ");
		scanf(" %c\n", &op);

		if (op1 == -1) { goto stop; }

		switch (op) {
			case '+':
				printf("Second operand: ");
				scanf("%d", &op2);
				result = add(op1, op2);
				break;
			case '-':
				printf("Second operand: ");
				scanf("%d", &op2);
				result = sub(op1, op2);
				break;
			case '*':
				printf("Second operand: ");
				scanf("%d", &op2);
				result = mul(op1, op2);
				break;
			case '/':
				printf("Second operand: ");
				scanf("%d", &op2);
				int rem;
				result = div(op1, op2, &rem);
				printf("Remainder: %d\n", rem);
				break;
			default:
				printf("Not a valid operation, choose a different operation...");
				goto choose_operand;
				break;
		}

		printf("Result: %d", result);
	}

	stop:

	return 0;
}
