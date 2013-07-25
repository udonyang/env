//structures
//Linking list Graph
//include: vector
struct LLG {
    struct Edge {
        //Externs should be defined here
        int w;
        //Basic
        int v,       //Adjust node v
            next;    //Index of the next node v
    };
	const static int n = maxn;
	const static int m = maxn;
	Edge E[m];    //Aarry in which Edges store
	int  L[n],    //Head of linking list of nodes
		 El,         //Total of Edges
		 V;          //Total of nodes
    //Init
    //usage: obj.Init(int TotalOfNode)
    void Init(int _V = 0) {
        V = _V;
		El = 0;
		memset(L, -1, sizeof(L));
    }
    //AddEdge 
    //usage: obj.AddEdge(From, To, Extern)
    void AddEdge(int u, int v, int w) {
        Edge t =  {w, v, L[u]}; //rule: Node t = {Extern, Basic}
        L[u] = El;
        E[El++] = t;
    }
    //FlowAddEdge 
    //usage: obj.FlowAddEdge(From, To, Extern)
    void FlowAddEdge(int u, int v, int w) {
        AddEdge(u, v, w);
        AddEdge(v, u, 0);
    }
};
