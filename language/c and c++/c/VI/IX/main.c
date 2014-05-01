#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"

int main()
{
  struct bit {
    int :1;
    int :1;
  } f;

  printf("%d\n", sizeof(f));

	return 0;
}
