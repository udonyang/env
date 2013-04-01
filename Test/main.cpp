//coder: SXDwylkz
//heads
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <cctype>
#include <algorithm>
#include <vector>
#include <map>
#include <stack>
#include <queue>
#include <string>
#include <cstring>
//namespaces
using namespace std;
//constants
const char input[] = "input.in",
	  output[] = "input.in";
const int inf32 = 0x7fffffff,
	  maxn = 1e5 + 10;
const long long inf64 = 0x7fffffffffffffff; 
//structure
//Suffix Automaton
//include: cstring
//usage: obj.Init->(obj.$(others))*
struct DAWG {
	const static int n = maxn,  //Total of nodes
		  m = 26,               //Size of charator set
		  shift = 'a';          //Charactor shift
	struct Node {
		//Extern
		//Basic
		Node *s[m],             //Adjust node
			 *p;                //Suffix link
		int  l;                 //Length of current string
	};
	typedef Node *PNode;
	Node t[n];                  //Storage pool
	PNode top,                  //t's iterator
		  rt,                   //Initial State
		  tl;                   //The Last State
	//Init a node
	//usage: obj.New([length], [Suffix Link])
	PNode New(int l = 0, PNode p = 0) {
		top->l = l;
		top->p = p;
		memset(top->s, 0, sizeof(top->s));
		return top++;
	}
	//Init
	//usage: obj.Init()
	void Init() {
		top = t;
		tl = rt = New();
	}
	//append an charactor c
	//usage: obj.Insert(charactor)
	void Insert(char c) {
		PNode x = New(tl->l + 1), y = tl;
		c -= shift;
		tl = x;
		for (; y && !y->s[c]; y = y->p) {
			y->s[c] = x;
		}
		if (!y) {
			x->p = rt;
		} else if (y->s[c]->l == y->l + 1) {
			x->p = y->s[c];
		} else {
			PNode z = New(), w = y->s[c];
			*z = *w;
			z->l = y->l + 1;
			w->p = x->p = z;
			for (; y; y = y->p) {
				y->s[c] = z;
			}
		}
	}
	//Search for exprtiment
	//usage: obj.Search(string, length)
	int Search(char *s, int l) {
		PNode x = rt;
		int total = 0;
		for (int i = 0; i < l; i++) {
			int k = s[i] - shift;
			for (; x && !x->s[k]; x = x->p) {
			}
			if (!x) {
				x = rt;
				continue;
			}
			if (x->s[k] == tl || x->s[k] == tl->p) {
				total++;
				printf("Accept : ");
				for (int j = i - x->l; j <= i; j++) {
					putchar(s[j]);
				}
				printf(" endwith = %d, len = %d\n", x == tl, x->l + 1);
			}
			x = x->s[k];
		}
		printf("%d match.\n", total);
		return 1;
	}
	//Pinrt the Adjust arc of nodes
	//usage: obj.Print()
	void Print() {
		for (PNode i = t; i < top; i++) {
			printf("Node %3d: ", i - t);
			for (int j = 0; j < m; j++) {
				if (i->s[j]) {
					printf("%3c", j + 'a');
				}
			}
			puts("");
		}
	}
};
//AC Automaton
//include: queue, cstring
//usage: obj.Init->(obj.Insert)*->obj.Link->(obj.$(others))*
struct ACA {
	const static int n = maxn,  //Total of nodes
		  m = 26,               //Size of charator set
		  shift = 'a';          //Charactor shift
	struct Node {
		//Extern
		//Basic
		Node *s[m],             //Adjust node
			 *p;                //Failure link
		int  a;                 //Accpet state or not
	};
	typedef Node *PNode;
	//Extern
	//Baisc
	Node t[n];                  //Storage pool
	PNode top,                  //t's iterator
		  rt;                   //Initial State
	//Init a node
	//usage: obj.New([length], [Failure Link])
	PNode New() {
		memset(top, 0, sizeof(Node));
		return top++;
	}
	//Init
	//usage: obj.Init()
	void Init() {
		//Extern
		//Basic
		top = t;
		rt = New();
	}
	//Append a string
	//usage: obj.Insert(charactor)
	void Insert(char *s, int sl) {
		PNode x = rt;
		for (int i = 0; i < sl; i++) {
			int k = s[i] - shift;
			if (!x->s[k]) {
				x->s[k] = New();
			}
			x = x->s[k];
		}
		x->a++;
	}
	//Failure Linking
	//usage: obj.Link()
	void Link() {
		static PNode Q[n];
		Q[0] = rt;
		for (int f = 0, t = 1; f < t; ) {
			PNode x = Q[f++];
			for (int i = 0; i < m; i++) {
				if (x->s[i]) {
					if (x == rt) {
						x->s[i]->p = x;
					} else {
						PNode y = x->p;
						for (; y && !y->s[i]; y = y->p) {
						}
						if (!y) {
							x->s[i]->p = rt;
						} else {
							x->s[i]->p = y->s[i];
						}
					}
					Q[t++] = x->s[i];
				}
			}
		}
	}
	int Search(char *s, int sl) {
		int total = 0;
		PNode x = rt;
		for (int i = 0; i < sl; i++) {
			int k = s[i] - shift;
			for ( ; x && (k < 0 || m <= k || !x->s[k]); x = x->p) {
			}	
			if (!x) {
				x = rt;
				continue;
			}
			for (PNode y = x->s[k]; y; y = y->p) {
				total += y->a;
				y->a = 0;
			}
			x = x->s[k];
		}
		return total;
	}
};
//type definition
typedef long long LL;
//global variable
DAWG sa;
ACA aca;
//access and mutator
//main
int main() {
#if 0
	freopen(input, "r", stdin);
	freopen(output, "w", stdout);
#endif
	char s[] = "aabbabd";
	int sl = strlen(s);
	sa.Init();
	aca.Init();
	for (int i = 0; i < sl; i++) {
		sa.Insert(s[i]);
		printf("Insert %s\n", s + i);
		aca.Insert(s + i, strlen(s + i));
	}
	aca.Link();
	//sa.Print();
	printf("total = %d, len = %d\n", sa.top - sa.t, sa.tl->l);
	char b[100];
	while (~scanf("%s", b)) {
		aca.Search(b, strlen(b));
	}
	return 0;
}
