#include "stdio.h"
#include "ctype.h"
#include "math.h"
/* squeeze: delete any character in s1 that match any character
 * 		in s2 */ 
char* squeeze(char s1[], char s2[]) {
	int i, j = 0, k, in;
	for (i = 0 ; s1[i]; i++) {
		in = 0;
		for (k = 0; s2[k]; k++) {
			if (s1[i] == s2[k]) {
				in = 1;
				break;
			}
		}
		if (!in) {
			s1[j++] = s1[i];
		}
	}
	s1[j] = '\0';
	return s1;
}
/* any: return the first location in a string s1
 * 		where any character from the string s2 occurs,
 * 		or -1 if s1 contains no characters from s2. */
int any(char s1[], char s2[]) {
	int i, k;
	for (i = 0 ; s1[i]; i++) {
		for (k = 0; s2[k]; k++) {
			if (s1[i] == s2[k]) {
				return i;
			}
		}
	}
	return -1;
}
int main() {
	puts(squeeze((char[]){"fuckme"}, (char[]){"ue"}));
	printf("%d\n", any((char[]){"fuckme"}, (char[]){"ue"}));
	return 0;
}
