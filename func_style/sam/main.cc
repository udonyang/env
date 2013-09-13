#include <cstdio>

template<int N, int M> struct sam_t {
  static const int n = N*3;
  struct node {
    node *s[M], *p;
    int l;
    int range() {
      return l-(p? l-p->l: 0);
    }
  } s[n], *top, *back;
  node *make(int l) {
    memset(top, 0, sizeof(node));
    top->l = l;
    return top++;
  }
  void init() {
    top = s;
    back = make(0);
  }
  void put(int k) {
    node *x = make(back->l+1), *y = back;
    for ( ; y && !y->s[k]; y = y->p) y->s[k] = x;
    if (!y) x->p = s;
    else {
      node *w = y->s[k];
      if (w->l == y->l+1) x->p = w;
      else {
        node *z = make(0);
        *z = *w;
        z->l = y->l+1;
        x->p = w->p = z;
        for ( ; y && y->s[k] == w; y = y->p) y->s[k] = z;
      }
    }
  }
};

//main
int main() {
	return 0;
}
