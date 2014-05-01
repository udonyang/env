/* string auto concatenating */
char usage[] = {
	"C would concatenate two string constants at compile time.\n"
		"just like this message."
};
void usageTest() {
	puts(usage);
}
/* names in different enumeration must be distinct */
enum escapes {
	BELL = '\a', BACKSPACE = '\b', TAB = '\t',
	NEWLINE = '\n', VTAB = '\v', RETURN = '\r'
};
enum months {
	//BELL = -1,
	JAN = 1, FEB, MAR, APR, MAY, JUN,
	JUL, AUG, SEP, OCT, NOV, DEC
		/* FEB = 2, MAR = 3, etc. */
};
void enumTest() {
	putchar(BELL);
	puts("BELL");
	putchar(VTAB);
	puts("VTAB");
	putchar(BACKSPACE);
}
int main () {
	//usageTest();
	enumTest();
	return 0;
}
