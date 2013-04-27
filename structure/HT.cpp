struct HT {
	enum {sz = 256};
	int h[sz], index;
	void Init() {
		index = 0;
		memset(h, -1, sizeof(h));
	}
	int operator [] (int x) {
		if (h[x] == -1) {
			h[x] = index++;
		}
		return h[x];
	}
};
