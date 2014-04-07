#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
using namespace std;
const int N = 1e5+10;

template<class T> struct Avl {
	struct Node {
		Node *son[2];
		int height;
		T data;
		int ratio() {return (son[1]? son[1]->height: 0)-(son[0]? son[0]->height: 0);}
		Node *pull() {
			height = 1;
			for (int i = 0; i < 2; i++)
				if (son[i]) height = max(height, son[i]->height+1);
			return this;
		}
		Node *setSon(int vane, Node *orphan) {
			son[vane] = orphan;
			return pull();
		}
		Node *spin(int vane) {
			Node *x = son[!vane]->son[vane];
			son[!vane]->son[vane] = this;
			Node *y = son[!vane];
			setSon(!vane, x);
			return y->pull();
		}
		Node *fine() {
			int x = ratio();
			if (-1 <= x && x <= 1) return this;
			int vane = 0 < x;
			if ((0 < son[vane]->ratio()) != vane)
				setSon(vane, son[vane]->spin(vane));
			return spin(!vane);
		}
		Node *end(int vane) {return son[vane]? son[vane]->end(vane): this;}
	};
	Node pool[N], *root, *top;
	int size;
	Avl(): root(NULL), top(pool), size(0) {}
	Node *make(T &data) {
		Node t = {{0}, 1, data};
		return &(*top++ = t);
	}
	Node *addAux(Node *cur, T &data) {
		if (!cur) return make(data);
		int vane = cur->data < data;
		return cur->setSon(vane, addAux(cur->son[vane], data))->fine();
	}
	void add(T &data) {
		root = addAux(root, data);
		size++;
	}
	T &findAux(Node *cur, T &data) {
		if (!cur) return T();
		if (cur->data == data) return cur->data;
		int vane = cur->data < data;
		return findAux(cur->son[vane], data);
	}
	T &find(T &data) {return findAux(root, data);}
	Node *removeAux(Node *cur, T &data) {
		if (!cur) return NULL;
		int vane = cur->data < data;
		if (cur->data == data) {
			if (cur->son[0] == cur->son[1]) return 0;
			vane = cur->son[1] != NULL;
			swap(cur->data, cur->son[vane]->end(!vane)->data);
		}
		return cur->setSon(vane, removeAux(cur->son[vane], data))->fine();
	}
	void remove(T &data) {
		root = removeAux(root, data);
		size--;
	}
	T &end(int vane) {return root->end(vane)->data;}
};

template<class T> struct Splay {
	struct Node {
		Node *father, *son[2];
		T data;
		int side() {return father->son[1] == this;}
		Node *setSon(int vane, Node *orphan) {
			son[vane] = orphan;
			if (orphan) orphan->father = this;
			return this;
		}
		Node *spin() {
			Node *x = father;
			int vane = side();
			father = father->father;
			if (father) father->son[x->side()] = this;
			Node *y = son[!vane];
			setSon(!vane, x);
			x->setSon(vane, y);
			return this;
		}
		Node *fine(Node *sky = 0) {
			for ( ; father != sky; spin())
				if (father->father != sky)
					if (side() != father->side()) spin();
					else father->spin();
			return this;
		}
		Node *end(int vane) {return son[vane]? son[vane]->end(vane): this;}
		Node *find(T &data) {
			Node *x = this;
			while (1) {
				int vane = x->data < data;
				if (x->data == data || !x->son[vane]) break;
				x = x->son[vane];
			}
			return x;
		}
		Node *leave() {
			if (father) father->son[side()] = 0;
			father = 0;
			return this;
		}
	};
	Node pool[N], *top, *root;
	int size;
	Splay(): top(pool), root(0), size(0) {}
	Node *make(T &data) {
		Node t = {0, {0}, data};
		return &(*top++ = t);
	}
	void add(T &data) {
		Node *x = make(data);
		if (root) {
			root = root->find(data);
			root->setSon(root->data < data, x);
		}
		root = x->fine();
		size++;
	}
	T &find(T &data) {
		if (!root) return T();
		root = root->find(data);
		return root->fine()->data;
	}
	void remove(T &data) {
		root = root->find(data)->fine();
		if (root->data == data) {
			if (size == 1) root = 0;
			else {
				int vane = root->son[1] != 0;
				root->son[vane]->end(!vane)->fine(root);
				root->son[vane]->setSon(!vane, root->son[vane]);
				root = root->son[vane];
				root->leave();
			}
			size--;
		}
	}
	T &end(int vane) {return root->end(vane)->data;}
};

struct Client {
	int id, p;
	void input() {scanf("%d%d", &id, &p);}
	friend bool operator < (const Client &lhs, const Client &rhs) {
		return lhs.p < rhs.p;
	}
	friend bool operator == (const Client &lhs, const Client &rhs) {
		return lhs.p == rhs.p;
	}
};

Splay<Client> zkl;

int main() {
#ifndef ONLINE_JUDGE
  freopen("input.in", "r", stdin);
#endif
	int op;
	while (scanf("%d", &op), op) {
		if (op == 1) {
			Client t;
			t.input();
			zkl.add(t);
		} else {
			if (!zkl.size) {
				puts("0");
			} else {
				Client ret = zkl.end(op == 2);
				printf("%d\n", ret.id);
				zkl.remove(ret);
			}
		}
	}
  return 0;
}
