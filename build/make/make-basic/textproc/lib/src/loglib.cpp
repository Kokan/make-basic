#include "loglib.hpp"

#if (TWICE)
#include "stdio.twice.hpp"
#else
#include "stdio.console.hpp"
#endif

stdio* loglib::get()
{
#if (TWICE)
	return new twice();
#else
	return new console();
#endif
}
