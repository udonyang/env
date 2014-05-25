#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <time.h>

#include <dac/v2/Comm.h>

#include <Atype.h>
#include <Btype.h>

void TestGotoAux1(int x)
{
  if (x) goto out1;
  return ;
out1:
  printf("Aux1\n");
}

void TestGotoAux2(int x)
{
  if (x) goto out2;
  return ;
out2:
  printf("Aux2\n");
}

void TestGoto()
{
  TestGotoAux1(1);
  TestGotoAux2(1);
}

void TestMem()
{
  char *buf;
  size_t size;
  FILE* file = open_memstream(&buf, &size);
  for (int i = 0; i < 60000; i++) {
    char* esc = DacRaw2Esc("\t\n");
    fprintf(file, esc);
    free(esc);
  }
  fclose(file);
  printf("size = %d\n", size);
  file = fmemopen(buf, size, "r");
  size = 0;
  while (fgetc(file) != EOF)
    size++;
  printf("-- size %d\n", size);
  fclose(file);
  free(buf);
}

void TestPrintf()
{
  char buf[5];
  int a = 0;
  int size = sizeof(buf);
  printf("%d\n", sprintf(buf, "cccc %d", 10000));
  printf("size = %d\n", snprintf(NULL, 0, "cccc %d", 10000));
  printf("%s%d\n", buf, "\n", a);
  printf("%b\n", "\n");
}

void TestCtype()
{
  char buf[10] = "\n\t \f\v\r\b\a\0";
  for (int i = 0; i < strlen(buf); i++)
    printf("%d", isgraph(buf[i]));
  puts("");
}

int main(int argc, char** argv, char** env)
{
  time_t start_stamp = time(0);
  // TestGoto();
  // TestMem();
  TestPrintf();
  // TestCtype();
  printf("time = %d\n", time(0) - start_stamp);
  return 0;
}
