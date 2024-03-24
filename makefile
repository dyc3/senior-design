all:
	./scripts/generate-changelog.sh > changelog.csv
	typst compile main.typ main.pdf

clean:
	rm *.pdf

figures:
	./scripts/render-figures.sh

lint:
	which python3
	python3 -c "print('Python 3 is available')"
	python3 ./scripts/lints/figure-labels-match-files.py main.typ poster.typ
	python3 ./scripts/lints/figure-labels-prefixes-match-content.py main.typ poster.typ

full: figures all

.PHONY: all clean figures lint full
