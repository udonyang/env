#include <cstdio>
#include <vector>
#include <cstring>
using namespace std;
const int N = 10;

namespace graph {
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
}

//main
int main() {
	return 0;
}
