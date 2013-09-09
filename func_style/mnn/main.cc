#include <cstdio>

template<class T, class C> struct mnn_t {
  int operator () (T *s, int n) {
    int i = 0, j = 1;
    for (int k = 0; k < n; )
      if (s[(i+k)%n] == s[(j+k)%n]) k++;
      else if (C()(s[(i+k)%n], s[(j+k)%n])) j += k+1, k = 0;
      else i += k+1, j = i+1, k = 0;
    return i;
  }
};

//main
int main() {
	return 0;
}
