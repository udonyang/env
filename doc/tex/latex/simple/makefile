main.pdf : main.tex
	pdflatex main.tex

.PHONY: run clean

run:
	gnome-open main.pdf
clean:
	rm $(filter-out main.tex makefile, $(wildcard *)) -rf
