main.pdf : main.tex
	gawk -f main.awk ../main.cc > body.tex
	pdflatex main.tex

.PHONY: run debug clean

debug:
	gawk -f main.awk ../main.cc

run:
	gnome-open main.pdf
clean:
	rm $(filter-out main.tex makefile, $(wildcard *)) -rf
