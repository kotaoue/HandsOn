#include <stdio.h>

int main(int as, char **av)
{
    while (!done())
    {
        doSomething();
    }
}

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

void sumFirstTenSquares()
{
    while (!done())
    {
        doSomething();
    }
}
