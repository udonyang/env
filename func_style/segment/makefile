main: main.cc
	gcc main.cc -o main -g -lstdc++
.PHONY: clean debug run
debug:
	gdb main
run:
	./$(basename $(wildcard *.cc))
