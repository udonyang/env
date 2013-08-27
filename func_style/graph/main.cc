#include <cstdio>
#include <vector>
#include <cstring>
using namespace std;
const int N = 10;

namespace graph {
  struct edge_t {
    int v, to;
  } E[N<<2];
  int L[N];
  void init() {
    E[0] = 0
    memset(L, -1, sizeof(L));
  }
  void add(int u, int v) {
    edge_t t = {v, L[u]};
    E[L[u] = ++E[0]] = t;
  }
}

//main
int main() {
	return 0;
}
