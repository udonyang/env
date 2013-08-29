#include <cstdio>
#include <vector>
using namespace std;
const int N = 1e5+10;
const int inf = 0x7f7f7f7f;

struct dmst_t {
  struct edge_t {
    int u, v, w;
  };
  vector<edge_t> E;
  int n, ine[N], pre[N], id[N], vis[N];
  void init(int _n) {
    n = _n;
    E.clear();
  }
  void add(int u, int v, int w) {
    edge_t t = {u, v, w};
    E.push_back(t);
  }
  int operator () (int rt) {
    int i, u, v, w, tn = n+1, index, rv = 0;
    for ( ; ; ) {
      fill(ine, ine+tn, inf);
      for (i = 0; i < E.size(); i++) {
        u = E[i].u; v = E[i].v; w = E[i].w;
        if (u != v && w < ine[v]) {
          pre[v] = u;
          ine[v] = w;
        }
      }
      for (u = 0; u < tn; u++) {
        if (u == rt) continue;
        if (ine[u] == inf)
          return -1;
      }
      index = 0;
      fill(id, id + tn, -1);
      fill(vis, vis + tn, -1);
      ine[rt] = 0;
      for (u = 0; u < tn; u++) {
        rv += ine[v = u];
        for ( ; v != rt && vis[v] != u && id[v] == -1; ) {
          vis[v] = u;
          v = pre[v];
        }
        if (v != rt && id[v] == -1) {
          for (i = pre[v]; i != v; i = pre[i]) id[i] = index;
          id[v] = index++;
        }
      }
      if (index == 0) break;
      for (u = 0; u < tn; u++)
        if (id[u] == -1) id[u] = index++;
      for (i = 0; i < E.size(); i++) {
        v = E[i].v;
        E[i].u = id[E[i].u];
        E[i].v = id[E[i].v];
        if (E[i].u != E[i].v) E[i].w -= ine[v];
      }
      tn = index;
      rt = id[rt];
    }
    return rv;
  }
} dmst;

//main
int main() {
	return 0;
}
