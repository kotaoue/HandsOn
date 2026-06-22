#include <stdio.h>

void sumFirstTenSquares()
{
    int sum = 0;
    int i = 1;
loop:
    if (i > 10)
    {
        return;
    }
    sum += i * i;
    printf("i: %d, sum: %d\n", i, sum);
    ++i;
    goto loop;
}

int main()
{
    sumFirstTenSquares();
}
