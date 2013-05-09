main: *.cpp
.PHONY: clean run
run:
	./$(basename $(wildcard *.cpp))
