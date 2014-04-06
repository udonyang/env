#include "stdio.h"
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <getopt.h>

typedef struct {
	void* (*copy)(void*);
	void (*drop)(void*);
	int (*vs)(void*, void*);
} Dac;

void* IntCopy (void* data)
{
	int *new = malloc(sizeof(int));
	memcpy(new, data, sizeof(int));
	return new;
}

int IntVs(void* lhs, void* rhs)
{
	int lv = *(int*)lhs;
	int rv = *(int*)rhs;
	return lv == rv? 0: lv < rv? -1: 1;
}

Dac DacOfInt = {
	IntCopy,
	free,
	IntVs
};

typedef struct TreeNode {
	int size, height;
	struct TreeNode *father, *son[2];
	Dac *ops;
	void *data;
} TreeNode;

TreeNode* TreeNodeNew(Dac* ops, void* data)
{
	TreeNode *new = malloc(sizeof(TreeNode));
	new->size = new->height = 1;
	new->ops = ops;
	new->data = ops->copy(data);
	new->father = new->son[0] = new->son[1] = NULL;
	return new;
}

void TreeNodeDrop(TreeNode* this)
{
	if (this == NULL) return ;
	TreeNodeDrop((void*)this->son[0]);
	TreeNodeDrop((void*)this->son[1]);
	this->ops->drop(this->data);
	free(this);
}

int TreeNodeGetVaneFromFather(TreeNode* this)
{
	return this->father->son[1] == this;
}

void TreeNodeUpdate(TreeNode* this)
{
	this->size = this->height = 1;
	for (int i = 0; i < 2; i++)
		if (this->son[i] != NULL) {
			this->size += this->son[i]->size;
			if (this->height < this->son[i]->height+1)
				this->height = this->son[i]->height+1;
		}
}

TreeNode* TreeNodeRotate(TreeNode* this)
{
	TreeNode *father = this->father;
	int vane = TreeNodeGetVaneFromFather(this);
	this->father = this->father->father;
	if (this->father)
		this->father->son[TreeNodeGetVaneFromFather(father)] = this;
	TreeNode *son = this->son[!vane];
	this->son[!vane] = father;
	father->father = this;
	father->son[vane] = son;
	son->father = father;
	TreeNodeUpdate(this->son[!vane]);
	TreeNodeUpdate(this);
	if (this->father)
		TreeNodeUpdate(this->father);
	return this;
}

int TreeNodeGetRatio(TreeNode* this)
{
	int ratio = 0;
	if (this->son[0]) ratio += this->son[0]->height;
	if (this->son[1]) ratio -= this->son[1]->height;
	return ratio;
}

TreeNode* TreeNodeBalance(TreeNode* this)
{
	int ratio = TreeNodeGetRatio(this);
	if (-1 <= ratio && ratio <= 1)
		return this;
	int vane = 0 < ratio;
	if ((0 < TreeNodeGetRatio(this->son[vane])) != ratio)
		this->son[vane] = TreeNodeRotate(this->son[vane]->son[!vane]);
	return TreeNodeRotate(this->son[vane]);
}

TreeNode* TreeNodeInsert(TreeNode* this, TreeNode* key)
{
	if (this == NULL)
		return key;
	int vane = 0 < this->ops->vs(key->data, this->data);
	this->son[vane] = TreeNodeInsert(this->son[vane], key);
	return TreeNodeBalance(this);
}

TreeNode* TreeNodeFind(TreeNode* this, void* data)
{
	if (this == NULL)
		return NULL;
	int vsResult = this->ops->vs(data, this->data);
	if (vsResult == 0)
		return this;
	return TreeNodeFind(this->son[0 < vsResult], data);
}

TreeNode* TreeNodeEnd(TreeNode *this, int vane)
{
	while (this->son[vane])
		this = this->son[vane];
	return this;
}

TreeNode* TreeNodeDelete(TreeNode* this, void* data)
{
	if (this == NULL)
		return NULL;
	int vsResult = this->ops->vs(data, this->data);
	if (vsResult == 0) {
		if (this->son[0] == NULL && this->son[1] == NULL) {
			TreeNodeDrop(this);
			return NULL;
		}
		int vane = this->son[1] == NULL;
		TreeNode *old = TreeNodeEnd(this, vane);
		void* temp = this->data;
		this->data = old->data;
		old->data = temp;
		this->son[vane] = TreeNodeDelete(this->son[vane], data);
		return TreeNodeBalance(this);
	}
	int vane = 0 < vsResult;
	this->son[vane] = TreeNodeDelete(this->son[vane], data);
	return TreeNodeBalance(this);
}

TreeNode* TreeNodePick(TreeNode *this, int rank)
{
	if (rank == 1)
		return this;
	int lsize = 1+(this->son[0]? this->son[0]->size: 0);
	int vane = lsize < rank;
	return TreeNodePick(this->son[vane], rank-vane*lsize);
}

void TreeNodeWalk(TreeNode *this, void (*f)(void*))
{
	if (this == NULL)
		return ;
	TreeNodeWalk(this->son[0], f);
	f(this->data);
	TreeNodeWalk(this->son[1], f);
}

typedef struct {
	TreeNode *root;
	Dac *ops;
} Tree;

Tree* TreeNew(Dac* ops)
{
	Tree *new = malloc(sizeof(Tree));
	new->root = NULL;
	new->ops = ops;
	return new;
}

void TreeDrop(void* this)
{
	Tree* old = this;
	TreeNodeDrop(old->root);
	free(this);
}

void TreeInsert(Tree* this, void* data)
{
	this->root = TreeNodeInsert(this->root, TreeNodeNew(this->ops, data));
}

void* TreeFind(Tree* this, void* data)
{
	TreeNode *result = TreeNodeFind(this->root, data);
	return result == NULL? NULL: result->data;
}

void TreeDelete(Tree* this, void* data)
{
	this->root = TreeNodeDelete(this->root, data);
}

void *TreePick(Tree* this, int rank)
{
	TreeNode *result = TreeNodePick(this->root, rank);
	return result == NULL? NULL: result->data;
}

void TreeWalk(Tree* this, void (*f)(void*))
{
	TreeNodeWalk(this->root, f);
}

int *as, nAs;

void helper(void* data) 
{
	printf(" %d", *(int*)data);
}

void TreeTest()
{
	Tree *tree = TreeNew(&DacOfInt);
	for (int i = 0; i < nAs; i++)
		TreeInsert(tree, as+i);
	TreeWalk(tree, helper);
	puts("");
	// for (int i = 1; i <= nAs; i++)
	// 	printf(" %d", *(int*)TreePick(tree, i));
	// puts("");
	for (int i = 0; i < nAs; i++) {
		TreeDelete(tree, as+i);
		TreeWalk(tree, helper);
		puts("");
	}
	TreeDrop(tree);
}

int main(int argc, char **argv)
{
	if (argc < 2)
		nAs = 10;
	else 
		nAs = atoi(argv[1]);
	srand((unsigned int)time(0));
	as = calloc(nAs, sizeof(int));
	for (int i = 0; i < nAs; i++)
		as[i] = i;
	for (int i = 0; i < nAs; i++) {
		int x = rand()%nAs,
				y = rand()%nAs,
				t = as[x];
		as[x] = as[y];
		as[y] = t;
	}
	for (int i = 0; i < nAs; i++)
		printf(" %d", as[i]);
	puts("");
	TreeTest();
	free(as);
  return 0;
}
