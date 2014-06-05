#include <stdio.h>
#include <counter.h>

int main(int argc, char **argv)
{
  int r[4];
  counter(r);
  printf("%d %d %d %d\n",
      r[0],
      r[1],
      r[2],
      r[3]);
  return 0;
}
