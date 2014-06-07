main: main.hs
	ghc --make -O main.hs
	rm main.hi main.o
.PHONY: debug run
debug:
	runhaskell main.hs
run:
	cat input.in | runhaskell main.hs
