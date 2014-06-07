#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"


int main()
{
  struct t_s{int a, b;} a = {0, 1}, b = {1, 2};
  void *c;

  c = &(struct {int a, b;}){3, 4};
  printf("c={%d, %d}\n",
      ((struct {int a,b;}*)c)->a,
      ((struct {int a,b;}*)c)->b);

  printf("a=(%d,%d), b=(%d,%d)\n", a.a, a.b, b.a, b.b);

	return 0;
}
