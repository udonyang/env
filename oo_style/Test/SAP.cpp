//structures
//Linking list Graph
//include: vector
struct LLG {
  struct Edge {
    //Externs should be defined here
    int w;
    //Basic
    int v,       //Adjust node v
        next;    //Index of the next node v
  };
  const static int n = maxn;
  const static int m = maxn;
  Edge E[m];    //Aarry in which Edges store
  int  L[n],    //Head of linking list of nodes
       El,         //Total of Edges
       V;          //Total of nodes
  //Init
  //usage: obj.Init(int TotalOfNode)
  void Init(int _V = 0) {
    V = _V;
    El = 0;
    memset(L, -1, sizeof(L));
  }
  //AddEdge 
  //usage: obj.AddEdge(From, To, Extern)
  void AddEdge(int u, int v, int w) {
    Edge t =  {w, v, L[u]}; //rule: Node t = {Extern, Basic}
  L[u] = El;
  E[El++] = t;
  }
  //FlowAddEdge 
  //usage: obj.FlowAddEdge(From, To, Extern)
  void FlowAddEdge(int u, int v, int w) {
    AddEdge(u, v, w);
    AddEdge(v, u, 0);
  }
};
//SAP  
//include: LLG
int SAP(int src, int snk, LLG *G){
  const int n = maxn;
  const int inf = inf32;
  typedef int AI[n];
  static AI dis, gap, _L, se, Q;
  int u = src, mxf = 0, te = 0, Qf = 0, Qt = 0;
  int V = G->V, *L = G->L;
  LLG::Edge *E = G->E;
  memcpy(_L, L, sizeof L);  
  memset(dis, -1, sizeof(dis));
  memset(gap, 0, sizeof(gap));  
  gap[dis[snk] = 0] = 1;  
  Q[Qt++] = snk;
  while (Qf < Qt){ 
    int u = Q[Qf++];
    for (int i = L[u]; i != -1; i = E[i].next) {
      if (E[i].w && dis[E[i].v] < 0){  
        gap[dis[E[i].v] = dis[u] + 1]++;
        Q[Qt++] = E[i].v;  
      }  
    }
  }
  while (dis[src] < V) {
    for (int &i = _L[u]; i != -1; i = E[i].next) {
      if (E[i].w && dis[u] == dis[E[i].v] + 1) {
        break;  
      }
    }
    if (_L[u] != -1) {  
      u = E[se[te++] = _L[u]].v;  
      if (u == snk) {  
        int _i = 0, mf = inf;  
        for (int i = 0; i < te; i++) {
          if (E[se[i]].w < mf){  
            mf = E[se[i]].w;
            _i = i;  
          }
        }  
        for (int i = 0; i < te; i++) { 
          E[se[i]].w -= mf;
          E[se[i] ^ 1].w += mf;  
        }  
        mxf += mf;
        te = _i;  
        u = E[se[_i] ^ 1].v;  
      }  
      continue;  
    }  
    int md = V;
    _L[u] = -1;  
    for (int i = L[u]; i != -1; i = E[i].next) {
      if (E[i].w && dis[E[i].v] < md){  
        md = dis[E[i].v];
        _L[u] = i;  
      }  
    }
    if (!--gap[dis[u]]) {
      break;  
    }
    gap[dis[u] = md + 1]++;  
    if (u != src) {
      u = E[se[te-- - 1] ^ 1].v;  
    }
  }  
  return mxf;  
}  