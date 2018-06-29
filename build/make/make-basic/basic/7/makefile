CC=touch
TARGET=10 11 12 20 00
#protect agains tempering
ifneq ($(CC), touch)
nothing-to-do:
	echo $(CC) is not valid
	exit 0
endif
all: ${TARGET}


20: 00
12: 10
11: 10
10: 00

${TARGET}: makefile
	$(CC) $@
clean:
	$(RM) ${TARGET}
