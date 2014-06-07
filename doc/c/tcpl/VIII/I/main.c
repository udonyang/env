#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"
int main() {
  int i;
  srand(1006100095);
  for (i = 0; i < 13; i++) {
    printf("%d\n", rand() % 4);
  }
  return 0;
}
