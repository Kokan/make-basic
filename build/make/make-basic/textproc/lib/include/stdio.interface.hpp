#ifndef _STDIO_INTERFACE_
#define _STDIO_INTERFACE_

class stdio
{
public:
	virtual void write(const unsigned int) = 0;
	virtual unsigned int read() = 0;
};

#endif // _STDIO_INTERFACE_
