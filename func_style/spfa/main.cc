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
  struct node {
    int u, w;
    node (int _u = 0, int _w = 0): u(_u), w(_w) {}
    friend bool operator < (const node &lhs, const node &rhs) {
      return lhs.w > rhs.w;
    }
  };
  void operator () (vector<edge_t> &E, int *L, int u) {
    memset(d, 0x7f, sizeof(d));
    memset(b, 0, sizeof(b));
    priority_queue<node> q;
    for (q.push(node(u, d[u] = 0)); q.size(); ) {
      u = q.top().u, q.pop();
      if (b[u]++) continue;
      for (int e = L[u]; ~e; e = E[e].to) {
        int v = E[e].v, w = E[e].w;
        if (b[u] && d[v]-w > d[u])
          q.push(node(v, d[v] = d[u]+w));
      }
    }
  }
} spfa;

//main
int main() {
	return 0;
}
