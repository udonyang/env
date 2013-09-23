#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
using namespace std;

int main() {
#if 1
  freopen("input.in", "r", stdin);
#endif
  for ( ; ; ) {
    char c[10];
    scanf("%s%*[ \t\n]", c);
//     scanf("%[a\n \t]", c);
    puts(c);
    break;
  }
  return 0;
}
