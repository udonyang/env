#include <cstdio>

template<class T> struct mana_t {
  void operator () (T *s, int &n, int *p) {
    for (int i = n<<1; i >= 0; i--) s[i] = i&1? s[i>>1]: -1;
    p[s[n = n<<1|1] = 0] = 1;
    for (int i = p[1] = 2, k = 1; i < n; i++) {
      p[i] = min(p[2*k-i], max(k+p[k]-i, 1));
      for (; p[i] <= i && i+p[i] < n && s[i-p[i]] == s[i+p[i]]; ) p[i]++;
      if (k+p[k] < i+p[i]) k = i;
    }
  }
};

//main
int main() {
	return 0;
}
