#!/usr/bin/env bash

set -eu

make -s clean

source functions.sh

if [[ $# -eq 1 ]]
then
  get_answer "$1"/* "./$(cut -d/ -f 1 <<< "$1")/input.txt"
else
  echo "Usage: ./solve.sh <dd>/{a,b}/" >&2
  exit 1
fi
