CFLAG = -fPIC -g -c -Wall
source = $(wildcard *.c)
object = $(wildcard *.o)

main: main.c
	gcc -o main main.c -ldac -ldlex2
	
.PHONY: run clean lib

lib: $(source)
	gcc $(CFLAG) $(filter-out main.c, $(source))
	gcc -shared -Wl,-soname,libdac.so.1 \
		-o lib/libdac.so.1.0.0 $(object)

run:
	./main
clean:
	rm -f $(filter-out $(wildcard *.[ch]) makefile lib temp, $(wildcard *))
