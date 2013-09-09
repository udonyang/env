#include <cstdio>
#include <cstring>
#include <iostream>
using namespace std;

template<class T> struct kmp_t {
  void get(T *p, int pl, int *f) {
    for (int i = 0, j = f[0] = -1; i < pl; f[++i] = ++j)
      for ( ; ~j && p[i] != p[j]; ) j = f[j];
  }
  void operator () (T *p, int pl, int *f) {
    int i = 0, j = f[0] = -1;
    for ( ; i < pl; i++, j++, f[i] = p[i] == p[j]? f[j]: j)
      for ( ; ~j && p[i] != p[j]; ) j = f[j];
  }
  int operator () (T *s, int sl, T *p, int pl, int *f) {
    int i = 0, j = 0;
    for ( ; i < sl && j < pl; i++, j++)
      for ( ; ~j && s[i] != p[j]; ) j = f[j];
    return j;
  }
};
template<class T> struct exkmp_t {
  void operator () (T *p, int pl, int *g) {
    g[g[1] = 0] = pl;
    for (int i = 1, k = 1; i < pl; (k+g[k] < i+g[i]? k = i: 0), i++)
      for (g[i] = min(g[i-k], max(k+g[k]-i, 0)); ; g[i]++)
        if (i+g[i] >= pl || p[i+g[i]] != p[g[i]]) break;
  }
  void operator () (T *s, int sl, int *f, T *p, int pl, int *g) {
    for (int i = f[0] = 0, k = 0; i < sl; (k+f[k] < i+f[i]? k = i: 0), i++)
      for (f[i] = min(g[i-k], max(k+f[k]-i, 0)); ; f[i]++)
        if (i+f[i] >= sl || f[i] >= pl || s[i+f[i]] != p[f[i]]) break;
  }
};

//main
int main() {
	return 0;
}
