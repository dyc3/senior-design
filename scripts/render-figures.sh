#!/bin/bash

cd "$(dirname "$0")/.." || exit 1

# check for mermaid cli
if ! command -v mmdc &> /dev/null; then
	echo "mermaid cli could not be found"
	exit 1
fi

# find ./figures -type f -name "*.mmd" | while read -r file; do
# 	mmdc -i "$file" -c ./figures/mermaid.json -o "${file%.*}.svg"
# done

find ./figures -type f -name "*.mmd" | parallel mmdc -i "{}" -c ./figures/mermaid.json -o "{.}.svg"

if [[ ! -f plantuml.jar ]]; then
	echo "plantuml.jar could not be found, downloading..."
	curl -L -o plantuml.jar https://github.com/plantuml/plantuml/releases/download/v1.2023.6/plantuml.jar
fi

java -jar plantuml.jar -tsvg "figures/*.puml"
