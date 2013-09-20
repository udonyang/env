#include <cstdio>

struct seg_t {
  seg_t *ls, *rs;
  int l, r;
  void set() {
  }
  void push() {
  }
  void update() {
  }
  int len() {
  }
  int mid() {
    return l + r >> 1;
  }
  static const int pool_size = 1e6+10;
  static seg_t pool[pool_size], *pool_top;
  static void init() {
    pool_top = pool;
  }
  static seg_t *make() {
    return pool_top++;
  }
} seg_t::pool[], *seg_t::pool_top;
struct seg {
  seg_t *rt;
  void init(int l, int r) {
    build(rt = seg_t::make(), l, r);
  }
  void build(seg_t *x, int l, int r) {
    *x = (seg_t){0, 0, l, r};
    if (l < r) {
      int m = l + r >> 1;
      build(x->ls = seg_t::make(), l, m);
      build(x->rs = seg_t::make(), m + 1, r);
    }
  }
  void cover(seg_t *x, int l, int r) {
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
