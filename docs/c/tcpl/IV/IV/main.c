#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"

int main() {
  extern int top;
  register char c;
  top = 0;
  printf("%d\n", pop());
  printf("%p\n", &c);
	return 0;
}
