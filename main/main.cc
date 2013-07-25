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
	  oo = -1;
const long long inf64 = 0x7fffffffffffffffLL; 

//type definition
typedef unsigned char UC;
typedef unsigned long long ULL;
typedef long long LL;
typedef int int_a[maxn];
typedef bool bool_a[maxn];
typedef char char_a[maxn];

//simple fuction
LL dMin(LL lv, LL rv) {
	if (rv < lv) {
		swap(rv, lv);
	}
	if (lv == oo) {
		return rv;
	}
	return lv;
}
LL dMax(LL lv, LL rv) {
	if (rv < lv) {
		swap(rv, lv);
	}
	if (lv == oo) {
		return oo;
	}
	return rv;
}

//macro
#define WHERE	puts(__func__);
#define PA(H, A, I, S, E, F,...) {\
	puts(H);\
	for (int I = (S); I < (E); I++) {\
		printf(F,##__VA_ARGS__);\
	}\
	puts("");\
}

//extern
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
