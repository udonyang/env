#include "TreeMap.h"

void* TreeMapInsert(void* this, void* key) {
  return 0;
}

const MapIntr __TreeMapOps = {TreeMapInsert},
      *TreeMapOps = &__TreeMapOps;
