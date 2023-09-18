#!/bin/bash

git log --reverse --pretty=format:'%ad,%an,"%s"' --date=short #| sed 's/\#/\\\#/g'
