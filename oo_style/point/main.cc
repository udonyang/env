#include <cstdio>

struct pt_t {
  double x, y;
  pt_t(double _x = 0, double _y = 0) {
    x = _x, y = _y;
  }
  double operator [] (int b) {
    return b? b < 2? abs(x)+abs(y): x*x+y*y: sqrt(x*x+y*y);
  }
  friend pt_t operator + (const pt_t &lhs, const pt_t &rhs) {
    return pt_t(lhs.x+rhs.x, lhs.y+rhs.y);
  }
  friend pt_t operator - (const pt_t &lhs, const pt_t &rhs) {
    return pt_t(lhs.x-rhs.x, lhs.y-rhs.y);
  }
  friend double operator * (const pt_t &lhs, const pt_t &rhs) {
    return lhs.x*rhs.x+lhs.y*rhs.y;
  }
  friend double operator % (const pt_t &lhs, const pt_t &rhs) {
    return lhs.x*rhs.y-lhs.y*rhs.x;
  }
  pt_t &input() {
    scanf("%lf%lf", &x, &y);
    return *this;
  }
};

//main
int main() {
	return 0;
}
