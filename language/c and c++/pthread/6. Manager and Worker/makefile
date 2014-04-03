CFLAGS += -g -pthread -std=c99 -Wall
main: main.o Thread.o

.PHONY: debug clean run

debug:
	gdb main

run:
	./main

%.o: %.c %.h
	$(CC) $(CFLAGS) -c $< -o $@
