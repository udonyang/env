main: *.cc
.PHONY: run clean
run:
	./main
clean:
	rm -f $(filter-out $(wildcard *.cc *.h) makefile, $(wildcard *))
