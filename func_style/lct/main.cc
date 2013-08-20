#include <cstdio>
#include <iostream>
using namespace std;
const int N = 1e4+10;

struct lct_t {
  lct_t *s[2], *p;
  int rev;
  lct_t *sets(int b, lct_t *x) {
    if (s[b] = x) x->p = this;
    return this;
  }
  bool root() {
    return !p || !(p->s[0] == this || p->s[1] == this);
  }
  bool which() {
    return p->s[1] == this;
  }
  lct_t *set() {
    swap(s[0], s[1]);
    rev ^= 1;
    return this;
  }
  lct_t *push() {
    if (rev) {
      for (int i = 0; i < 2; i++)
        if (s[i]) s[i]->set();
      rev = 0;
    }
    return this;
  }
  lct_t *rotate() {
    lct_t *y = p->push();
    int b = push()->which();
    y->sets(b, s[!b]);
    if (y->root()) p = y->p;
    else y->p->sets(y->which(), this);
    return sets(!b, y);
  }
  lct_t *splay() {
    for ( ; !root(); ) 
      if (p->root()) rotate();
      else {
        if (which() == p->which()) p->rotate();
        else rotate();
        rotate();
      }
    return this;
  }
  lct_t *end(int b) {
    lct_t *x = this;
    for ( ; x->push()->s[b]; x = x->s[b]) ;
    return x;
  }
} lct[N], *top;
void init() {
  top = lct;
}
lct_t *make() {
  *top = (lct_t){0};
  return top++;
}
lct_t *access(lct_t *x) {
  for (lct_t *y = x, *z = 0; y; z = y, y = y->p)
    y->splay()->push()->sets(1, z);
  return x->splay();
}
lct_t *join(lct_t *x, lct_t *y) {
  return x->p = y;
}
lct_t *cut(lct_t *x) {
  if (access(x)->s[0]) x->s[0]->p = 0;
  x->s[0] = 0;
  return x;
}
lct_t *find(lct_t *x) {
  return access(x)->end(0);
}
lct_t *rooting(lct_t *x) {
  return access(x)->set();
}

//main
int main() {
	return 0;
}
