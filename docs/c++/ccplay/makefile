main: main.cc
	g++ main.cc -o main -g -std=c++11 \
		-ldlex -ldac \
		-I$(HOME)/.local/include/dac/v2

.PHONY: debug clean run

debug:
	gdb main

run:
	./main

clean:
	rm -f main *.o
