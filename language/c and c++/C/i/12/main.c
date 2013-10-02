#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"
/* C does not specify the order in which the 
 * operands of an operator are evaluated.
 * It's compiler dependent. */
int x;
int f() {
	return x / 2;
}
int g() {
	return x / 2;
}
int main() {
	x = 3;
	printf("%d\n", g() + x++ + f());
	/* output:
	 * 		
	 * 		5 = 1 + 3 + 1 */
	x = 3;
	printf("%d\n", g() + (x += 1) + f());
	/* output:
	 * 		
	 * 		7 = 1 + 4 + 2 */
	x = 3;
	printf("%d\n", x++ + g() + f());
	/* output:
	 * 		
	 * 		5 = 3 + 1 + 1 */
	x = 3;
	printf("%d\n", g() + ++x + f());
	/* output:
	 * 		
	 * 		7 = 1 + 4 + 2 */
	x = 3;
	printf("%d\n", ++x + g() + f());
	/* output:
	 * 		
	 * 		8 = 4 + 2 + 2 */
	/* It seems that GCC evaluates expression
	 * from left to right when we call a 
	 * function. 
	 * Besides, ++x and assignment make sense
	 * that change the x, while x++ doesn't. */
	x = 3;
	printf("%d, %d\n", ++x, g() + f());
	/* output:
	 * 		
	 * 		4, 2 */
	x = 3;
	printf("%d, %d\n", g() + f(), ++x);
	/* output:
	 * 		
	 * 		4, 4 */
	/* It seems that GCC evaluates parameters
	 * from right to left when we call a 
	 * function. */
	return 0;
}
