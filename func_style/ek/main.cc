#include <cstdio>

struct ek_t {
  vector<edge_t> E;
  int n, *L, src, snk, dis[N], ra[N], inq[N];
  int spfa(int u) {
    vector<int> q(1, u);
    memset(dis, 0x3f, sizeof(int)*n);
    memset(ra, -1, sizeof(int)*n);
    memset(inq, 0, sizeof(int)*n);
    dis[u] = 0;
    inq[u] = 1;
    for (int h = 0; h < q.size(); h++) {
      u = q[h], inq[u] = 0;
      for (int e = L[u]; ~e; e = E[e].to) {
        int v = E[e].v, w = E[e].w, c = E[e].c;
        if (w && dis[v] > dis[u]+c) {
          dis[v] = dis[u]+c;
          ra[v] = e^1;
          if (inq[v]) continue;
          inq[v] = 1;
          q.push_back(v);
        }
      }
    }
    return ra[snk] != -1;
  }
  int operator () (vector<edge_t> _E, int *_L, int _n, int _src, int _snk) {
    E = _E, L = _L, n = _n;
    src = _src, snk = _snk;
    int mmf = 0;
    for ( ; spfa(src); ) {
      int mf = inf;
      for (int e = ra[snk]; ~e; e = ra[E[e].v])
        mf = min(mf, E[e^1].w);
      for (int e = ra[snk]; ~e; e = ra[E[e].v])
        E[e].w += mf, E[e^1].w -= mf;
      mmf += dis[snk]*mf;
    }
    return mmf;
  }
} ek;

//main
int main() {
	return 0;
}
