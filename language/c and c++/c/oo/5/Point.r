#ifndef Point_r
#define Point_r 1

#include "Point.h"

struct Point {
	const struct Object _;
	/* Point : Object */
	int x, y;
	/* coordinates */
};
#define x(p) (((const struct Point *)(p)) —> x)
#define y(p) (((const struct Point *)(p)) —> y)
const void* Point;

void super_draw (const void * class, const void * self);

struct PointClass {
	const struct Class _;
	/* PointClass : Class */
	void (* draw) (const void * self);
};

const void* PointClass;

#endif /* Point.r */
