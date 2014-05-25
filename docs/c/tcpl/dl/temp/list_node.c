#include "list_node.h"

list_node *list_node_new(void *data)
{
  list_node* x = malloc(sizeof(list_node));
  if (x) {
    x->to[0] = x->to[1] = x;
    x->data = data;
  }
  return x;
}

void list_node_drop(list_node *x)
{
  x->to[0]->to[1] = x->to[1];
  x->to[1]->to[0] = x->to[0];
  free(x);
}

void list_node_insert(list_node *x, list_node *y, int pn)
{
  y->to[pn]->to[!pn] = x;
  x->to[pn] = y->to[pn];
  y->to[pn] = x;
  x->to[!pn] = y;
}

void list_node_set_data(list_node *x, void *data)
{
  x->data = data;
}

void *list_node_get_data(list_node *x, void *data)
{
  return x->data;
}
