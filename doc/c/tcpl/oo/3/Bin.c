#include "Bin.h"

static void * mkBin (va_list ap)
{
	struct Bin * node = malloc(sizeof(struct Bin));
	assert(node);
	node -> left = va_arg(ap, void *);
	node -> right = va_arg(ap, void *);
	return node;
}


static void doBin (const void * tree) 
{
	exec(((struct Bin*) tree) -> left);
	exec(((struct Bin*) tree) -> right);
	printf(" %s", (*(struct Type**) tree) -> name);
}

static double doAdd (const void * tree)
{
	return exec(((struct Bin *) tree) -> left) +
		exec(((struct Bin *) tree) -> right);
}

static double doSub(const void * tree)
{
	return exec(((struct Bin *) tree) -> left) -
		exec(((struct Bin *) tree) -> right);
}

static double doVal (const void * tree)
{
	return ((struct Val *) tree) -> value;
}

static void * mkVal (va_list ap)
{
	struct Val * node = malloc(sizeof(struct Val));
	assert(node);
	node -> value = va_arg(ap, double);
	return node;
}

static void freeBin (void * tree)
{
	delete(((struct Bin *) tree) -> left);
	delete(((struct Bin *) tree) -> right);
	free(tree);
}

static struct Type _Value = { "", mkVal, doVal, free };
const void * Value = & _Value;

static struct Type _Add = { "+", mkBin, doAdd, freeBin };
static struct Type _Sub = { "-", mkBin, doSub, freeBin };
const void * Add = & _Add;
const void * Sub = & _Sub;
