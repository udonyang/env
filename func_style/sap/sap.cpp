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
