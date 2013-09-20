#include <cstdio>

/* N  : upper bound
 * p[]: primes
 * n  : primes number
 * e[]: eular funtion
 * d[]: divisors number
 * f[]: minimum prime factor
 * c[]: minimum prime factor's power
 * m[]: mobius function
 * */
template<int N> struct sieve_t {
  int b[N], p[N], n, e[N], d[N], f[N], c[N], m[N];
  sieve_t() {
    memset(this, 0, sizeof(sieve_t));
    d[1] = m[1] = 1;
    for (int i = 2; i < N; i++) {
      if (!b[i]) {
        e[i] = i-1;
        c[i] = 1;
        d[i] = 2;
        f[i] = i;
        m[i] = -1;
        p[n++] = i;
      }
      for (int j = 0; j < n && 1ll*i*p[j] < N; j++) {
        int k = i*p[j];
        b[k] = 1;
        f[k] = p[j];
        if (i%p[j]) {
          e[k] = e[i]*(p[j]-1);
          c[k] = 1;
          d[k] = d[i]*(c[k]+1);
          m[k] = m[i]*m[p[j]];
        } else {
          e[k] = e[i]*p[j];
          c[k] = c[i]+1;
          d[k] = d[i]/(c[i]+1)*(c[k]+1);
          m[k] = 0;
          break;
        }
      }
    }
  }
};

//main
int main() {
	return 0;
}
