all:
	typst compile main.typ main.pdf

clean:
	rm *.pdf
