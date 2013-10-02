#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"

void mat(int (*b)[2])
{
  int i, j;

  for (i = 0; i < 2; i++) {
    for (j = 0; j < 2; j++) {
      printf("%d", b[i][j]);
    }
    puts("");
  }
}

int main()
{
  int a[2][2] = {
    1, 0,
    0, 1
  };

  mat(a);

	return 0;
}
