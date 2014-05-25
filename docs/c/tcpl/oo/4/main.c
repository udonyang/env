#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"

#include "Set.h"
#include "new.h"
#include "String.h"

int main() {

	void * a = new(String, "aasdfasdfc");
	void * aa = clone(a);
	void * b = new(String, "b");

	printf("sizeOf(a) == %u\n", sizeOf(a));
	if (differ(a, b))
		puts("ok");
	if (differ(a, aa))
		puts("differ?");
	if (a == aa)
		puts("clone?");
	delete(a), delete(aa), delete(b);

	return 0;
}
