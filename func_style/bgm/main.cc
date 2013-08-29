#include <cstdio>

struct bgm_t {
  int vis[N], pre[N], lma[N], rma[N];
  bool bfs(vector<edge_t> &E, int *L, int u) {
    vector<int> q(1, u);
    memset(vis, 0, sizeof(vis));
    memset(pre, -1, sizeof(pre));
    for (int h = 0; h < q.size(); h++) {
      u = q[h];
      for (int e = L[u]; ~e; e = E[e].to) {
        int v = E[e].v;
        if (!vis[v]) {
          vis[v] = 1;
          if (rma[v] == -1) {
            for ( ; ~u; ) {
              rma[v] = u;
              swap(v, lma[u]);
              u = pre[u];
            }
            return 1;
          } else {
            pre[rma[v]] = u;
            q.push_back(rma[v]);
          }
        }
      }
    }
    return 0;
  }
  int operator () (vector<edge_t> &E, int *L, int V) {
    int mmat = 0;
    memset(lma, -1, sizeof(lma));
    memset(rma, -1, sizeof(rma));
    for (int u = 0; u < V; u++)
      mmat += bfs(E, L, u);
    return mmat;
  }
} bgm;

//main
int main() {
	return 0;
}
