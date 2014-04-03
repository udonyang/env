main: main.c main.h
	gcc main.c -o main -g -pthread -std=c99 -Wall
.PHONY: debug clean run
debug:
	gdb main
run:
	./main
