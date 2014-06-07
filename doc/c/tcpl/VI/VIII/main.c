#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"

int main()
{
  union t {
    int ival;
    float fval;
    char *sval;
  } t;

  t.sval = "haha";
  printf("size = %d\ns\n", sizeof(t), t.sval);

	return 0;
}
