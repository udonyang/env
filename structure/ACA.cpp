//structure
//AC Automaton
//include: queue, cstring
//usage: obj.Init->obj.Link->(obj.$(others))*->obj.Free
struct ACA {
	enum {n = 11, m = 55, shift = 0};
	struct Node {
		//Extern
		//Basic
		Node *s[m],             //Adjust node
			 *p;                //Failure link
		int  a;                 //Accpet Tag
	};
	typedef Node *PNode;
	//Extern
	//Basic
	int sz;
	Node t[110];
	PNode   rt;                   //Initial State
	//Init a node
	//usage: obj.New([length], [Failure Link])
	PNode New() {
		memset(t + sz, 0, sizeof(Node));
		return t + sz++;
	}
	//Init
	//usage: obj.Init()
	void Init() {
		//Extern
		//Basic
		sz = 0;
		rt = New();
	}
	//Append a string
	//usage: obj.Insert(charactor)
	void Insert(int a, int *s, int sl) {
		PNode x = rt;
		for (int i = 0; i < sl; i++) {
			int k = s[i] - shift;
			if (!x->s[k]) {
				x->s[k] = New();
			}
			x = x->s[k];
		}
		x->a = a;
	}
	//Failure Linking
	//usage: obj.Link()
	void Link() {
		queue<PNode> Q;
		rt->p = rt;
		for (int i = 0; i < m; i++) {
			if (rt->s[i]) {
				rt->s[i]->p = rt;
				Q.push(rt->s[i]);
			} else {
				rt->s[i] = rt;
			}
		}
		while (!Q.empty()) {
			PNode x = Q.front();
			Q.pop();
			for (int i = 0; i < m; i++) {
				if (x->s[i]) {
					x->s[i]->p = x->p->s[i];
					if (x->p->s[i]->a) {
						x->s[i]->a = x->p->s[i]->a;
					}
					Q.push(x->s[i]);
				} else {
					x->s[i] = x->p->s[i];
				}
			}
		}
	}
};
