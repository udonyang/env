#ifndef BIN_H
#define BIN_H 1

#include "stdlib.h"
#include "stdarg.h"
#include "value.h"
#include "stdio.h"

extern const void * Add;
extern const void * Sub;
extern const void * Value;

struct Val {
	const void * type;
	double value;
};

struct Bin {
	const void * type;
	void * left, * right;
};

static void * mkBin (va_list ap);

static void freeBin (void * tree);

#endif
