#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"

int main() {
  int a[2] = {0, 1};
  const int *p = a;
  printf("%d\n", *p);
  *(int*)p = 1;
  printf("%d\n", *p);
	return 0;
}
