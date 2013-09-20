#include <cstdio>

vector<int> A, N;
int gcd(int a, int b, int &x, int &y) {
	int d, tx, ty;
	if (b == 0) {
		x = 1;
		y = 0;
		return a;
	}
	d = gcd(b, a%b, tx, ty);
	x = ty;
	y = tx-(a/b)*ty;
	return d;
}
int mle(int a, int b, int n) {
	int d, x, y;
	d = gcd(a, n, x, y);
	if (b%d == 0) {
		x = x*b/d%n;
		return x;
	}
	return 0;
}
int crt() {
	int x = 0, n = 1, i, bi;
	for (i = 0; i < N.size(); i++) n *= N[i];
	for (i = 0; i < A.size(); i++) {
		bi = mle(n / N[i], 1, N[i]);
		x = (x+A[i]*bi*(n/N[i]))%n;
	}
	return x;
}

//main
int main() {
	return 0;
}
