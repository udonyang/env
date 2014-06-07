main: *.c
.PHONY: run clean
run:
	./main
clean:
	rm -f $(filter-out $(wildcard *.[ch]) makefile, $(wildcard *))
