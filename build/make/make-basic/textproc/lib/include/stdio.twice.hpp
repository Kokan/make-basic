#ifndef _STDIO_TWICE_
#define _STDIO_TWICE_

#include "stdio.console.hpp"

class twice : public console
{
public:
	twice();
	virtual void write(const unsigned int);
	virtual unsigned int read();
};

#endif // _STDIO_TWICE_
