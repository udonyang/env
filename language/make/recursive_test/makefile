export PROJECT := dpa
export ROOT := $(PWD)
export DIST := $(ROOT)/dist
export BIN := $(DIST)/bin
export LIB := $(DIST)/lib
export INC := $(DIST)/include

export MAKE := make
export CXX := g++
export CXXFLAGS += -Wall -std=c++11

RM = rm -f
MKDIR = mkdir -p
PREFIX := /usr/local

all:
	$(MAKE) --directory=src all

clean:

distclean:

.PHONY: all clean distclean
