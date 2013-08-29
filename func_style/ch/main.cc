#include <cstdio>

struct ch_t {
  vector<pt_t> p;
  double l;
  ch_t(vector<pt_t> &ps) {
    asort(p = ps);
    vector<pt_t> s(p.begin(), p.begin()+2);
    ps.clear();
    for (int i = 2; i < p.size(); i++) {
      for ( ; fc.g((s[s.size()-2]-s.back())%(p[i]-s.back()), 0.0); )
        ps.push_back(s.back()), s.pop_back();
      s.push_back(p[i]);
    }
    p = s;
    for (int i = l = 0; i < p.size(); i++)
      l += (p[(i+1)%p.size()]-p[i])[0];
  }
};

//main
int main() {
	return 0;
}
