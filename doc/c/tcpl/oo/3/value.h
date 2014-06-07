#ifndef VALUE_H
#define VALUE_H 1

#include "assert.h"
#include "stdarg.h"
#include "stdio.h"

struct Type {
	const char * name;
	void * (* new) (va_list ap);
	double (* exec) (const void * tree);
	void (* delete) (void * tree);
};

const void * Add;
const void * Sub;
double exec (const void * tree);
void * new (const void * type, ...);
void process (const void * tree);
void delete (void * tree);

#endif
