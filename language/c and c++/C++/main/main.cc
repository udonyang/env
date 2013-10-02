#include <bitset>
#include <iostream>
#include <map>
using namespace std;

int main()
{
  bitset<8> b=0777;
  cout << (b&b) << " hello world" << endl;
	return 0;
}
