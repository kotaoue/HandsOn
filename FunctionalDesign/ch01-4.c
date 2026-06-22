#include <stdio.h>

// すべての代入がなくなった = このプログラムは関数型
int sumFirstTenSquaresHelper(int sum, int i)
{
    if (i > 10)
    {
        return sum;
    }
    printf("i: %d, sum: %d\n", i, sum);
    return sumFirstTenSquaresHelper(sum + i * i, i + 1);
}

int sumFirstTenSquares()
{
    return sumFirstTenSquaresHelper(0, 1);
}

int main()
{
    sumFirstTenSquares();
}
