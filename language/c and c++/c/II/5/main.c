#include <stdio.h>

/* copy input to output; 1st version
main()
{
	int c;
	
	c = getchar();
	while (c != EOF) {
		putchar(c);
		c = getchar();
	}
}
*/
/* copy input to output; 2nd version
main()
{
	int c;
	
	printf("%c", EOF);  //exp1-7
	while ((c = getchar()) != EOF) {
		printf("%d", c != EOF);  //exp1-6
		putchar(c);
	}
}
*/
/* count characters in input; 1st version
main()
{
	long nc;

	nc = 0;
	while (getchar() != EOF) {
		nc++;
	}
	printf("%1d\n", nc);
}
*/
/* count characters in input; 2nd version
main()
{
	double nc;

	for (nc = 0; getchar() != EOF; ++nc) {
	}
	printf("%.0f\n", nc);
}
*/
/* count lines in input
main()
{
	int c, nl;

	nl = 0;
	while ((c = getchar()) != EOF) {
		if (c == '\n') {
			++nl;
		}
	}
	printf("%d\n", nl);
}
*/
/* exp 1-8 count blanks, tabs, and newlines/
main()
{
	int c, nb, nt, nn;

	nb = 0;
	nt = 0;
	nn = 0;

	while ((c = getchar()) != EOF) {
		if (c == ' ') {
			++nb;
		}
		else if (c == '\t') {
			++nt;
		}
		else if (c == '\n') {
			++nn;
		}
	}
	printf("\n%d %d %d\n", nb, nt, nn);
}
*/
/* exp 1-9 copy its input to its output replaces blanks by a single blank
main()
{
	int c;

	while ((c = getchar()) != EOF) {
		if (c == ' ') {
			while ((c = getchar()) == ' ') {
			}
			putchar(' ');
		}
		putchar(c);
	}
}
*/
/* exp 1-10 copy, backspace to \b, tab by \t backslash by \\
main()
{
	int c;

	while ((c = getchar()) != EOF) {
		if (c == '\b') {
			printf("\\b");
		}
		else if (c == '\t') {
			printf("\\t");
		}
		else if (c == '\\') {
			printf("\\\\");
		}
		else {
			putchar(c);
		}
	}
}
*/
/* count lines, words, and characters in input 
#define IN 1 // inside a word
#define OUT 0 // outside  word
// aaaaaaaa\
bbbbbbbbb ddddd\
ccccccc //exp 1-11
main()
{
	int c, nl, nw, nc, state;

	state = OUT;
	nl = nw = nc = 0;
	while ((c = getchar()) != EOF) {
		++nc;
		if (c == '\n') {
			++nl;
		}
		if (c == ' ' || c == '\n' || c == '\t') {
			state = OUT;
			putchar('\n'); //exp 1-12
		}
		else {
			putchar(c);
			if (state == OUT) {
				state = IN;
				++nw;
			} 
		}
	}
	printf("%d %d %d\n", nl, nw, nc);
}
*/
