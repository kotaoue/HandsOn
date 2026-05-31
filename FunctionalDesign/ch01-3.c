#include <stdio.h>

int sumFirstTenSquaresHelper(int sum, int i)
{
loop:
    if (i > 10)
    {
        return sum;
    }
    sum += i * i;
    printf("i: %d, sum: %d\n", i, sum);
    ++i;
    goto loop;
}

int sumFirstTenSquares()
{
    return sumFirstTenSquaresHelper(0, 1);
}

int main()
{
    sumFirstTenSquares();
}
