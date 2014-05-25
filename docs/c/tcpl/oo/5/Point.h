#ifndef Point_h
#define Point_h 1

#include "Object.r"

/* Static Linkage */
void move(void* point, int dx, int dy);
/* Dynamic Linkage */
void draw(const void* self);

/* Descriptor of Point*/
extern const void* Point;

/* Descriptor of PointClass */
extern const void* PointClass;

void initPoint (void);

#endif /* Point.h */
