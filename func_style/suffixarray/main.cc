#include <cstdio>
#include <cstring>
#include <iostream>
using namespace std;
const int maxn = 1e5;

#if 1
void sa_da(int *s, int n, int *sa, int m)
{
#define da_F(c, a, b) for (int c = (a); i < (b); i++)
#define da_C(s, a, b, l) (s[a] == s[b] && s[a+l] == s[b+l])
#define da_R(x, y, z) da_F(i, 0, m) ws[i] = 0; da_F(i, 0, n) ws[x]++;\
  da_F(i, 1, m) ws[i] += ws[i-1]; da_F(i, 0, n) sa[--ws[y]] = z;
  static int wa[maxn], wb[maxn], wv[maxn], ws[maxn];
  int *x = wa, *y = wb;
  da_R(x[i] = s[i], x[n-i-1], n-i-1);
  for(int j = 1,  p = 1; p < n; j *= 2, m = p) {
    da_F(i, (p = 0, n-j), n) y[p++] = i;
    da_F(i, 0, n) if(sa[i] >= j) y[p++] = sa[i]-j;
    da_F(i, 0, n) wv[i] = x[y[i]];
    da_R(wv[i], wv[n-i-1], y[n-i-1]);
    da_F(i, (swap(x, y), x[sa[0]] = 0, p = 1), n)
      x[sa[i]] = da_C(y, sa[i-1], sa[i], j)? p-1: p++;
  }
}
#if 0
int sa_dc3_c12(int k, int *r, int a, int b, int *wv)
{
  if (k != 2) return r[a]<r[b] || r[a]==r[b] && wv[a+1]<wv[b+1];
  return r[a]<r[b] || r[a]==r[b] && sa_dc3_c12(1, r, a+1, b+1, wv);
}
void sa_dc3(int *s, int n, int *sa, int m)
{
#define dc3_H(x) ((x)/3+((x)%3 == 1? 0: tb))
#define dc3_G(x) ((x) < tb? (x)*3+1: ((x)-tb)*3+2)
#define dc3_c0(s, a, b) (s[a]==s[b] && s[a+1]==s[b+1] && s[a+2]==s[b+2])
#define dc3_F(c, a, b) for (int c = (a); c < (b); c++)
#define dc3_sort(s, a, b, n, m) dc3_F(i, 0, n) wv[i] = (s)[(a)[i]];\
  dc3_F(i, 0, m) ws[i] = 0; dc3_F(i, 0, n) ws[wv[i]]++;\
  dc3_F(i, 1, m) ws[i] += ws[i-1];\
  dc3_F(i, 0, n) (b)[--ws[wv[n-i-1]]] = a[n-i-1];
  static int wa[maxn], wb[maxn], wv[maxn], ws[maxn];
  int i, j, *rn = s+n, *san = sa+n, ta = 0, tb = (n+1)/3, tbc = 0, p;
  dc3_F(i, s[n] = s[n+1] = 0, n) if(i%3) wa[tbc++] = i;
  dc3_sort(s+2, wa, wb, tbc, m);
  dc3_sort(s+1, wb, wa, tbc, m);
  dc3_sort(s, wa, wb, tbc, m);
  dc3_F(i, (rn[dc3_H(wb[0])] = 0, p = 1), tbc)
    rn[dc3_H(wb[i])] = dc3_c0(s, wb[i-1], wb[i])? p-1: p++;
  if(p < tbc) sa_dc3(rn, tbc, san, p);
  else dc3_F(i, 0, tbc) san[rn[i]] = i;
  dc3_F(i, 0, tbc) if(san[i] < tb) wb[ta++] = san[i]*3;
  if(n%3 == 1) wb[ta++] = n-1;
  dc3_sort(s, wb, wa, ta, m);
  dc3_F(i, 0, tbc) wv[wb[i] = dc3_G(san[i])] = i;
  for(i = j = p = 0; i < ta && j < tbc; p++)
    sa[p] = sa_dc3_c12(wb[j]%3, s, wa[i], wb[j], wv)? wa[i++]:wb[j++];
  for( ; i < ta; p++) sa[p] = wa[i++];
  for( ; j < tbc; p++) sa[p] = wb[j++];
}
#endif
void sa_ch(int *s, int n, int *sa, int *h)
{
  static int r[maxn];
  for (int i = 1; i < n; i++) r[sa[i]] = i;
  for (int i = 0, j, k = 0; i < n-1; h[r[i++]] = k)
    for (k? k--: 0, j = sa[r[i]-1]; s[i+k] == s[j+k]; k++);
}
void icats(int *b, int *l, char *s)
{
  static int delim = 'z'+1;
  for (*l += strlen(s)+1; *s; s++) *b++ = *s;
  *b++ = delim++;
}
struct mono_stack {
  int *s, *t;
  void init(int *_s)
  { 
    t = &(*(s = _s) = 0x7fffffff);
  }
  void push(int x)
  {
    for ( ; *t <= x; t--);
    *++t = x;
  }
  int top()
  {
    return *t;
  }
};
void rmq_init(int (*s)[N], int l, int *k)
{
  for (int i = 0; i < l; i++) s[0][i] = i;
  for (int i = 1; i < 20; i++)
    if ((1<<i) < l) for (int j = 0; j < l; j++)
      if (k[s[i-1][j]] < k[s[i-1][j+(1<<(i-1))]]) s[i][j] = s[i-1][j];
      else s[i][j] = s[i-1][j+(1<<(i-1))];
}
int rmq_ask(int (*s)[N], int l, int r, int *k)
{
  if (l > r) swap(l ,r);
  int i = r-l+1, o = 1, j = 0;
  for (int o = 1 ; o <= i; o <<= 1) j++;
  j--, r = r-(1<<j)+1;
  return k[s[j][l]] < k[s[j][r]]? s[j][l]: s[j][r];
}
#endif

//main
int main() {
	return 0;
}
