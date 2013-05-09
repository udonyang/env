//coder: SXDwylkz
//heads
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <cctype>
#include <algorithm>
#include <vector>
#include <map>
#include <stack>
#include <queue>
#include <string>
#include <cstring>
#include <cmath>
//namespaces
using namespace std;
//constants
const char input[] = "input.in",
	  output[] = "output.out";
const int inf32 = 0x7fffffff,
	  maxn = 1e5 + 10,
	  OO = -1;
const long long inf64 = 0x7fffffffffffffffLL; 
//type definition
typedef unsigned char UC;
typedef unsigned long long ULL;
typedef long long LL;
typedef int AI[maxn];
typedef bool AB[maxn];
typedef char AC[maxn];
//simple fuction
LL dMin(LL lv, LL rv) {
	if (rv < lv) {
		swap(rv, lv);
	}
	if (lv == OO) {
		return rv;
	}
	return lv;
}
LL dMax(LL lv, LL rv) {
	if (rv < lv) {
		swap(rv, lv);
	}
	if (lv == OO) {
		return OO;
	}
	return rv;
}
//macro
#define WHERE	puts(__func__);
#define PA(H, A, I, S, E, F, X...) {\
	puts(H);						\
	for (int I = S; I < E; I++) {	\
		printf(F, ##X);				\
	}								\
	puts("");						\
}
//extern
AI a;
//main
int main() {
#if 1
	freopen(input, "r", stdin);
	//freopen(output, "w", stdout);
#endif
	for ( ; ; ) {
	}
	return 0;
}
