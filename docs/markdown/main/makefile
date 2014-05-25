IFILE = $(wildcard *.markdown)
BASE = $(basename $(IFILE))
OFILE = $(BASE).html

main: $(IFILE)
	markdown $(IFILE) > $(OFILE)
.PHONY: run
run:
	chromium-browser -open $(OFILE)
