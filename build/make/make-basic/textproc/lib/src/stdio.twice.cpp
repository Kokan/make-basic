#include "stdio.twice.hpp"

twice::twice()
{
}

void twice::write(const unsigned int byte)
{
	console::write(byte);
	console::write(byte);
}

unsigned int twice::read()
{
	return (unsigned int)(console::read()*2);
}
