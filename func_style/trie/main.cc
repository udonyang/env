#include <cstdio>
const int N = 10;

namespace trie {
  struct node {
    node *s[32];
    int sz;
  } pool[N], *top;
  void init() {
    top = pool;
  }
  node *make() {
    node t = {0};
    *top = t;
    return top++;
  }
  void push(node *x, char *s) {
    x->sz++;
    for ( ; *s; s++) {
      int k = *s-'a';
      if (!x->s[k]) x->s[k] = make();
      x = x->s[k];
      x->sz++;
    }
  }
}
using namespace trie;

//main
int main() {
	return 0;
}
