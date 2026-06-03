#include <stdio.h>

int sumFirstTenSquaresHelper(int sum, int i)
{
    printf("i: %d, sum: %d\n", i, sum);
    return (i > 10) ? sum : sumFirstTenSquaresHelper(sum + i * i, i + 1);
}

int sumFirstTenSquares()
{
    return sumFirstTenSquaresHelper(0, 1);
}

int main()
{
    sumFirstTenSquares();
}
