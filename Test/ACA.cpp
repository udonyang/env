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
