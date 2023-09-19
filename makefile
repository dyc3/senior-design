all:
	./scripts/generate-changelog.sh > changelog.csv
	typst compile main.typ main.pdf

clean:
	rm *.pdf
