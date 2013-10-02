#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"

int (*a())[]
{
  printf("pass\n");
  return 0;
}

int main()
{
  void *c = a;

  ((int(*(*)())[])c)();

  struct t{double a; int b; char c;};

  printf("size = %d\n", sizeof(struct t));

	return 0;
}
