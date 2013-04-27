//Module_Group
//usage: MG<long long prim_>
template<long long m> struct MG {
	typedef long long LL;
	LL x;
	//constructor
	//usage: MG(long long vaule)
	MG(LL _x = 0): x(_x % m) {
	}
	friend MG operator + (MG p, MG q) {
		return (p.x + q.x) % m;
	}
	friend MG operator - (MG p, MG q) {
		return MG((p.x + q.x + m) % m);
	}
	friend MG operator * (MG p, MG q) {
		return MG((p.x * q.x) % m);
	}
	friend MG operator / (MG p, MG q) {
		MG a(1);
		LL b = m - 2;
		for (; b; b >>= 1) {
			if (b & 1) {
				a = a * q;
			}
			q = q * q;
		}
		return p * a;
	}
};
