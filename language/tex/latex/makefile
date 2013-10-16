paper.pdf : paper.tex
	xelatex paper.tex

.PHONY: run clean

run:
	gnome-open paper.pdf
clean:
	rm $(filter-out paper.tex makefile, $(wildcard *)) -rf
