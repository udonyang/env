#include "stdio.h"
/* extern or global variable will be initialized to 0 by defualt
 * Automatic variables for which is no explicit initializer
 * have undefined values. */ 
int global;
void variableTest() {
	for ( ; ; ) {
		extern int global;
		printf("%d\n", global);
		break;
	}
	for ( ; ; ) {
		static int global;
		printf("%d\n", global);
		break;
	}
	for ( ; ; ) {
		int global;
		printf("%d\n", global);
		break;
	}
}
int main() {
	variableTest();
	return 0;
}
