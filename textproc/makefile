# Macros

# Configuration
TWICE=0

# Runtime binaries
MK=mkdir

# Directories
DIR=build
LDIR=$(DIR)/lib
DIRS=$(DIR) $(LDIR)

# Loglib Shared Object
LIB=$(DIR)/loglib.so
SOBJ=$(LDIR)/loglib.o $(LDIR)/console.o $(LDIR)/stdio.console.o $(LDIR)/stdio.twice.o

# Binary
OBJ=$(DIR)/main.o 
BIN=$(DIR)/textproc

# Helper targets
all: $(DIRS) $(BIN)

clean:
	$(RM) $(BIN) $(OBJ)
	$(RM) -r $(DIRS)

help:
	@cat README.md

.PHONY: all clean help

$(DIRS):
	$(MK) $@

# loglib.so shared object
$(DIR)/loglib.so: $(SOBJ)
	$(CXX) -shared -o $@ $(LDFLAGS) $^

$(LDIR)/loglib.o: lib/src/loglib.cpp lib/include/loglib.hpp lib/include/stdio.interface.hpp
	$(CXX) -c -fPIC -DTWICE=$(TWICE) -Ilib/include -o $@ $(CFLAGS) lib/src/loglib.cpp

$(LDIR)/console.o: lib/src/console.cpp lib/include/console.hpp lib/include/stdio.interface.hpp
	$(CXX) -c -fPIC -Ilib/include -o $@ $(CFLAGS) lib/src/console.cpp

$(LDIR)/stdio.console.o: lib/src/stdio.console.cpp lib/include/stdio.console.hpp
	$(CXX) -c -fPIC -Ilib/include -o $@ $(CFLAGS) lib/src/stdio.console.cpp

$(LDIR)/stdio.twice.o: lib/src/stdio.twice.cpp lib/include/stdio.twice.hpp lib/include/stdio.console.hpp lib/include/stdio.interface.hpp
	$(CXX) -c -fPIC -Ilib/include -o $@ $(CFLAGS) lib/src/stdio.twice.cpp

# Binary
$(DIR)/main.o: include/main.hpp lib/include/loglib.hpp lib/include/stdio.interface.hpp lib/include/console.hpp src/main.cpp
	$(CXX) -c -Ilib/include -Iinclude -o $@ $(CFLAGS) src/main.cpp

$(BIN): $(OBJ) $(LIB)
	$(CXX) $(LDFLAGS) -o $(BIN) $^

