#include <cstdio>

struct fs_t {
  struct node {
    int l, r, sm;
    node *ls, *rs;
    int m() {
      return l+r>>1;
    }
  } s[N*20], *top;
  void init() {
    top = s;
  }
  node *phi(int l, int r) {
    node *x = top++, t = {l, r, 0};
    *x = t;
    if (l < r) {
      x->ls = phi(l, x->m());
      x->rs = phi(x->m()+1, r);
    }
    return x;
  }
  node *put(int k, node *y) {
    node *x = top++;
    *x = *y;
    x->sm++;
    if (x->l < y->r) {
      if (k <= x->m()) x->ls = put(k, y->ls);
      else x->rs = put(k, y->rs);
    }
    return x;
  }
  int ask(int l, int r, node *x, node *y) {
    int rv = 0;
    if (l <= x->l && x->r <= r) rv = x->sm-y->sm;
    else {
      if (l <= x->m()) rv += ask(l, r, x->ls, y->ls);
      if (x->m() < r) rv += ask(l, r, x->rs, y->rs);
    }
    return rv;
  }
} fs;

//main
int main() {
	return 0;
}
