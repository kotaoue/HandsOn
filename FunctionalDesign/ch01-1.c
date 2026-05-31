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
}

// void sumFirstTenSquares()
void main()
{
    while (!done())
    {
        doSomething();
    }
}
