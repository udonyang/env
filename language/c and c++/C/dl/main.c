#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"
#include <dac/List.h>
#include <dlex2/DFA.h>

int a[] = {2, 3, 3, 4, 24, 4, 14}, la = sizeof(a) / sizeof(a[0]);

int main()
{
  List *list = ListNew(IntT);
  int i;
  for (i = 0; i < la; i++) {
    ListPush(list, a + i, LIST_TAIL);
  }
  for ( ; ListSize(list); ) {
    printf("%d\n", *(int*)ListGet(list, LIST_HEAD));
    ListPop(list, LIST_HEAD);
  }
  ListRemove(list);

  Array *a;
// 
//   DFA *dfa = DFAFromFile(0);
//   DFARemove(dfa);

	return 0;
}
