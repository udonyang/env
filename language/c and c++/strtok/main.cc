#include <cstdio>
#include <functional>
#include <cctype>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <numeric>
#include <algorithm>
#include <queue>
using namespace std;

char test[] = "1238172938-asfasdfjka-aafa -218712938",
     dlim[] = "-";
char to[100];
int len = strlen(test);

int main() {
#if 1
  freopen("input.in", "r", stdin);
#endif
  for (char *i = strtok(test, dlim); i; i = strtok(0, dlim)) {
    printf("%s'\n", i);
  }
  printf("%s\n", test);
  return 0;
}
