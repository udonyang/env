//Doubling LCA
//usage: LCAInit()->LCA();
void LCAInit(int u, int d = 0, int p = -1) { dep[u] = d;
	if (p != -1) {
		anc[u][0] = p;
		for (int i = 1; i < 20; i++) {
			anc[u][i] = anc[anc[u][i - 1]][i - 1];
		}
	}
	for (int i = L[u]; i != -1; i = E[i].t) {
		if (E[i].v != p) {
			LCAInit(E[i].v, d + 1, u);
		}
	}
}
void JKA(int &u, int k) {
	for ( ; k; k -= -k & k) {
		for (int i = 0; i < 20; i++) {
			if ((1 << i) == (-k & k)) {
				u = anc[u][i];
				break;
			}
		}
	}
}
int LCA(int u, int v) {
	if (dep[u] < dep[v]) {
		swap(u, v);
	}
	JKA(u, dep[u] - dep[v]);
	for (int i = 20; u != v && 0 <= i; i--) {
		if ((1 << i) <= dep[u] && anc[u][i] != anc[v][i]) {
			u = anc[u][i];
			v = anc[v][i];
		}
	}
	return u == v? u: anc[u][0];
}
