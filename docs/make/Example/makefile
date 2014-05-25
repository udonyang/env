VPATH=src include
CC=gcc
CPPFLAGS=-I include

SOURCES=count_words.c\
				lexer.c\
				counter.c

count_words: libcounter.a -lfl
libcounter.a: libcounter.a(lexer.o) libcounter.a(counter.o)
count_words.o: counter.h
counter.o: counter.h lexer.h
lexer.o: lexer.h

.PHONY: run
run:
	echo 'fee foe fom fee' | ./count_words

include $(subst .c,.d,$(SOURCES))

%.d: %.c
	$(CC) -M $(CPPFLAGS) $< > $@.$$$$;\
		sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@;\
		rm -f $@.$$$$
