#include <stdio.h>

/* count digits, white space, others
main()
{
	int c, i, nwhite, nother;
	int ndigit[10];

	nwhite = nother = 0;
	for (i = 0; i < 10; ++i) {
		ndigit[i] = 0;
	}

	while ((c = getchar()) != EOF) {
		if (c >= '0' && c <= '9') {
			++ndigit[c-'0'];
		}
		else if (c == ' ' || c == '\n' || c == '\t') {
			++nwhite;
		}
		else {
			++nother;
		}
	}

	printf("digits =");
	for (i = 0; i < 10; ++i) {
		printf(" %d", ndigit[i]);
	}
	printf(", white space = %d, other = %d\n", nwhite, nother);
}
*/
/* exp 1-13 print a histogram of the lengths of words
#define IN 1 // inside a word
#define OUT 0 // outside  word
#define LEN 5 // length of array
main()
{
	int c, i, j, nl, nw, nc, state, wl;
	int len[LEN];

	state = OUT;
	nl = nw = nc = wl = 0;
	for (i = 0; i < LEN; ++i) {
		len[i] = 0;
	}

	while ((c = getchar()) != EOF) {
		++nc;
		if (c == '\n') {
			++nl;
		}
		if (c == ' ' || c == '\n' || c == '\t') {
			state = OUT;
			if (wl < LEN - 1) ++len[wl];
			else ++len[LEN - 1];
			wl = 0;
		}
		else {
			if (state == OUT) {
				state = IN;
				++nw;
			} 
			++wl;
		}
	}

	putchar('\n');
	for (i = 0; i < LEN; ++i) {
		printf("%22c", ' ');
		for (j = 0; j < len[i]; ++j) {
			putchar('_');
		}
		putchar('\n');
		if (i < LEN - 1) printf("length=%3d", i);
		else printf("length>%3d", LEN-2);
		printf(" count=%3d |", len[i]);
		for (j = 0; j < len[i]; ++j) {
			putchar('_');
		}
		printf("|\n");
	}
}
*/
/* exp 1-14 print a histogram of the frequencies of different characters */
#define LEN 128 // length of array

main()
{
	int c, i, j;
	int times[LEN];

	for (i = 0; i < LEN; ++i) {
		times[i] = 0;
	}

	while ((c = getchar()) != EOF) {
		times[c]++;
	}

	putchar('\n');
	for (i = 0; i < LEN; ++i) {
		printf("%9c", ' ');
		for (j = 0; j < times[i]; ++j) {
			putchar('_');
		}
		putchar('\n');
		printf("%c", i);
		printf(" f=%3d |", times[i]);
		for (j = 0; j < times[i]; ++j) {
			putchar('_');
		}
		printf("|\n");
	}
}
