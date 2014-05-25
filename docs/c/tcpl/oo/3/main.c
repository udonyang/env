#include "setjmp.h"
#include "stdarg.h"
#include "stdio.h"
#include "Scanner.h"
#include "value.h"
#include "Bin.h"

static enum tokens token;

/* current input symbol */
static jmp_buf onError;

static double number; /* if NUMBER: numerical value */

void error (const char * fmt, ...);

static enum tokens scan (const char * buf);

static void * factor (void);

static void * product (void);

static void * sum (void);

int main (void)
{
	volatile int errors = 0;
	char buf [BUFSIZ];
	if (setjmp(onError))
		++ errors;
	while (gets(buf))
		if (scan(buf))
		{
			void * e = sum();
			if (token)
				error("trash after sum");
			process(e);
			delete(e);
		}
	return errors > 0;
}

void error (const char * fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap), putc('\n', stderr);
	va_end(ap);
	longjmp(onError, 1);
}

static enum tokens scan (const char * buf)
	/* return token = next input symbol */
{
	static const char * bp;
	if (buf)
		bp = buf;
	/* new input line */
	while (isspace(* bp))
		++ bp;
	if (isdigit(* bp) || * bp == '.')
	{
		errno = 0;
		token = NUMBER, number = strtod(bp, (char **) & bp);
		if (errno == ERANGE)
			error("bad value: %s", strerror(errno));
	}
	else
		token = * bp ? * bp ++ : 0;
	return token;
}

static void * factor (void)
{
	void * result;
	switch (token) {
		case '+':
			scan(0);
			return factor();
			/*case '-':
			  scan(0);
			  return new(Minus, factor());*/
		case NUMBER:
			result = new(Value, number);
			break;
		case '(':
			scan(0);
			result = sum();
			if (token != ')')
				error("expecting )");
			break;
		default:
			error("bad factor: '%c' 0x%x", token, token);
	}
	scan(0);
	return result;
}

static void * sum (void)
{
	void * result = factor();
	const void * type;
	for (;;)
	{
		switch (token) {
			case '+':
				type = Add;
				break;
			case '-':
				type = Sub;
				break;
			default:
				return result;
		}
		scan(0);
		result = new(type, result, factor());
	}
}
