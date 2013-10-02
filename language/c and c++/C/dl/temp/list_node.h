#ifndef LIST_NODE_H_
#define LIST_NODE_H_

#include "stdlib.h"

typedef struct list_node {
  struct list_node *to[2];
  void *data;
} list_node;

list_node *list_node_new(void *data);

void list_node_drop(list_node *x);

void list_node_insert(list_node *x, list_node *y, int pn);

void list_node_set_data(list_node *x, void *data);

void *list_node_get_data(list_node *x, void *data);

#endif // list_node.h
