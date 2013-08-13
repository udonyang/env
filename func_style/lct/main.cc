#include <cstdio>
#include <iostream>
using namespace std;

namespace lct {
  const int N = 1e4;
  struct node {
    node *c[2], *p;
    int type()
    {
      if (!p || p->c[0] != this && p->c[1] != this) return 2;
      return p->c[0] != this;
    }
    node *update()
    {
      return this;
    }
    node *rotate()
    {
      node *y = p;
      int b = type(), pb = y->type();
      if (p = y->p, pb < 2) p->c[pb] = this;
      if (y->c[b] = c[!b]) c[!b]->p = y;
      return c[!b] = y, y->update()->p = this;
    }
    node *splay()
    {
      for ( ; type() < 2; type() < 2? rotate(): 0)
        type() == p->type()? p->rotate(): rotate();
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
    return &(*top++ = (node){0, 0, 0});
  }
  node *access(node *x)
  {
    for (node *y = x, *z = 0; y; z = y, y = y->update()->p)
      y->splay()->c[1] = z;
    return x;
  }
  node *find_root(node *x)
  {
    return access(x)->splay()->end(0)->splay();
  }
  node *cut(node *x)
  {
    access(x);
    x->c[0] = 0;
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
