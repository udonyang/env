#include "stdio.h"
/* the direction of truncation for / and the 
 * sign of result for % are machine-dependent
 * for negative operands, as is the action
 * taken on overflow or underflow. */
int main() {
	int a = 2, b = -5;
	printf("%d / %d = %d\n", b, a, b / a);
	printf("%d %% %d = %d\n", a, b, a % b);
	printf("%d %% %d = %d\n", b, a, b % a);
	return 0;
}
