main: main.cc
	g++ -g -std=c++11 main.cc -o main
.PHONY: run clean
run:
	./main
clean:
	rm -f $(filter-out $(wildcard *.cc *.h) makefile, $(wildcard *))
