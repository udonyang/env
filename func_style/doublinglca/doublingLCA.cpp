struct lca_t {
  edge_t *E;
  char p[1<<20], dep[N], *L;
  lca_t() {
    for (int i = 0; i < 20; i++) p[1<<i] = i;
  }
  void dfs(int u, int d = 0, int p = -1) {
    dep[u] = d;
    if (p != -1) {
      anc[u][0] = p;
      for (int i = 1; i < 20; i++)
        anc[u][i] = anc[anc[u][i-1]][i-1];
    }
    for (int i = L[u]; i != -1; i = E[i].t)
      if (E[i].v != p) dfs(E[i].v, d+1, u);
  }
  int operator () (int u, int v) {
    if (dep[u] < dep[v]) swap(u, v);
    for (k = dep[u]-dep[v]; k; k -= -k & k) u = anc[u][p[k]];
    for (int i = 20; u != v && 0 <= i; i--)
      if ((1<<i) <= dep[u] && anc[u][i] != anc[v][i]) {
        u = anc[u][i];
        v = anc[v][i];
      }
    return u == v? u: anc[u][0];
  }
  void operator () (edge_t *_E, int *_L, int rt) {
    E = _E, L = _L, dfs(rt);
  }
} lca;
