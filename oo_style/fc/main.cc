#include <cstdio>

struct fc_t {
  double eps;
  fc_t() {
    eps = 1e-8;
  }
  bool e(double lhs, double rhs) {
    return abs(lhs-rhs) < eps;
  }
  bool l(double lhs, double rhs) {
    return lhs+eps < rhs;
  }
  bool g(double lhs, double rhs) {
    return lhs-eps > rhs;
  }
} fc;

//main
int main() {
	return 0;
}
