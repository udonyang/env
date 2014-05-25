#include "stdio.h"
#include "ctype.h"
#include "math.h"
/* conversion rules:
 * 	convert a "narrower" oprand into "wider" one without losing
 * 		information.
 * 	long double <- double <- float <- int, long
 * 	<- char, short 
 *
 * 	the comparision between signed and unsigned type is
 * 	machine dependent 
 *
 * 	When double converted to float, whether the
 * 	value is rounded or truncated is implementation dependent. 
 * 	In the absence of function prototype, char 
 * 	and short become int, and float becomes double.*/
double dMax(double x, double y) {
	return x > y? x: y;
}
int main() {
	int a = 2;
	printf("int(%d)%d -> float(%d)%f\n",
			sizeof(int), a, sizeof(float), 0.0 + a);
	/* isdigit may return any non-zero vaule
	 * for true. */
	printf("isdigit(%d) = %d\n",
			'5', isdigit('5'));
	/* longer are converted to shorter one by dropping the
	 * excess higher bits. */
	int i = 256; 
	char c = i;
	printf("i = %d, c = %d\n", i, c);
	/* The meaning of cast is as if the expression
	 * were assigned to a variable of the specified
	 * typ.
	 * (``coerced") is an unary operator and has the
	 * same precedence as unary + and -. */
	int x = 0x7fffffff, y = 0x7fffffff;
	printf("%d * %d = %lld\n", x, y, (long long)1 + x * y);
	printf("%f\n", dMax(2, 0));
	return 0;
}
