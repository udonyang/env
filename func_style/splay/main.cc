#include <cstdio>

namespace splay {
  struct node {
    node *p, *s[2];
    int key, size, count;
    static void init()
    {
      pool_top = pool;
    }
    static node *make(int key = 0, node *p = 0)
    {
      *pool_top = (node){ p, 0, 0, key, 1, 1};
      return pool_top++;
    }
    node *set()
    {
      return this;
    }
    node *push()
    {
      return this;
    }
    node *update()
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
    static node pool[pool_size], *pool_top;
  } *node::pool_top, node::pool[];
  struct splay_t {
    node *rt;
    splay_t(node *_rt = 0) {
      rt = _rt;
    }
    node *roate(node *x, bool lr = 0) {
      node *y = x->push()->s[!lr]->push();
      x->s[!lr] = y->s[lr];
      if (y->s[lr]) y->s[lr]->p = x;
      y->p = x->p;
      if (!x->p) rt = y;
      else x->p->s[x->p->s[0] != x] = y;
      x->p = y;
      y->s[lr] = x;
      return x->update();
    }
    node *fine(node *x, node *p = 0) {
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
    node *max_node(node *x, bool lr = 1) {
      for ( ; x->push()->s[lr] ; x = x->s[lr]);
      return x;
    }
    node *next_node(node *x, bool ps = 1) {
      if (fine(x->push())->s[ps]) {
        return max_node(x->s[ps], !ps);
      }
      return x;
    }
    node *pick(node *x, int i = 1) {
#define lsize (1 + (x->s[0]? x->s[0]->size: 0))
      for (int j = lsize; x && j != i; j = lsize) {
        x = x->push()->s[j < i]->push();
        i -= j * (j < i);
      }
      return x? fine(x): 0;
#undef lsize
    }
    node *push_or_get(int key, bool pg = 0) {
      if (!rt) {
        if (pg) {
          rt = node::make(key);
        }
        return rt;
      }
      node *y = 0, *x = rt;
      for ( ; x && x->push()->key != key; ) {
        y = x;
        x = x->s[x->key < key];
      }
      if (pg) {
        if (!x) {
          y->s[y->key < key] = x = node::make(key, y);
        } else {
          x->count++;
        }
      }
      return x? fine(x): 0;
    }
    node *split(node *x) {
      if (!x->p) {
        rt = 0;
      } else {
        x->p->s[x->p->s[0] != x] = 0;
        x->p->update();
        x->p = 0;
      }
      return x;
    }
    node *remove(node *x) {
      if (!--x->count) {
        if (fine(x->push())->s[1]) {
          node *y = fine(max_node(x->s[1], 0));
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
    void travel(node *x, bool rip = 1) {
      struct stack_node {
        node *x;
        int i;
      } static stack[node::pool_size] = {{0, 0}};
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
  struct seg_t: splay_t {
    node *ll, *rr;
    seg_t(int *s, int l, int r) {
      rt = ll = node::make(-1);
      rt->s[1] = rr = node::make(-2, rt);
      fine(rr->s[0] = build(rr, s, l, r));
    }
    node *build(node *x, int *s, int l, int r) {
      int m = l + r >> 1;
      node *y = node::make(s[m], x);
      if (l < m) y->s[0] = build(y, s, l, m - 1);
      if (m < r) y->s[1] = build(y, s, m + 1, r);
      return y->update();
    }
    node *insert(node *x, int key, bool lr = 0) {
      if (x->push()->s[lr]) {
        node *y = max_node(x->s[lr], !lr);
        x = y->s[!lr] = node::make(key, y);
      } else {
        x = x->s[lr] = node::make(key, x);
      }
      return fine(x);
    }
    node *get_seg_tment(int l, int r) {
      node *r_node = pick(rt, r + 3),
                 *l_node = pick(rt, l + 1);
      fine(r_node, l_node);
      return r_node->s[0];
    }
    node *remove_seg_tment(int l, int r) {
      return split(get_seg_tment(l, r));
    }
  };
}
using namespace splay;

int s[] = {129,  19290, 12, 1, 222, 189, 1100}, ls = sizeof(s)/sizeof(s[0]);

void splay_test()
{
  splay_t zkl;
  for (int i = 0; i < ls; i++) {
    zkl.push_or_get(s[i], 1);
  }
  zkl.travel(zkl.rt);
  puts("");
  for (int i = 0; i < ls; i++) {
    node *x = zkl.pick(zkl.rt, i + 1);
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

void seg_t_test()
{
  seg_t zkl(s, 0, ls - 1);

  zkl.travel(zkl.get_seg_tment(0, ls - 1));
  puts("remove");
  zkl.travel(zkl.remove_seg_tment(4, 5));
  puts("and");
  zkl.travel(zkl.remove_seg_tment(1, 2));
  puts("become");
  zkl.travel(zkl.get_seg_tment(0, ls - 5));
  zkl.travel(zkl.remove_seg_tment(0, ls - 5));
  zkl.travel(zkl.rt);
}

int main()
{
  node::init();
//   splay_test();
  seg_t_test();
  
  return 0;
}
