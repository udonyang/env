CC = gcc -ldac
CFLAGS = -std=gnu99 \
				 -I$(HOME)/.local/include/dac/v2


main: main.o Atype.o Btype.o

run:
	./main

debug:
	valgrind ./main

clean:
	rm *.o main

.PHONY: run clean debug
