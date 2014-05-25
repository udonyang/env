#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"

int main(int argc, char *argv[])
{
  printf("%*.*f\n", 12, atoi(argv[1]), atoi(argv[2]), 3.1415926);
	return 0;
}
