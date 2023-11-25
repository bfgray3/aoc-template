#!/usr/bin/env bash

set -eu

make -s clean

function test_part {
  local day part input_file correct_answer f

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
    test_one "$f" "$correct_answer" "$input_file"
  done
}

function test_one {
  local f correct_answer input_file extension ans

  f=$1
  correct_answer=$2
  input_file=$3

  extension="${f##*.}"

  case $extension in
    cpp)
      make -s path="$f"
      ans=$("./$(dirname "$f")/aocmain" "$input_file")
      ;;
    py)
      ans=$(python3 "$f" "$input_file")
      ;;
    go)
      ans=$(go run "$f" "$input_file")
      ;;
    sh)
      ans=$(bash "$f" "$input_file")
      ;;
    R)
      ans=$(Rscript "$f" "$input_file")
      ;;
    *)
      echo "UNKNOWN FILE: $f" >&2
      return
      ;;
  esac

  if [[ "$ans" = "$correct_answer" ]]
  then
    echo "$f correct"
  else
    echo "$f incorrect; got $ans and expected $correct_answer" >&2
    exit 1
  fi
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
