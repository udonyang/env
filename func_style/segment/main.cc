#include <cstdio>

struct segment_node {
  segment_node *ls, *rs;
  int l, r;
  void set()
  {
  }
  void push()
  {
  }
  void update()
  {
  }
  int len()
  {
  }
  int mid()
  {
    return l + r >> 1;
  }
  static const int pool_size = 1e6+10;
  static segment_node pool[pool_size], *pool_top;
  static void init()
  {
    pool_top = pool;
  }
  static segment_node *make()
  {
    return pool_top++;
  }
} segment_node::pool[], *segment_node::pool_top;
struct segment {
  segment_node *rt;
  void init(int l, int r)
  {
    build(rt = segment_node::make(), l, r);
  }
  void build(segment_node *x, int l, int r)
  {
    *x = (segment_node){0, 0, l, r};
    if (l < r) {
      int m = l + r >> 1;
      build(x->ls = segment_node::make(), l, m);
      build(x->rs = segment_node::make(), m + 1, r);
    }
  }
  void cover(segment_node *x, int l, int r)
  {
    if (l <= x->l && x->r <= r) {
      x->set();
    } else {
      int m = x->mid();
      x->push();
      if (l <= m) {
        cover(x->ls, l, r);
      }
      if (m < r) {
        cover(x->rs, l, r);
      }
      x->update();
    }
  }
};

//main
int main() {
	return 0;
}
