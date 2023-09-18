#!/bin/bash

cd "$(dirname "$0")/.." || exit 1

git log --reverse --pretty=format:'%ad,%an,"%s"' --date=short #| sed 's/\#/\\\#/g'
