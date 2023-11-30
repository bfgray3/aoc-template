#!/usr/bin/env bash

set -eu

make -s clean

source functions.sh

function test_part {
  local day part input_file correct_answer f ans

  day=$1
  part=$2

  input_file="./$day/input.txt"

  if [[ ! -d "$day/$part" ]]
  then
    return
  fi

  correct_answer=$(jq -r ".ans$day.$part" answers.json)

  for f in "$day/$part"/*
  do
    ans=$(get_answer "$f" "$input_file")

    if [[ "$ans" = "$correct_answer" ]]
    then
      echo "$f correct"
    else
      echo "$f incorrect; got $ans and expected $correct_answer" >&2
      exit 1
    fi
  done
}

if [[ $# -eq 1 ]]
then
  test_part "$(cut -d/ -f 1 <<< "$1")" "$(cut -d/ -f 2 <<< "$1")"
elif [[ $# -eq 0 ]]
then
  for d in [0-9]*
  do
    for p in a b
    do
      test_part "$d" "$p"
    done
  done
else
  echo "Usage: ./test.sh [<dd>/{a,b}/]" >&2
  exit 1
fi
