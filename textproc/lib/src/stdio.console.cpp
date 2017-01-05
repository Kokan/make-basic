#include "stdio.console.hpp"

#include <cstdio>

console::console()
{
}

void console::write(const unsigned int byte)
{
	putchar((char)byte);
}

unsigned int console::read()
{
	return (unsigned int)getchar();
}
