/* Object-Oriented C programming */
#include "assert.h"
#include "stdio.h"
#include "stdlib.h"
#include "setjmp.h"
#include "stdarg.h"
#include "stddef.h"

void memoryTest() {
	int i, *a = calloc(10, sizeof(int));
	for (i = 0; i < 10; i++) {
		printf("%d", a[i]);
	}
	free(a);
	a = malloc(10 * sizeof(int));
	for (i = 0; i < 10; i++) {
		printf("%d", a[i]);
	}
	a = realloc(a, 11 * sizeof(int));
	for (i = 0; i < 11; i++) {
		printf("%d", a[i]);
	}
	free(a);
}

void dataTypeTest() {
	struct s{ short x; int a; };
	printf("%d\n", offsetof(struct s, a));
}

void classTest() {
	const struct Class {
		int a, b;
	} *p; 							// content protected
	typedef struct Class *ClassP;	// content open, pointer protected
}

void structTest() {
	/*
	   a pointer to a structure can be declared
	   even if the structure itself has not yet been introduced.
	*/
	struct w *wp;
	struct w { int w; };
	struct a { int x; };
	struct c { struct a a; int b; } c, *cp = &c;
	struct a *ap = &c.a;
	assert((void*)ap == (void*)cp);
	printf("%d\n", (void*)ap == (void*)cp);
	//cp->x; 							// wrong
	((struct a*)cp)->x;					// the key of inherit
}

void FunctinoTest() {
	void*	f		(void*);		// function
	void*	(*fp)	(void*);		// pointer to function
	int x;
	//f(&x);							// using function name
	//fp(&x);							// using function pointer
	//(*fp)(&x);						// using function, classic
	struct Class {
		void* (*ctor) (void* self, va_list *app);
	} *cp, **cpp;
	cp->ctor((void*)&x, (va_list*)&x);
	(*cpp)->ctor((void*)&x, (va_list*)&x);
}

void preprocessorTest() {
#define malloc(type) (type*)malloc(sizeof(type))
	int *p = malloc(int);
}

void fatal(const char *fmt, ...) {
	va_list ap;
	int code;

	va_start(ap, fmt);
	code = va_arg(ap, int);
	vprintf(fmt, ap);
	va_end(ap);
	exit(code);
}

int main() {

	/* 
	   	Use typecast to modify a const space.
	 	Circumvent the Compiler. 

		+++++++++++++  cast    +++++++
		| const int-+--------> | int |
		+++++++++++++          +++++++

		1. Cast a const address to modifiable address.
		2. Read the rvalue of the casted address.

	*/

	const int cx = 10;
	*(int*)&cx = 20;
	printf("%d\n", cx);

	const void *vp;
	int *ip;
	int *const p = ip;

	vp = ip; // ok, blocks assignment
	//ip = vp; // discard qualifier "const", but allow 
	ip = (void*)vp; // brute force, cast rvalue
	/*
	       +++++            ++++++++++++++
	 	vp | --+--------->  | const void |
		|  +++++            ++++++++++++++
        |
		| cast the pointer, to eliminate the qualifier
		|
	    V  +++++            ++++++++
	 	vp | --+--------->  | void | 
		   +++++            ++++++++

	 */
	*(const int**)&ip = vp; // ok, but overkill, cast lvalue
	//p = ip; 				// no, the pointer p is blocked
	//*p = 10;				// but, rvalue of p is unblocked
	
	//classTest();
	//structTest();
	//FunctinoTest();
	//preprocessorTest();
	//dataTypeTest();
	memoryTest();
	return 0;
}
