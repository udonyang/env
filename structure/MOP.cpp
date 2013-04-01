//Matrix Operations
//usage: MOP<class value_type>
template<class T> struct MOP{
	typedef vector<T> VK;
	typedef vector<VK> MT;
	int n, m;
	MT M;
	//this[row]
	//return row-r
	VK & operator [] (int r) {
		return M[r];
	}
	//this.mul(value, row);
	//rth-row multiply k
	VK & mul(T k, int r) {
		for (int i = 0; i < m; i++) {
			M[r][i] *= k;
		}
		return M[r];
	}
	//MOP(row, column, init_value, init_array);
	//construct a Matrix with n row, m columns
	//if it has no init_array,
	//there would be a diagonal-Matrix with init_value
	MOP(int _n, int _m, T k = T(0), T **a = 0): n(_n), m(_m) {
		M.resize(n);
		for (int i = 0; i < n; i++) {
			M[i].resize(m);
		}
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				if (a) {
					M[i][j] = *((T*)a + i * m + j);
				} else {
					M[i][j] = T(i == j) * k;
				}
			}
		}
	}
	//this.rsw(ith-row, jth-row);
	//swap row i and row j
	MOP & rsw(int i, int j) {
		swap(M[i], M[j]);
		return *this;
	}
	//this.rad(pth-row, qth-row)
	//qth-row add pth-row
	MOP & rad(int p, int q) {
		for (int i = 0; i < m; i++) {
			M[p][i] += M[q][i];
		}
		return *this;
	}
	//this.oup()
	//display the Matrix
	MOP & oup() {
		for (int i = 0; i < n; i++){
			for (int j = 0; j < m; j++) {
				printf(" %lld", M[i][j]);
			}
			puts("");
		}
		puts("");
		return *this;
	}
	//this Matrix multiply k
	MOP & operator *= (T k) {
		for (int r = 0; r < n; r++) {
			mul(r, k);
		}
		return *this;
	}
	//p add q
	friend MOP operator + (MOP p, MOP q) {
		if (p.n != q.n || p.m != q.m){
			puts("Invaild Add!\n");
			return MOP(0, 0);
		}
		MOP r(p.n, q.m);
		for (int i = 0; i < p.n; i++) {
			for (int j = 0; j < q.m; j++) {
				r[i][j] = p[i][j] + q[i][j];
			}
		}
		return r;
	}
	//p multiply q
	friend MOP operator * (MOP p, MOP q) {
		if (p.m != q.n){
			puts("Invaild Mul!\n");
			return MOP(0, 0);
		}
		MOP r(p.n, q.m);
		for (int i = 0; i < p.n; i++) {
			for (int j = 0; j < q.m; j++) {
				for (int k = 0; k < p.m; k++) {
					r[i][j] = r[i][j] + p[i][k] * q[k][j];
				}
			}
		}
		return r;
	}
};
