#include <stdio.h>
#define MAXLINE 1000 //maximum input line length

int getlines(char line[], int maxline);
void copy(char to[], char from[]);
void delline(char string[], int length);
void reverse(char string[], int length);

//print the longest input line
main()
{
	int len; //current line length
	int max; //maximum length seen so far 
	char line[MAXLINE]; //current input line
	char longest[MAXLINE]; //longest line saved here

	max = 0;
	while ((len = getlines(line, MAXLINE)) > 0) {
		if (len > max) {
			max = len;
			copy(longest, line);
		}
		if (len > 80) { //exp 1-17
			printf("%s\n", line);
		}
		//delline(line, len); //exp 1-18
		reverse(line, len); //exp 1-19
		printf("%s|\n", line);
	}
	if (max > 0) { //there was a line
		//printf("%s", longest);
		printf("%d", max); //exp 1-16
	}
	return 0;
}

//getline: read a line into s, return length
int getlines(char s[], int lim) 
{
	int c, i;

	for (i=0; i < lim-1 && (c=getchar())!=EOF && c!='\n'; ++i) {
		s[i] = c;
	}
	if (c == '\n') {
		s[i] = c;
		++i;
	}
	s[i] = '\0';
	return i;
}

//copy: copy 'from' into 'to' assume to is big enough
void copy(char to[], char from[])
{
	int i;

	i = 0;
	while ((to[i] = from[i]) != '\0') {
		++i;
	}
}

//delline: delete 's''s trailing blank characters and delete blank lines
void delline(char s[], int len)
{
	int i;
	
	if (len == 1) {
		s[0] = '\0';
		return ;
	}
	for (i=len-2; i>0 && (s[i]==' ' || s[i]=='\t'); --i) {
	}
	s[i+1] = '\0';
}

//reverse: reverse string 's'
void reverse(char s[], int len)
{
	int i, t;

	s[--len] = '\0';
	for (i = 0; i < len/2; i++) {
		t = s[i];
		s[i] = s[len-i-1];
		s[len-i-1]=t;
	}
}
