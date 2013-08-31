#include <cstdio>
const int N = 1e5;

struct spfa_t {
  int d[N], b[N], c[N], s[N], mx[N];
  int operator () (vector<edge_t> &E, int *L, int n, int u) {
    memset(d, 0x7f, sizeof(d));
    memset(b, 0, sizeof(b));
    memset(c, 0, sizeof(c));
    d[s[s[0] = 1] = u] = 0;
    b[u] = c[u] = 1;
    for ( ; s[0]; ) {
      b[u = s[s[0]--]] = 0;
      for (int e = L[u]; ~e; e = E[e].to) {
        int v = E[e].v, w = E[e].w;
        if (d[v]-w > d[u]) {
          d[v] = d[u]+w;
          if (!b[v]) {
            if ((c[v] += b[v] = 1) > n) return 0;
            s[++s[0]] = v;
          }
        }
      }
    }
    return 1;
  }
} spfa;

//main
int main() {
	return 0;
}
