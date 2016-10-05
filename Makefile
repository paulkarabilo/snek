EMAKE=elm-make
HTML=snek.html
MAIN=Main.elm

all:
	$(EMAKE) $(MAIN) --output $(HTML)

.PHONY: clean

clean:
	rm -f snek.html
