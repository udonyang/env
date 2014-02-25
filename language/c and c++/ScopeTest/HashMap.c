#include "HashMap.h"

void* HashMapInsert(void* this, void* key) {
  return 0;
}

const MapIntr __HashMapOps = {HashMapInsert},
      *HashMapOps = &__HashMapOps;
