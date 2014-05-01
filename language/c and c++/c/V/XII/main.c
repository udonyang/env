#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"

int int_a(void)
{
  return 0;
}

int int_b(void)
{
  return 1;
}

int (*int_c(void))[]
{
  static int s[3] = {0, 1, 2};
  return &s;
}

int (*int_d(void))[]
{
  static int s[3] = {2, 3, 4};
  return &s;
}

int main()
{
  int i, j,
      (*(*a[3])())[] = {int_c, int_d, 0},
      (*b[2])() = {int_a, int_b},
      ci;

  printf("%d, %d\n", b[0](), b[1]());
  for (i = 0; i < 2; i++) {
    for (j = 0; j < 3; j++) {
      printf("%d%c", (*a[i]())[j],
          j < 2? ',': '\n');
    }
  }

	return 0;
}
