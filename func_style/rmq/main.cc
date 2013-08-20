#include <cstdio>
#include <iostream>
using namespace std;
const int N = 1e5+10;

void rmq_init(int (*s)[N], int l, int *k) {
  for (int i = 0; i < l; i++) s[0][i] = i;
  for (int i = 1; i < 20; i++)
    if ((1<<i) <= l) for (int j = 0; j < l; j++)
      if (k[s[i-1][j]] < k[s[i-1][j+(1<<(i-1))]]) s[i][j] = s[i-1][j];
      else s[i][j] = s[i-1][j+(1<<(i-1))];
}
int rmq_ask(int (*s)[N], int l, int r, int *k) {
  if (l > r) swap(l ,r);
  int i = r-l+1, o = 1, j = 0;
  for (int o = 1 ; o <= i; o <<= 1) j++;
  j--, r = r-(1<<j)+1;
  return k[s[j][l]] < k[s[j][r]]? s[j][l]: s[j][r];
}

//main
int main() {
	return 0;
}
