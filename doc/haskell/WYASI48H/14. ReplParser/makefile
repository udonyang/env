main: main.hs
	ghc --make -O main.hs
	rm main.hi main.o
.PHONY: debug run
debug:
	./main
run:
	./main "(< 2 3)"
	./main "(> 2 3)"
	./main "(>= 3 3)"
	./main "(string=? \"test\" \"test\")"
	./main "(string<? \"abc\" \"bba\")"
	./main "(if (> 2 3) \"no\" \"yes\")"
	./main "(if (= 3 3) (+ 2 3 (- 5 1)) \"unequal\")"
	./main "(car '(2 3 4))"
	./main "(cdr '(2 3 4))"
	./main "(car (cdr (cons 2 '(3 4))))"
	./main "(cdr '(a simple test))"
	./main "(car (cdr '(a simple test)))"
	./main "(car '((this is) a test))"
	./main "(cons '(this is)  'test)"
	./main "(cons '(this is)  '())"
	./main "(eqv? 1 3)"
	./main "(eqv? 3 3)"
	./main "(eqv? 'atom 'atom)"
	./main "(equal? '(1 "2") '(1 2))"
	./main "(equal? 1 "1")"
	./main "(equal? 1 1)"
