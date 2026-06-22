#include <stdio.h>

int n = 1;
int sum = 0;

int done()
{
    return n > 10;
}

void doSomething()
{
    sum += n * n;
    ++n;
    printf("n: %d, sum: %d\n", n, sum);
}

// void sumFirstTenSquares()
int main()
{
    while (!done())
    {
        doSomething();
    }
}
