#include "console.hpp"

#include <cstring>

Console::Console(stdio* interface)
: lib(interface)
{
}

Console& Console::operator<<(const char* text)
{
	int len=strlen(text);
	for (int i=0;i<len;++i)
		this->lib->write((unsigned int)text[i]);
	return *this;
}

Console& Console::operator<<(StandardEndLine manip)
{
	this->lib->write((unsigned int)'\n');
	return *this;
}
