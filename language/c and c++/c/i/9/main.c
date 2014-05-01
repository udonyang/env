#include "stdio.h"
#include "ctype.h"
#include "math.h"
int main() {
	/* The shift operators perform shift of their
	 * left operand by the number of bit position
	 * given by the right operand, which must be
	 * non-negative. */
	printf("%d\n", 4 << (-1));
	/* output:
	 *
	 * 		2.
	 *
	 * It seems that the right operand could
	 * be negative. */
	/* Right shifting a signed quantity will fill
	 * with bit signs (``arithmetic shift") on some
	 * machines and with 0-bits(``logical shift")
	 * on others. */
	char a = -2;
	unsigned char b = 255;
	printf("%d, %d, %d\n", a >> 3, a << 8, b >> 1);
	/* ouput:
	 *
	 * 		-1, -512, 127 */
	/* ~ yields the one's complements of an integer.
	 * ~ is independent of word length. */
	printf("%d %d\n", ~077, ~0177);
	/* output:
	 * 		-64, -128*/
	return 0;
}
