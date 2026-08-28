signed char var1 = 1;
unsigned char var2 = 2;
signed int var3 = 3;
unsigned int var4 = 4;
const int num  = -10;
char wave[10] ="goodbye!!";

void main() {
	int var5 = 5;
	for (var5; var5>0; var5--)
	{
		var1*=var1;
		var1/=var1;
		var1+=var1;
		var1-=var1;
	}

	do {
		var4-=1;
	} while (var4>0);

	while(var3==3)
	{
		var2 = var2;
		break;
	}
}
