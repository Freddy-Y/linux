#include<iostream>
using namespace std;
//穷举法求最大公约数 由此 求最小公倍数
void F2()
{
	int m, n;
	cin >> m >> n;
	int temp;  //最大公约数
	for (int i = 1;;i++)
	{
		if (i <= m&&i <= n)
			if (m%i == 0 && n%i == 0)
				temp = i;
			else
				break;
			
		}
		int result = 0;
		result = m*n / tem;//temp打错
		cout<< result << endl;

	}
	int main()
	{
	F2();//穷举法直接求最大公约数
	return 0;
}