struct lca_t {
  static const int M = 16;
  int d[N], a[N][M], p[1<<M];
  void operator () (vector<edge_t> E, int *L, int u) {
    vector<int> q(1, u);
    memset(a, -1, sizeof(a));
    for (int h = d[u] = 0; h < q.size(); h++) {
      u = q[h];
      for (int i = 1; i < M; i++)
        if (~a[u][i-1]) a[u][i] = a[a[u][i-1]][i-1];
      for (int e = L[u]; ~e; e = E[e].to) {
        int v = E[e].v;
        if (v == a[u][0]) continue;
        d[v] = d[u]+1;
        a[v][0] = u;
        q.push_back(v);
      }
    }
    for (int i = 0; i < M; i++) p[1<<i] = i;
  }
  int skip(int u, int x) {
    for ( ; x; x -= -x&x) u = a[u][p[-x&x]];
    return u;
  }
  int operator () (int u, int v) {
    if (d[u] < d[v]) swap(u, v);
    u = skip(u, d[u]-d[v]);
    if (u == v) return u;
    for (int i = M-1; ~i && a[u][0] != a[v][0]; i--)
      if (~a[u][i] && a[u][i] != a[v][i])
        u = a[u][i], v = a[v][i];
    return a[u][0];
  }
} lca;
