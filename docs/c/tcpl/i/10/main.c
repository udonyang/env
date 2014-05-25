#include "stdio.h"
/* faster bit count
 * Why x &= x - 1 works as if it removes the right most
 * 1 from x?
 * Assume that x has the form like this:
 *
 * 		...10000
 *
 * What would happen if we substrat x by 1?
 * It should be like this:
 *
 * 		...01111
 *
 * As a clever man you are, you must found that x - 1
 * is a mask which the same position of the rightmost 1 as in x is 0.
 * As the rightmost 1 means that the right side of this 1 is
 * all 0. so when we had done the & operation.
 * It should be like this:
 *
 * 		...10000
 * 	&	...01111
 * 	_____________
 * 		...00000
 *
 * 	Hence the rightmost 1 would disapper. */
int bitCount(int x) {
	int c = 0;
	for ( ; x; x &= x - 1) {
		c++;
	}
	return c;
}
int main() {
	printf("bitCount(%d) = %d\n", 7, bitCount(7));
	return 0;
}
