#ifndef _STDIO_CONSOLE_
#define _STDIO_CONSOLE_

#include "stdio.interface.hpp"

class console : public stdio
{
public:
	console();
	virtual void write(const unsigned int);
	virtual unsigned int read();
};

#endif // _STDIO_CONSOLE_
