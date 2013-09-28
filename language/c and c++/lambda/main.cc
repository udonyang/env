#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
using namespace std;

int main() {
#if 1
  freopen("input.in", "r", stdin);
#endif
  int c = 3;
  auto f = [&](int a, int b) -> int { return a+b+c; };
  printf("%d %d\n", f(1, 2), c);
  return 0;
}
