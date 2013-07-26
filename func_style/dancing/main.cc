#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <iostream>
using namespace std;

#if 1
struct dancing {
#define dfor(c, a, b) for (int c = a[b]; c != b; c = a[c])
  static const int row_size = 100, column_size = 100,
               total_size = row_size * column_size;
  typedef int row[row_size],
          column[column_size],
          total[total_size];
  total l, r, u, d, in_column;
  column s;
  int index, current_row, row_head;
  void init(int n)
  {
    index = ++n;
    for (int i = 0; i < n; i++) {
      l[i] = (i - 1 + n) % n;
      r[i] = (i + 1) % n;
      u[i] = d[i] = i;
    }
    current_row = 0;
    memset(s, 0, sizeof(s));
  }
  void push(int i, int j)
  {
    i++; j++;
    if (current_row < i) {
      row_head = l[index] = r[index] = index;
      current_row = i;
    }
    l[index] = l[row_head]; r[index] = row_head;
    r[l[row_head]] = index; l[row_head] = index;
    u[index] = u[j]; d[index] = j;
    d[u[j]] = index; u[j] = index;
    s[j]++;
    in_column[index++] = j;
  }
  void exactly_remove(int c)
  {
    l[r[c]] = l[c];
    r[l[c]] = r[c];
    dfor(i, d, c) {
      dfor (j, r, i) {
        u[d[j]] = u[j];
        d[u[j]] = d[j];
        s[in_column[j]]--;
      }
    }
  }
  void exactly_resume(int c)
  {
    dfor(i, u, c) {
      dfor(j, l, i) {
        s[in_column[j]]++;
        d[u[j]] = u[d[j]] = j;
      }
    }
    r[l[c]] = l[r[c]] = c;
  }
  bool exactly_dance(int step = 0)
  {
    if (!r[0]) {
      return 1;
    }
    int x = r[0];
    dfor(i, r, 0) {
      if (s[i] < s[x]) {
        x = i;
      }
    }
    exactly_remove(x);
    dfor(i, d, x) {
      dfor(j, r, i) {
        exactly_remove(in_column[j]);
      }
      if (exactly_dance(step + 1)) {
        return 1;
      }
      dfor(j, l, i) {
        exactly_resume(in_column[j]);
      }
    }
    exactly_resume(x);
    return 0;
  }
  int limit;
  void remove(int c)
  {
    dfor(i, d, c) {
      l[r[i]] = l[i];
      r[l[i]] = r[i];
    }
  }
  void resume(int c)
  {
    dfor(i, u, c) {
      r[l[i]] = l[r[i]] = i;
    }
  }
  bool dance(int step = 0)
  {
    if (limit <= step + heuristic()) {
      return 0;
    }
    if (!r[0]) {
      limit = min(limit, step);
      return 1;
    }
    int x = r[0];
    dfor(i, r, 0) {
      if (s[i] < s[x]) {
        x = i;
      }
    }
    dfor(i, d, x) {
      remove(i);
      dfor(j, r, i) {
        remove(j);
      }
      if (dance(step + 1)) {
        return 1;
      }
      dfor(j, l, i) {
        resume(j);
      }
      resume(i);
    }
    return 0;
  }
  int heuristic()
  {
    int rv = 0;
    column visit = {0};
    dfor(c, r, 0) {
      if (!visit[c]) {
        rv++;
        visit[c] = 1;
        dfor(i, d, c) {
          dfor(j, r, i) {
            visit[in_column[j]] = 1;
          }
        }
      }
    }
    return rv;
  }
  int dfs()
  {
    for (limit = heuristic(); !dance(); limit++) {}
    return limit;
  }
#undef dfor
};
#endif

// exact
#if 0
#if 1 //Header
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <cstring>
#include <string>
#include <vector>
#include <map>
#include <algorithm>
#include <cctype>
#include <queue>
#include <stack>
#include <cmath>
using namespace std;
#endif
#if 1 //Macro
//STL-Alias
#define UN(c, a) unique(c, a)
#define MS(c, a) memset(c, a, sizeof c)
#define FLC(c, a ,b) fill(c, c + a, b)
#define LOS(c, a, b) lower_bound(c, a, b)
#define UPS(c, a, b) upper_bound(c, a, b)
//Syntax-Alias
#define Rep(c, a, b) for (int c = (a); c < (b); c++)
#define Nre(c, a, b) for (int c = (a); c > (b); c--)
//DEBUG
#define FK puts("Fu*k here!")
#define PA(s, c, a, b, p, f){\
	printf(s);\
	Rep(c, a, b) printf(p, (f));\
	puts("");}
//Constant
#define INFI (0x7fffffff)
#define MOD ()
#define MAXN (10)
//Type-Alias
typedef long long LL;
typedef long double LD;
typedef int AI[MAXN];
typedef bool AB[MAXN];
typedef double AD[MAXN];
typedef LL ALL[MAXN];
typedef LD ALD[MAXN];
#endif

struct dancing {
#define dfor(c, a, b) for (int c = a[b]; c != b; c = a[c])
  static const int row_size = 729+10, column_size = 324+10,
               total_size = row_size * column_size;
  typedef int row[row_size],
          column[column_size],
          total[total_size];
  total l, r, u, d, in_column, in_row;
  row use;
  column s;
  int index, current_row, row_head;
  void init(int n)
  {
    index = ++n;
    for (int i = 0; i < n; i++) {
      l[i] = (i - 1 + n) % n;
      r[i] = (i + 1) % n;
      u[i] = d[i] = i;
    }
    current_row = 0;
    memset(s, 0, sizeof(s));
    memset(use, 0, sizeof(use));
  }
  void push(int i, int j)
  {
    i++; j++;
    if (current_row < i) {
      row_head = l[index] = r[index] = index;
      current_row = i;
    }
    l[index] = l[row_head]; r[index] = row_head;
    r[l[row_head]] = index; l[row_head] = index;
    u[index] = u[j]; d[index] = j;
    d[u[j]] = index; u[j] = index;
    s[j]++;
    in_row[index] = i;
    in_column[index++] = j;
  }
  void exactly_remove(int c)
  {
    l[r[c]] = l[c];
    r[l[c]] = r[c];
    dfor(i, d, c) {
      dfor (j, r, i) {
        u[d[j]] = u[j];
        d[u[j]] = d[j];
        s[in_column[j]]--;
      }
    }
  }
  void exactly_resume(int c)
  {
    dfor(i, u, c) {
      dfor(j, l, i) {
        s[in_column[j]]++;
        d[u[j]] = u[d[j]] = j;
      }
    }
    r[l[c]] = l[r[c]] = c;
  }
  bool exactly_dance(int step = 0)
  {
    if (!r[0]) {
      return 1;
    }
    int x = r[0];
    dfor(i, r, 0) {
      if (s[i] < s[x]) {
        x = i;
      }
    }
    exactly_remove(x);
    dfor(i, d, x) {
      use[in_row[i]] = 1;
      dfor(j, r, i) {
        exactly_remove(in_column[j]);
      }
      if (exactly_dance(step + 1)) {
        return 1;
      }
      dfor(j, l, i) {
        exactly_resume(in_column[j]);
      }
      use[in_row[i]] = 0;
    }
    exactly_resume(x);
    return 0;
  }
#undef dfor
};
dancing dlx;

char B[MAXN * MAXN];

int main()
{
#if 1
	freopen("input.in", "r", stdin);
#endif
	while (scanf("%s", B), strcmp(B, "end"))
	{
		//Initialize
		dlx.init(324);
		Rep(p, 0, 81)
		{
			int h = 0, o = B[p] - '0',
				r = p / 9, c = p % 9;
			if (B[p] == '.') o = 9;
			else h = o - 1;
			Rep(i, h, o)
			{
				int u = p * 9 + i;
				dlx.push(u, r * 9 + i);
				dlx.push(u, c * 9 + i + 81);
				dlx.push(u, ((r / 3) * 3 + (c / 3)) * 9 + i + 162);
				dlx.push(u, p + 243);
			}
		}
		//Solve
		dlx.exactly_dance();
		Rep(i, 0, 729) if (dlx.use[i + 1])
			printf("%d", i % 9 + 1);
		puts("");
	}
	return 0;
}

#endif

// duplicate
#if 0
#include <cmath>
//STL-Alias
#define UN(c, a) unique(c, a)
#define MS(c, a) memset(c, a, sizeof c)
#define FLC(c, a ,b) fill(c, c + a, b)
#define LOS(c, a, b) lower_bound(c, a, b)
#define UPS(c, a, b) upper_bound(c, a, b)
//Syntax-Alias
#define Rep(c, a, b) for (int c = (a); c < (b); c++)
#define Nre(c, a, b) for (int c = (a); c > (b); c--)
//DEBUG
#define FK puts("Fu*k here!")
#define PA(s, c, a, b, p, f){\
	printf(s);\
	Rep(c, a, b) printf(p, (f));\
	puts("");}
//Constant
#define EPS (1e-7)
#define MAXN (55)
#define INFI (0x7fffffff)
//Type-Alias
typedef long long LL;
typedef long double LD;
typedef int AI[MAXN];
typedef bool AB[MAXN];
typedef double AD[MAXN];
typedef LL ALL[MAXN];
typedef LD ALD[MAXN];

struct dancing {
#define dfor(c, a, b) for (int c = a[b]; c != b; c = a[c])
  static const int row_size = 100, column_size = 100,
               total_size = row_size * column_size;
  typedef int row[row_size],
          column[column_size],
          total[total_size];
  total l, r, u, d, in_column;
  column s;
  int index, current_row, row_head;
  void init(int n)
  {
    index = ++n;
    for (int i = 0; i < n; i++) {
      l[i] = (i - 1 + n) % n;
      r[i] = (i + 1) % n;
      u[i] = d[i] = i;
    }
    current_row = 0;
    memset(s, 0, sizeof(s));
  }
  void push(int i, int j)
  {
    i++; j++;
    if (current_row < i) {
      row_head = l[index] = r[index] = index;
      current_row = i;
    }
    l[index] = l[row_head]; r[index] = row_head;
    r[l[row_head]] = index; l[row_head] = index;
    u[index] = u[j]; d[index] = j;
    d[u[j]] = index; u[j] = index;
    s[j]++;
    in_column[index++] = j;
  }
  void exactly_remove(int c)
  {
    l[r[c]] = l[c];
    r[l[c]] = r[c];
    dfor(i, d, c) {
      dfor (j, r, i) {
        u[d[j]] = u[j];
        d[u[j]] = d[j];
        s[in_column[j]]--;
      }
    }
  }
  void exactly_resume(int c)
  {
    dfor(i, u, c) {
      dfor(j, l, i) {
        s[in_column[j]]++;
        d[u[j]] = u[d[j]] = j;
      }
    }
    r[l[c]] = l[r[c]] = c;
  }
  bool exactly_dance(int step = 0)
  {
    if (!r[0]) {
      return 1;
    }
    int x = r[0];
    dfor(i, r, 0) {
      if (s[i] < s[x]) {
        x = i;
      }
    }
    exactly_remove(x);
    dfor(i, d, x) {
      dfor(j, r, i) {
        exactly_remove(j);
      }
      if (exactly_dance(step + 1)) {
        return 1;
      }
      dfor(j, l, i) {
        exactly_resume(j);
      }
    }
    exactly_resume(x);
    return 1;
  }
  int limit;
  void remove(int c)
  {
    dfor(i, d, c) {
      l[r[i]] = l[i];
      r[l[i]] = r[i];
    }
  }
  void resume(int c)
  {
    dfor(i, u, c) {
      r[l[i]] = l[r[i]] = i;
    }
  }
  bool dance(int step = 0)
  {
    if (limit <= step + heuristic()) {
      return 0;
    }
    if (!r[0]) {
      limit = min(limit, step);
      return 1;
    }
    int x = r[0];
    dfor(i, r, 0) {
      if (s[i] < s[x]) {
        x = i;
      }
    }
    dfor(i, d, x) {
      remove(i);
      dfor(j, r, i) {
        remove(j);
      }
      if (dance(step + 1)) {
        return 1;
      }
      dfor(j, l, i) {
        resume(j);
      }
      resume(i);
    }
    return 0;
  }
  int heuristic()
  {
    int rv = 0;
    column visit = {0};
    dfor(c, r, 0) {
      if (!visit[c]) {
        rv++;
        visit[c] = 1;
        dfor(i, d, c) {
          dfor(j, r, i) {
            visit[in_column[j]] = 1;
          }
        }
      }
    }
    return rv;
  }
  int dfs()
  {
    for (limit = heuristic(); !dance(); limit++) {}
    return limit;
  }
#undef dfor
};
dancing dlx;

struct Vec
{
	double x, y;
	Vec(double _x = 0.0, double _y = 0.0): x(_x), y(_y) {} 
	void inp()
	{
		scanf("%lf%lf", &x, &y);
	}
	friend Vec operator - (Vec p, Vec q)
	{
		return Vec(p.x - q.x, p.y - q.y);
	}
	double mod()
	{
		return sqrt(x * x + y * y);
	}
} _vec, C[MAXN], R[MAXN];

int N, M, K;

int chk(double m)
{
	int ct = N;
	AB H = {0};
	dlx.init(N);
	Rep(i, 0, M) Rep(j, 0, N)
		if ((R[i] - C[j]).mod() - m <= EPS)
		{
			if (!H[j])
			{
				H[j] = 1;
				ct--;
			}
			dlx.push(i, j);
		}
	if (ct) return INFI;
	return dlx.dfs(); 
}

int main()
{
#if 1
	freopen("input.in", "r", stdin);
#endif
	int T, Cas = 1;
	scanf("%d", &T);
	while (T--)
	{
		//Initialize
		scanf("%d%d%d", &N, &M, &K);
		Rep(i, 0, N) C[i].inp();
		Rep(i, 0, M) R[i].inp();
		double l = 0, r = 2000.0, res = -1;
		//Solve
		while (l  - r <= EPS)
		{
			double m = (l + r) / 2.0;
			if (chk(m) <= K)
			{
				res = m;
				r = m - EPS;
			}
			else l = m + EPS;
		}
		printf("%.6lf\n", res);
	}
	return 0;
}
#endif
