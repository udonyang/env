struct Int {
	enum {sz = 90};
	int s[sz];
	Int(const char *x = "0") {
		memset(s, 0, sizeof(s));
		for (int xl = s[0] = strlen(x), i = xl; 0 < i; i--) {
			s[i] = x[xl - i] - '0';
		}
	}
	friend Int operator + (Int p, Int q) {
		Int o;
		o[0] = max(p[0], q[0]);
		for (int i = 1; i <= o[0]; i++) {
			o[i] += p[i] + q[i];
			o[i + 1] = o[i] / 10;
			o[i] %= 10;
		}
		if (o[o[0] + 1]) {
			o[0]++;
		}
		return o;
	}
	int & operator [] (int x) {
		return s[x];
	}
	void Print() {
		for (int i = s[0]; 0 < i; i--) {
			printf("%d", s[i]);
		}
	}
};
