#include <cstdio>

struct zkw_t {
  vector<edge_t> E;
  int n, src, snk, mc, mf, dis, vis[N], *L;
  int ap(int u, int f) {
    if (u == snk) {
      mc += dis*f;
      mf += f;
      return f;
    }
    vis[u] = 1;
    int rf = f;
    for (int e = L[u]; e > -1; e = E[e].to)
      if (!vis[E[e].v] && E[e].w && !E[e].c) {
        int df = ap(E[e].v, min(rf, E[e].w));
        E[e].w -= df;
        E[e^1].w += df;
        rf -= df;
        if (!rf) return f;
      }
    return f-rf;
  }
  int ml() {
    int md = inf;
    for (int u = 0; u < n; u++) if (vis[u])
      for (int e = L[u]; ~e; e = E[e].to)
        if (!vis[E[e].v] && E[e].w)
          md = min(md, E[e].c);
    if (md == inf) return 0;
    for (int u = 0; u < n; u++) if (vis[u])
      for (int e = L[u]; ~e; e = E[e].to) {
        E[e].c -= md;
        E[e^1].c += md;
      }
    dis += md;
    return 1;
  }
  int operator () (vector<edge_t> &_E, int *_L, int _n, int _src, int _snk) {
    E = _E, L = _L, n = _n;
    src = _src, snk = _snk;
    mf = mc = dis = 0;
    for ( ; ; ) {
      for ( ; ; ) {
        memset(vis, 0, sizeof vis);
        if (!ap(src, inf)) break;
      }
      if (!ml()) break;
    }
    return mc;
  }
} zkw;

//main
int main() {
	return 0;
}
