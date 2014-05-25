#ifndef OBJECT_H
#define OBJECT_H 1

#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "stdarg.h"
#include "assert.h"
#include "stddef.h"


/* Generic Selector */
void*			new(const void* class, ...);
void			delete(void* self);
const void*		super (const void * _self);
const void*		classOf (const void * _self);
size_t			sizeOf (const void * _self);

/* Descriptor of Object */
extern const void* Object; /* new(Object); */

/* Descriptor of Class */
extern const void * Class; /* new(Class, "name", super, size, sel, meth, ... 0); */

/* Interfaces of Class */
void*		ctor (void * _self, va_list * app);
void*		dtor (void * _self);
int			differ(const void* self, const void* b);
int			puto(const void* self, FILE* fp);

#endif /* Object.h */
