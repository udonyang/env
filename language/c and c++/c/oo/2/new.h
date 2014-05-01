#ifndef NEW_H
#define NEW_H 1

#include "Class.h"

void* new(const void* type, ...);
void delete(void* item);
void * clone (const void * self);
int differ (const void * self, const void * b);
size_t sizeOf (const void * self);

#endif
