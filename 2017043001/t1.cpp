#include<iostream>
using namespace std;
//穷举法直接求最小公倍数
void T1() {
	int m, n;
	cin >> m >> n;
	for (int i = n;; i++) {
		if (i%m == 0 && i%n == 0) {
			cout<<i << endl;
			break;
		}
	}
}
int main()
{
	T1();//穷举法直接求最小公倍数
	return 0;
}