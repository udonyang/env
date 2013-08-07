#include <cstdio>

int kmp(char *s, char *p, int *f, int o)
{
  int sl = strlen(s), pl = strlen(p);
  for (int i = 0, j = -1; (o&1) && i<pl; i++) {
    for (j -= (j>=0); j!=-1 && p[i]!=p[j+1]; j = f[j]);
    f[i] = (j<0 || p[i]==p[j])? j++: -1;
  }
  for (int i = -1, j = -1; (o&2) && i<sl-1; i++) {
    for ( ; j!=-1 && s[i+1]!=p[j+1]; j = f[j]);
    if (s[i+1]==p[j+1] && ++j==pl-1) return i+1;
  }
  return -1;
}

//main
int main() {
	return 0;
}
