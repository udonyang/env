#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <regex>
#include <string>
using namespace std;

int main() {
#if 1
  freopen("input.in", "r", stdin);
#endif
  string t("sswoooolllfffss");
  smatch m;
  regex r("([^w]*)w+o+l+f+.*");
  regex_match(t, m, r);
  for (auto i: m) cout << i << endl;
  return 0;
}
