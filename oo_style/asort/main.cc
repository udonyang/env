#include <cstdio>

struct asort_t {
  bool cmpl(pt_t lhs, pt_t rhs) {
    return fc.l(lhs.y, rhs.y) || (fc.e(lhs.y, rhs.y) && fc.l(lhs.x, rhs.x));
  }
  static pt_t o;
  static bool cmp(pt_t lhs, pt_t rhs) {
    double c = (lhs-o)%(rhs-o);
    if (!fc.e(c, 0.0)) return fc.g(c, 0.0);
    return fc.g((lhs-o)[1], (rhs-o)[1]);
  }
  void operator () (vector<pt_t> &p) {
    int mn = 0;
    for (int i = 0; i < p.size(); i++)
      if (cmpl(p[i], p[mn])) mn = i;
    swap(p[0], p[mn]);
    o = p[0];
    sort(p.begin()+1, p.end(), cmp);
  }
} asort;
pt_t asort_t::o;

//main
int main() {
	return 0;
}
