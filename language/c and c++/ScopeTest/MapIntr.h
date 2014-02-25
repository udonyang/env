#ifndef MAP_INTR_H
#define MAP_INTR_H

typedef struct {
  void* (*insert)(void*, void*);
} MapIntr;

#endif
