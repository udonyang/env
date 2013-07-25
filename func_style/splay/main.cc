#include "stdio.h"
struct splay_node {
  splay_node *p, *s[2];
  int key, size, count;
  static void init()
  {
    pool_top = pool;
  }
  static splay_node *make(int key, splay_node *p = 0)
  {
    splay_node x = { p, 0, 0, key, 1, 1};
    *pool_top = x;
    return pool_top++;
  }
  splay_node *set()
  {
    return this;
  }
  splay_node *push()
  {
    return this;
  }
  splay_node *update()
  {
    return this;
  }
  static const int pool_size = 1e5+10;
  static splay_node pool[pool_size], *pool_top;
} *splay_node::pool_top, splay_node::pool[];
struct splay {
  splay_node *rt;
  splay()
  {
    rt = 0;
  }
  splay_node *roate(splay_node *x, bool lr = 0)
  {
    splay_node *y = x->push()->s[!lr]->push();
    x->s[!lr] = y->s[lr];
    if (y->s[lr]) {
      y->s[lr]->p = x;
    }
    y->p = x->p;
    if (!x->p) {
      rt = y;
    } else {
      x->p->s[x->p->s[0] != x] = y;
    }
    x->p = y;
    y->s[lr] = x;
    return x->update();
  }
  splay_node *fine(splay_node *x, splay_node *p = 0)
  {
    for ( ; x->p != p; ) {
      bool lrp =  x->p->s[0] != x;
      if (x->p->p == p) {
        roate(x->p, !lrp);
        break;
      }
      bool lrg = x->p->p->s[0] != x->p;
      if (lrp != lrg) {
        roate(x->p, lrg);
      } else {
        roate(x->p->p, lrg);
      }
      roate(x->p, !lrg);
    }
    return x->update();
  }
  splay_node *pick(splay_node *x, int i)
  {
#define lsize (1 + (x->s[0]? x->s[0]->size: 0))
    for (int j = lsize; j != i; j = lsize) {
      x = x->push()->s[j < i]->push();
      i -= lsize * (j < i);
    }
    return fine(x);
#undef lsize
  }
  splay_node *push_or_get(int key, bool pg)
  {
    if (!rt) {
      if (pg) {
        rt = splay_node::make(key);
      }
      return rt;
    }
    splay_node *y = 0, *x = rt;
    for ( ; x && x->push()->key != key; ) {
      y = x;
      x = x->s[x->key < key];
    }
    if (pg) {
      if (!x) {
        y->s[y->key < key] = x = splay_node::make(key, y);
      } else {
        x->count++;
      }
    }
    return x? fine(x): 0;
  }
  splay_node *remove(splay_node *x)
  {
    if (!--x->count) {
      if (fine(x->push())->s[1]) {
        splay_node *y = fine(pick(rt, 1));
        y->s[0] = x->s[0];
        if (x->s[0]) {
          x->s[0]->p = y;
        }
        x->p = 0;
      } else {
        rt = x->s[0];
        if (rt) {
          rt->p = 0;
        }
        x->s[0] = 0;
      }
    }
    return rt? rt->update(): 0;
  }
};

int main()
{
  return 0;
}
