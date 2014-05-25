main: main.hs
	ghc --make -O main.hs
	rm main.hi main.o
.PHONY: debug run
debug:
	./main
run:
	@./main "(< 2 3)"
	@./main "(> 2 3)"
	@./main "(>= 3 3)"
	@./main "(string=? \"test\" \"test\")"
	@./main "(string<? \"abc\" \"bba\")"
