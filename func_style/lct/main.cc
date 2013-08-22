#include <cstdio>
#include <iostream>
using namespace std;
const int N = 1e4+10;

namespace lct {
  struct node {
    node *s[2], *p;
    int sz, rev, w, mx, at;
    node *sets(int b, node *x) {
      if (s[b] = x) x->p = this;
      return this;
    }
    bool root() {
      return !p || !(p->s[0] == this || p->s[1] == this);
    }
    bool which() {
      return p->s[1] == this;
    }
    node *set() {
      swap(s[0], s[1]);
      rev ^= 1;
      return this;
    }
    node *cover(int d) {
      w += d;
      mx += d;
      at += d;
      return this;
    }
    node *push() {
      if (at) {
        for (int i = 0; i < 2; i++)
          if (s[i]) s[i]->cover(at);
        at = 0;
      }
      if (rev) {
        for (int i = 0; i < 2; i++)
          if (s[i]) s[i]->set();
        rev = 0;
      }
      return this;
    }
    node *update() {
      sz = 1;
      mx = w;
      for (int i = 0; i < 2; i++)
        if (s[i]) {
          sz += s[i]->sz;
          mx = max(mx, s[i]->mx);
        }
      return this;
    }
    node *rotate() {
      node *y = p->push();
      int b = push()->which();
      y->sets(b, s[!b])->update();
      if (y->root()) p = y->p;
      else y->p->sets(y->which(), this);
      return sets(!b, y);
    }
    node *splay() {
      for ( ; !root(); ) 
        if (p->root()) rotate();
        else {
          if (which() == p->which()) p->rotate();
          else rotate();
          rotate();
        }
      return update();
    }
    node *end(int b) {
      node *x = this;
      for ( ; x->push()->s[b]; x = x->s[b]) ;
      return x;
    }
  } lct[N], *top;
  void init() {
    top = lct;
  }
  node *make(int w) {
    *top = (node){{0, 0}, 0, 1, 0, w, w};
    return top++;
  }
  node *access(node *x, int o = 0, int d = 0) {
    static node rv;
    for (node *y = x, *z = 0; y; z = y, y = y->p) {
      y->splay()->push();
      if (!y->p) {
        if (o == 1) {
          y->w += d;
          if (y->s[1]) y->s[1]->cover(d);
          if (z) z->cover(d);
        } else if (o == 2) {
          int mx = y->w;
          if (y->s[1]) mx = max(mx, y->s[1]->mx);
          if (z) mx = max(mx, z->mx);
          rv.mx = mx;
          return &rv;
        }
      }
      y->sets(1, z)->update();
    }
    return x->splay();
  }
  node *join(node *x, node *y) {
    return x->p = y;
  }
  node *cut(node *x) {
    if (access(x)->s[0]) x->s[0]->p = 0;
    x->s[0] = 0;
    return x;
  }
  node *find(node *x) {
    return access(x)->end(0);
  }
  node *rooting(node *x) {
    return access(x)->set();
  }
  node *cover(node *x, node *y, int w) {
    access(x);
    access(y, 1, w);
    return x;
  }
  int ask(node *x, node *y) {
    access(x);
    return access(y, 2)->mx;
  }
}
using namespace lct;

//main
int main() {
	return 0;
}
