#include "value.h"

void * new (const void * type, ...)
{
	va_list ap;
	void * result;
	assert(type && ((struct Type *) type) -> new);
	va_start(ap, type);
	result = ((struct Type *) type) -> new(ap);
	* (const struct Type **) result = type;
	va_end(ap);
	return result;
}

double exec (const void * tree)
{
	return (* (struct Type **) tree) -> exec(tree);
}

void process (const void * tree)
{
	printf("\t%g\n", exec(tree));
}

void delete (void * tree)
{
	assert(tree && * (struct Type **) tree
			&& (* (struct Type **) tree) -> delete);
	(* (struct Type **) tree) -> delete(tree);
}

