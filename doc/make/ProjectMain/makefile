# all				Perform all tasks to build the application
# install		Create an installation of the application from the compilied binaries
# clean			Delete the binary files from sources
# distclean Delete all the generated files that were not in the original source distribution
# info			Create GNU info files from their Texinfo sources
# check			Run any tests associated with this application

VPATH=src include

CC=gcc
CFLAGS=--std=c99 -g
LDFLAGS=

AWK=gawk
SORT=sort
PR=pr

all: main

main: main.o

main.o: main.c

.PHONY: all install clean distclean info check help

help:
	$(MAKE) --print-data-base --question |\
		$(AWK) '/^[^.%][-A-Za-z0-9_]*:/\
			{print substr($$1, 1, length($$1)-1)}'|\
		$(SORT) |\
		$(PR) --omit-pagination --width=80 --columns=4
