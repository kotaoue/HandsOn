#include <stdio.h>

int sumFirstTenSquaresHelper(int sum, int i)
{
    while (i <= 10)
    {
        printf("i: %d, sum: %d\n", i, sum);
        sum += i * i;
        i++;
    }
    return sum;
}

int sumFirstTenSquares()
{
    return sumFirstTenSquaresHelper(0, 1);
}

int main()
{
    sumFirstTenSquares();
}
