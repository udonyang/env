#ifndef OBJECT_R
#define OBJECT_R 1

#include "Object.h"

/* Representation of Object */
struct Object {
	const struct Class* class;
};

/* Representation of Class */
struct Class {
	const struct Object _;		/* class’ description */
	const char * name;			/* class’ name */
	const struct Class * super; /* class’ super class */
	size_t size; 				/* class’ object’s size */

	void * (* ctor) (void * self, va_list * app);
	void * (* dtor) (void * self);
	int (* differ) (const void * self, const void * b);
	int (* puto) (const void * self, FILE * fp);
};

void*		super_ctor (const void * _class, void * _self, va_list * app);
void*		super_dtor (const void * _class, void * _self);

#endif /* Object.r */
