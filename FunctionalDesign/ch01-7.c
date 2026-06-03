#include <stdio.h>

int sumFirstTenSquaresHelper()
{
    printf("i: %d, sum: %d\n", 1, 0);
    return (1 > 10) ? 0 : sumFirstTenSquaresHelper(0 + 1 * 1, 1 + 1);
}

int sumFirstTenSquares()
{
    return (1 > 10) ? 0 : (2 > 10) ? 0 + 1 * 1
                                   : sumFirstTenSquaresHelper((0 + 1 * 1) + 2 * 2, (1 + 1) + 1);
}

int main()
{
    sumFirstTenSquares();
}
