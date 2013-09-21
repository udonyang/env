#include <cstdio>

template<int N> struct hld_t {
  typedef int ai_t[N];
  int n;
  ai_t d, sz, fa, hv, in, cl, id;
  void operator () (vector<edge_t> &E, int *L, int V, int u) {
    vector<int> q(1, u);
    n = V;
    d[u] = 0;
    fa[u] = -1;
    for (int h = 0; h < q.size(); h++) {
      u = q[h];
      for (int e = L[u]; ~e; e = E[e].to) {
        int v = E[e].v;
        if (v == fa[u]) continue;
        fa[v] = u;
        d[v] = d[u]+1;
        q.push_back(v);
      }
    }
    for (int h = q.size()-1; ~h; h--) {
      u = q[h];
      sz[u] = 1;
      hv[u] = -1;
      for (int e = L[u]; ~e; e = E[e].to) {
        int v = E[e].v;
        if (v == fa[u]) continue;
        if (!~hv[u] || sz[v] > sz[hv[u]]) hv[u] = v;
        sz[u] += sz[v];
      }
    }
    q.resize(1);
    in[q[0]] = q[0];
    id[q[0]] = 0;
    cl[q[0]] = 1;
    for (int h = 0; h < q.size(); h++) {
      u = q[h];
      for (int e = L[u]; ~e; e = E[e].to) {
        int v = E[e].v;
        if (v == fa[u]) continue;
        if (v == hv[u]) {
          in[v] = in[u];
          id[v] = id[u]+1;
          cl[in[v]]++;
        } else {
          in[v] = v;
          cl[v] = 1;
          id[v] = 0;
        }
        q.push_back(v);
      }
    }
  }
  void make() {
  }
  void put(int v, int w) {
  }
  int ask(int u, int v) {
    int rv = 0;
    for ( ; in[u]^in[v]; u = fa[in[u]]) {
      if (d[in[u]] > d[in[v]]) swap(u, v);
    }
    if (id[u] > id[v]) swap(u, v);
    return rv;
  }
};

//main
int main() {
	return 0;
}
