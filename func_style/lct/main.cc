#include <cstdio>
#include <iostream>
using namespace std;

namespace lct {
  const int N = 1e4+10;
  struct node {
    node *c[2], *p;
    int pt;
    node *update()
    {
      return this;
    }
    node *rotate()
    {
      node *y = p;
      p = y->p;
      if (y->pt != 2) p->c[y->pt] = this;
      if (y->c[pt] = c[!pt]) c[!(c[!pt]->pt = pt)]->p = y;
      (y->p = this)->c[!pt] = y->update();
      swap(pt, y->pt);
      y->pt ^= 1;
      return this;
    }
    node *splay()
    {
      for ( ; pt != 2; ) {
        (pt == p->pt? p: this)->rotate();
        if (pt != 2) rotate();
      }
      return update();
    }
    node *end(int b)
    {
      node *x = this;
      for ( ; x->c[b]; x = x->c[b]) ;
      return x;
    }
  } pool[N], *top;
  node *init()
  {
    return top = pool;
  }
  node *make_tree()
  {
    return &(*top++ = (node){0, 0, 0, 2});
  }
  node *access(node *x)
  {
    for (node *y = x, *z = 0; y; ) {
      y->splay();
      if (y->c[1]) y->c[1]->pt = 2;
      if (z) z->pt = 1;
      y->c[1] = z;
      z = y;
      y = y->update()->p;
    }
    return x;
  }
  node *find_root(node *x)
  {
    return access(x)->splay()->end(0)->splay();
  }
  node *cut(node *x)
  {
    access(x);
    if (x->c[0]) {
      x->c[0]->pt = 2;
      x->c[0] = 0;
    }
    return x;
  }
  node *join(node *x, node *y)
  {
    access(x)->p = y;
    return access(x);
  }
}

//main
int main() {
	return 0;
}
