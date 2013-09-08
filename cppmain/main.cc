#include <cstdio>
#include <bitset>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>
#include <cctype>
#include <cmath>
#include <map>
#include <string>
#include <vector>
using namespace std;
typedef long long ll_t;
#define _be begin()
#define _en end()
#define _i(t) t::iterator
typedef vector<int> vi_t;
typedef vector<string> vs_t;
typedef map<int, int> mii_t;
typedef pair<int, int> pii_t;
#define _fi first
#define _se second
const int N = 1e5+10;

struct edge_t {
  int v, to;
};
vector<edge_t> E;
int L[N];
void init() {
  E.clear();
  memset(L, -1, sizeof(L));
}
void add(int u, int v) {
  edge_t t = {v, L[u]};
  L[u] = E.size();
  E.push_back(t);
}

struct trvl_t {
  typedef void (*t_f)(int, int);
  void rtc(int r, int n, int c, int m, t_f f) {
    for (int i = r; i < n; i++)
      for (int j = c; j < m; j++) f(i, j);
  }
  void ctr(int r, int n, int c, int m, t_f f) {
    for (int j = c; j < m; j++) 
      for (int i = r; i < n; i++) f(i, j);
  }
  void pth(int r, int n, int c, int m, int dr, int dc, t_f f) {
    for (int i = 0; i < n; i++)
      if (0 <= r+dr && r+dr < n && 0 <= c+dc && c+dc < m)
        f(r+dr, c+dc);
  }
} trvl;

class $CLASSNAME$ {
  public:
    $RC$ $METHODNAME$($METHODPARMS$) {

    }
};
