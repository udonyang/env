#ifndef STRING_H
#define STRING_H 1

#include "new.h"
#include "Class.h"

extern const void * String;

struct String {
	const void * class; /* must be first */
	char * text;
};

#endif
