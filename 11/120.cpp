#include<iostream>
using namespace std;
//辗转相除法求最大公约数  由此  求最小公倍数
void T2()
{
	int m, n;
	cin >> m >> n;
	int a = m;
	int b = n;
	int temp;  //最大公约数
	int q;
	do
	{
		q = m%n;
		if (q ==0)
		{
			temp = n;
			break;
		}
		m = n;
		n = q;
	} while (q!=0);

	int result = 0;
	result = a*b / temp;
	cout<< result << endl;
}
int main()
{
	//one();//穷举法直接求最小公倍数
	T2();//辗转相除法求最大公约数
	//fourth();//相减法法求最大公约数
	//fifth();//短除法求最小公约数
        return 0;
}