#!/bin/bash

# This script helps update file references in the project. It is useful when
# moving a bunch of files around or renaming them.

# Usage:
# 1. Move or rename files (probably figures)
# 2. Stage the changes. Do not commit them yet.
# 3. Run this script.
# 4. Inspect the changes and run make to make sure they are correct.

set -euxo pipefail

git status -s | grep -e 'R' | cut -d " " -f 3,5 | while read -r old_text new_text; do
	sed -i "s|$old_text|$new_text|g" ./*.typ;
done