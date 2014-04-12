main: main.o A.o B.o
	$(CC) $(CFLAGS) -o $@ $^

debug:
	gdb main

run:
	./main

.PHONY: debug clean run main
