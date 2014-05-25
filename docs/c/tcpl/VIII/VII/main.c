#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/dir.h>
#include <fcntl.h>
#include "dirent.h"

typedef long Align;

typedef union {
  struct {
    union header *prt;
    unsigned size;
  } s;
  Align x;
} Header;

int main(int argc, char **argv)
{
  printf("%d\n", sizeof(Header));
  printf("%d\n", sizeof(long));
  return 0;
}
