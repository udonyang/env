#include <cstdio>

template<class T, int n, int m> struct aca_t {
  struct node {
    node *s[m], *p;
    int ac;
  } s[n], *top, *rt, *q[n];
  void init() {
    memset(top = s, 0, sizeof(s));
    rt = top++;
  }
  void put(T *k, int l, int ac) {
    node *x = rt;
    for (int i = 0; i < l; i++) {
      if (!x->s[k[i]]) x->s[k[i]] = top++;
      x = x->s[k[i]];
    }
    x->ac = ac;
  }
  void link() {
    int l = 0;
    for (int i = 0; i < m; i++)
      if (rt->s[i]) (q[l++] = rt->s[i])->p = rt;
      else rt->s[i] = rt;
    for (int h = 0; h < l; h++)
      for (int i = 0; i < m; i++)
        if (q[h]->s[i]) {
          (q[l++] = q[h]->s[i])->p = q[h]->p->s[i];
          q[h]->s[i]->ac |= q[h]->s[i]->p->ac;
        } else q[h]->s[i] = q[h]->p->s[i];
  }
  void tom(int mt[][n]) {
    for (node *x = s; x < top; x++)
      for (int i = 0; i < m; i++)
        if (!x->s[i]->ac) mt[x-s][x->s[i]-s] = 1;
  }
};

//main
int main() {
	return 0;
}
