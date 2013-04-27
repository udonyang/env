//Contor En/Decode
// fac[i] = i!;
int fac[maxn];
void CEDCInit() {
	fac[0] = 1;
	for (int i = 1; i < maxn; i++) {
		fac[i] = fac[i - 1] * i;
	}	
}
/* CTDF(int Length, int ID, int *TargetArray) */
void CTDC(int l, int x, int *t) {
	int id = 0, h[100];
	x--;
	memset(h, 0, sizeof(h));
	for (int i = l - 1; 0 <= i; i--) {
		int rm = x / fac[i], rank = 0;
		for (int j = 1; j <= l; j++) {
			rank += !h[j];
			if (rank == rm + 1) {
				t[id++] = j;
				h[j] = 1;
				break;
			}
		}
		x %= fac[i];
	}
	puts("");
}
/* CTEC(int Length, int *SourceArray) */
int CTEC(int l, int *t) {
	int res = 0;
	for (int i = 0; i < l; i++) {
		int cnt = 0;
		for (int j = i + 1; j < l; j++) {
			if (t[j] < t[i]) {
				cnt++;
			}
		}
		res += cnt * fac[l - i - 1];
	}
	return res;
}
