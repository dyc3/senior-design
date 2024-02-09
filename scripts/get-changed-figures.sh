#!/bin/bash

set -euo pipefail

FIGS_PATH="./figures"

__HELP=$(cat <<EOF
Usage: $0 [options]

This script will print out a list of figures that have been added, deleted, or
updated in the current branch. This is useful for generating a changelog for our
weekly reports.

OPTIONS:
  -c --commits <commit-range>  A range of commits to compare. This can be a
                               single commit, a range of commits, or a branch
                               name. If not specified, --after must be specified.
  -a --after <date>            A date to compare against. If not specified,
                                --commits must be specified.
  -b --before <date>           A date to compare against. If not specified, the
                                current date is used. Must be used with --after.

  -f --figures-path <path>     The path to the figures directory. Default is $FIGS_PATH.

EXAMPLES:
  $0 --commits master..HEAD
  $0 --after 2021-01-01
  $0 --after 2021-01-01 --before 2021-01-15
  $0 --commits master..HEAD --figures-path ./docs/figures
  $0 --after 2021-01-01 --figures-path ./docs/figures
  $0 --after 2021-01-01 --before 2021-01-15 --figures-path ./docs/figures
  $0 --after "3 days ago"
EOF
)

cd "$(dirname "$0")/.."

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--commits)
      COMMIT_RANGE="$2"
      shift # past argument
      shift # past value
      ;;
    -a|--after)
      AFTER="$2"
      shift # past argument
      shift # past value
      ;;
    -b|--before)
      BEFORE="$2"
      shift # past argument
      shift # past value
      ;;
    -f|--figures-path)
      FIGS_PATH="$2"
      shift # past argument
      shift # past value
      ;;
    -h|--help)
      echo "$__HELP"
      exit 0
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if [[ -z "${COMMIT_RANGE+x}" ]]; then
  if [[ -z "${AFTER+x}" ]]; then
    echo "ERROR: You must specify either --commits or --after"
    echo "$__HELP"
    exit 1
  fi
  START_COMMIT=$(git log --pretty=reference --since "$AFTER" | cut -d " " -f 1 | tail -n 1)
  if [[ -z "${BEFORE+x}" ]]; then
    END_COMMIT="HEAD"
  else
    END_COMMIT=$(git log --pretty=reference --until "$BEFORE" | cut -d " " -f 1 | tail -n 1)
  fi
  COMMIT_RANGE="$START_COMMIT..$END_COMMIT"
fi

DIFF=$(git diff --name-status "$COMMIT_RANGE" -- "$FIGS_PATH" | grep -E '(mmd|puml)')

while read -r line; do
  status=$(echo "$line" | cut -d$'\t' -f 1)
  file=$(echo "$line" | cut -d$'\t' -f 2)
  file=$(basename -- "$file")
  file="${file%.*}"
  if [[ "$status" == "A" ]]; then
    status="Added"
  elif [[ "$status" == "D" ]]; then
    status="Deleted"
  else
    status="Updated"
  fi
  echo "- $status: @Figure::$file"
done <<< "$DIFF"
