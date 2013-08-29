#include <cstdio>

LL eul[N];
vector<int> fac[N], prm;
void sieve() {
  eul[1] = 1;
  for (int i = 2; i < N; i++) {
    if (eul[i] == 0) {
      prm.push_back(i);
      for (int j = i; j < N; j += i) {
        if (eul[j] == 0) eul[j] = j;
        fac[j].push_back(i);
        eul[j] -= eul[j]/i;
      }
    }
    eul[i] += eul[i-1];
  }
}

//main
int main() {
	return 0;
}
