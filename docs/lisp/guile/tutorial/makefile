CFLAGS = `guile-config compile`
LIBS = `guile-config link`

all: backend.c
	gcc $(CFLAGS) $(LIBS) -std=c99 -lm -o backend backend.c

run:
	./backend

clean:
	rm -f backend.o backend

.PHONY: all clean run
