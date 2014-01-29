PNGS=$(sort $(wildcard *.png))
BASE=$(basename $(NAME))

main:
	sgf2misc -max 1 -to img -imgtype png $(NAME) 2> /dev/null
	rm -f $(BASE).gif
	convert -delay 100 $(PNGS) -loop 0 $(BASE).gif
	rm -f $(PNGS)
