#include <stdio.h>

int sumFirstTenSquaresHelper(void)
{
    return (1 > 10)    ? 0
           : (2 > 10)  ? 1 * 1
           : (3 > 10)  ? 1 * 1 + 2 * 2
           : (4 > 10)  ? 1 * 1 + 2 * 2 + 3 * 3
           : (5 > 10)  ? 1 * 1 + 2 * 2 + 3 * 3 + 4 * 4
           : (6 > 10)  ? 1 * 1 + 2 * 2 + 3 * 3 + 4 * 4 + 5 * 5
           : (7 > 10)  ? 1 * 1 + 2 * 2 + 3 * 3 + 4 * 4 + 5 * 5 + 6 * 6
           : (8 > 10)  ? 1 * 1 + 2 * 2 + 3 * 3 + 4 * 4 + 5 * 5 + 6 * 6 + 7 * 7
           : (9 > 10)  ? 1 * 1 + 2 * 2 + 3 * 3 + 4 * 4 + 5 * 5 + 6 * 6 + 7 * 7 + 8 * 8
           : (10 > 10) ? 1 * 1 + 2 * 2 + 3 * 3 + 4 * 4 + 5 * 5 + 6 * 6 + 7 * 7 + 8 * 8 + 9 * 9
                       : 1 * 1 + 2 * 2 + 3 * 3 + 4 * 4 + 5 * 5 + 6 * 6 + 7 * 7 + 8 * 8 + 9 * 9 + 10 * 10;
}

int sumFirstTenSquares()
{
    return sumFirstTenSquaresHelper();
}

int main()
{
    int result = sumFirstTenSquares();
    printf("result: %d\n", result);
    return 0;
}
