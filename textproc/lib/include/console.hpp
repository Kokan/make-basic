#ifndef _CONSOLE_
#define _CONSOLE_

#include "stdio.interface.hpp"

#include <ostream>

class Console
{
public:
	typedef std::basic_ostream<char, std::char_traits<char> > CoutType;
	typedef CoutType& (*StandardEndLine)(CoutType&);

	Console(stdio *interface);

	Console& operator<<(const char*);
	Console& operator<<(StandardEndLine manip);
private:
	stdio *lib;
};


#endif // _CONSOLE_
