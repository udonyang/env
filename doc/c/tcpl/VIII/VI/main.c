#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/dir.h>
#include <fcntl.h>
#include "dirent.h"

int main(int argc, char **argv)
{
  if (argc == 1) {
    fsize(".");
  } else {
    for ( ; --argc > 0; ) {
      fsize(*++argv);
    }
  }
  return 0;
}
