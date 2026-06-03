#include <stdio.h>

int sumFirstTenSquaresHelper(int sum, int i)
{
    while (i <= 10)
    {
        sum += i * i;
        i++;
        printf("i: %d, sum: %d\n", i, sum);
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
