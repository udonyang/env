/* Contor coding.
 * Notice that x in [1, l!] in array->integer mapping
 * while x in [0, l!) in integer->array mapping. */
struct contor_t {
  int f[N];
  contor_t() {
    for (int i = f[0]= 1; i < N; i++)
      f[i] = f[i - 1]*i;
  }
  void operator () (int l, int x, int *t) {
    int id = 0, h[100] = {0};
    x--;
    for (int i = l-1; 0 <= i; i--) {
      int rm = x/f[i], rank = 0;
      for (int j = 1; j <= l; j++) {
        rank += !h[j];
        if (rank == rm+1) {
          t[id++] = j;
          h[j] = 1;
          break;
        }
      }
      x %= f[i];
    }
  }
  int operator () (int l, int *t) {
    int rv = 0;
    for (int i = 0; i < l; i++) {
      int cnt = 0;
      for (int j = i+1; j < l; j++)
        if (t[j] < t[i]) cnt++;
      rv += cnt*f[l-i-1];
    }
    return rv;
  }
} contor;
