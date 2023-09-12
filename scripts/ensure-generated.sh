#!/bin/bash

# A small script to use in CI to ensure that all generated files are up to date.

set -e -x -o pipefail

cd "$(dirname "$0")"

./render-figures.sh

if [[ "$(git ls-files -o --directory --exclude-standard)" != "" ]]; then
  echo "Generated files are out of date. Please run './render-figures.sh' and commit the changes."
  git ls-files -o --directory --exclude-standard
  exit 1
fi

# mermaid cli is buggy and doesn't render the same thing every time
# if ! git diff --quiet; then
#   echo "Generated files are out of date. Please run './render-figures.sh' and commit the changes."
#   git diff
#   exit 1
# fi