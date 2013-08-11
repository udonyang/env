#include <cstdio>

struct splay_node {
  splay_node *p, *s[2];
  int key, size, count;
  static void init()
  {
    pool_top = pool;
  }
  static splay_node *make(int key = 0, splay_node *p = 0)
  {
    *pool_top = (splay_node){ p, 0, 0, key, 1, 1};
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
    size = 1;
    for (int i = 0; i < 2; i++) {
      if (s[i]) {
        size += s[i]->size;
      }
    }
    return this;
  }
  static const int pool_size = 1e7+10;
  static splay_node pool[pool_size], *pool_top;
} *splay_node::pool_top, splay_node::pool[];
struct splay {
  splay_node *rt;
  splay(splay_node *_rt = 0)
  {
    rt = _rt;
  }
  splay_node *roate(splay_node *x, bool lr = 0)
  {
    splay_node *y = x->push()->s[!lr]->push();
    x->s[!lr] = y->s[lr];
    if (y->s[lr]) y->s[lr]->p = x;
    y->p = x->p;
    if (!x->p) rt = y;
    else x->p->s[x->p->s[0] != x] = y;
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
      if (lrp ^ lrg) roate(x->p, lrg);
      else roate(x->p->p, !lrg);
      roate(x->p, !lrg);
    }
    return x->update();
  }
  splay_node *max_node(splay_node *x, bool lr = 1)
  {
    for ( ; x->push()->s[lr] ; x = x->s[lr]);
    return x;
  }
  splay_node *next_node(splay_node *x, bool ps = 1)
  {
    if (fine(x->push())->s[ps]) {
      return max_node(x->s[ps], !ps);
    }
    return x;
  }
  splay_node *pick(splay_node *x, int i = 1)
  {
#define lsize (1 + (x->s[0]? x->s[0]->size: 0))
    for (int j = lsize; x && j != i; j = lsize) {
      x = x->push()->s[j < i]->push();
      i -= j * (j < i);
    }
    return x? fine(x): 0;
#undef lsize
  }
  splay_node *push_or_get(int key, bool pg = 0)
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
  splay_node *split(splay_node *x)
  {
    if (!x->p) {
      rt = 0;
    } else {
      x->p->s[x->p->s[0] != x] = 0;
      x->p->update();
      x->p = 0;
    }
    return x;
  }
  splay_node *remove(splay_node *x)
  {
    if (!--x->count) {
      if (fine(x->push())->s[1]) {
        splay_node *y = fine(max_node(x->s[1], 0));
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
  void travel(splay_node *x, bool rip = 1)
  {
    struct stack_node {
      splay_node *x;
      int i;
    } static stack[splay_node::pool_size] = {{0, 0}};
    stack_node *top = stack + 1;
    *top = (stack_node){x, 0};
    for ( ; top->x; ) {
      for (int &i = top->i ; i < 2; i++) {
        if (rip == i) {
          printf("%d ", top->x->key);
        }
        if (top->x->s[i]) {
          *(top + 1) = (stack_node){top->x->s[top->i++], 0};
          top++;
          break;
        }
      }
      if (top->i == 2) {
        if (rip == 2) {
          printf("%d ", top->x->key);
        }
        top--;
      }
    }
    puts("");
  }
};
struct splay_segment: splay {
  splay_node *ll, *rr;
  splay_segment(int *s, int l, int r)
  {
    rt = ll = splay_node::make(-1);
    rt->s[1] = rr = splay_node::make(-2, rt);
    fine(rr->s[0] = build(rr, s, l, r));
  }
  splay_node *build(splay_node *x, int *s, int l, int r)
  {
    int m = l + r >> 1;
    splay_node *y = splay_node::make(s[m], x);
    if (l < m) y->s[0] = build(y, s, l, m - 1);
    if (m < r) y->s[1] = build(y, s, m + 1, r);
    return y->update();
  }
  splay_node *insert(splay_node *x, int key, bool lr = 0)
  {
    if (x->push()->s[lr]) {
      splay_node *y = max_node(x->s[lr], !lr);
      x = y->s[!lr] = splay_node::make(key, y);
    } else {
      x = x->s[lr] = splay_node::make(key, x);
    }
    return fine(x);
  }
  splay_node *get_segment(int l, int r)
  {
    splay_node *r_node = pick(rt, r + 3),
               *l_node = pick(rt, l + 1);
    fine(r_node, l_node);
    return r_node->s[0];
  }
  splay_node *remove_segment(int l, int r)
  {
    return split(get_segment(l, r));
  }
};

int s[] = {129,  19290, 12, 1, 222, 189, 1100}, ls = sizeof(s)/sizeof(s[0]);

void splay_test()
{
  splay zkl;
  for (int i = 0; i < ls; i++) {
    zkl.push_or_get(s[i], 1);
  }
  zkl.travel(zkl.rt);
  puts("");
  for (int i = 0; i < ls; i++) {
    splay_node *x = zkl.pick(zkl.rt, i + 1);
    printf("%dth = %d\n", i + 1, x->key);
  }
  for (int i = 0; i < ls; i++) {
#if 0
    printf("after remove %dth\n", (int)(zkl.rt->size/2.0+0.5));
    zkl.remove(zkl.pick(zkl.rt, zkl.rt->size/2.0+0.5));
#else
    printf("after remove %d\n", s[i]);
    zkl.remove(zkl.push_or_get(s[i]));
#endif
    zkl.travel(zkl.rt);
  }
  puts("");
}

void splay_segment_test()
{
  splay_segment zkl(s, 0, ls - 1);

  zkl.travel(zkl.get_segment(0, ls - 1));
  puts("remove");
  zkl.travel(zkl.remove_segment(4, 5));
  puts("and");
  zkl.travel(zkl.remove_segment(1, 2));
  puts("become");
  zkl.travel(zkl.get_segment(0, ls - 5));
  zkl.travel(zkl.remove_segment(0, ls - 5));
  zkl.travel(zkl.rt);
}

int main()
{
  splay_node::init();
//   splay_test();
  splay_segment_test();
  
  return 0;
}
