struct sap_t {
  int dis[N], gap[N], _L[N], se[N];
  int operator () (edge_t *E, int *L, int V, int src, int snk) {
    int mxf = 0, te = 0;
    memcpy(_L, L, sizeof(L));  
    memset(dis, -1, sizeof(dis));
    memset(gap, 0, sizeof(gap));  
    gap[dis[snk] = 0] = 1;  
    vector<int> q(1, snk);
    for (int h = 0; h < q.size(); h++)
      for (int i = L[q[h]]; i != -1; i = E[i].to)
        if (E[i].w && dis[E[i].v] < 0) {
          gap[dis[E[i].v] = dis[q[h]]+1]++;
          q.push_back(E[i].v);
        }
    for (int u = src; dis[src] < V; ) {
      for (int &i = _L[u]; i != -1; i = E[i].to)
        if (E[i].w && dis[u] == dis[E[i].v] + 1) break;  
      if (_L[u] != -1) {
        u = E[se[te++] = _L[u]].v;
        if (u == snk) {
          int _i = 0, mf = inf;
          for (int i = 0; i < te; i++)
            if (E[se[i]].w < mf) {
              mf = E[se[i]].w;
              _i = i;
            }
          for (int i = 0; i < te; i++) {
            E[se[i]].w -= mf;
            E[se[i]^1].w += mf;
          }
          mxf += mf;
          u = E[se[te = _i]^1].v;
        }
        continue;
      }
      int md = V;
      _L[u] = -1;
      for (int i = L[u]; i != -1; i = E[i].to)
        if (E[i].w && dis[E[i].v] < md) {
          md = dis[E[i].v];
          _L[u] = i;
        }
      if (!--gap[dis[u]]) break;
      gap[dis[u] = md+1]++;
      if (u != src) u = E[se[te---1]^1].v;
    }
    return mxf;
  }
} sap;
