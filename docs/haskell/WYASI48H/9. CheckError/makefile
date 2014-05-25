main: main.hs
	ghc --make -O main.hs
	rm main.hi main.o
.PHONY: debug run
debug:
	./main
run:
	@./main "(+ 2 \"two\")"
	@./main "(+ 2)"
