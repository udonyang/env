#include <stdio.h>

/* test power function
//int power(int m, int n);
int power();

main()
{
	int i;

	for (i = 0; i < 10; ++i) {
		printf("%d %d %d\n", i, power(2,i), power(-3,i));
	}
	return 0;
}

//new-style version power: raise base to n-th power; n >= 0
int power(int base, int n)
{
	int i, p;

	p = 1;
	for (i = 1; i <= n; ++i) {
		p = p * base;
	}
	return p;
}

// old-style version
power(base, n)
int base, n;
{
	int i, p;
	
	p = 1;
	for (i = 1; i <= n; ++i) {
		p = p * base;
	}
	return p;
} */