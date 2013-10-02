#ifndef CLASS_h
#define CLASS_h 1

#include "stdlib.h"
#include "stdarg.h"
#include "stdlib.h"
#include "string.h"
#include "assert.h"

struct Class {
	size_t size;
	void * (* ctor) (void * self, va_list * app);
	void * (* dtor) (void * self);
	void * (* clone) (const void * self);
	int (* differ) (const void * self, const void * b);
};

#endif
