#!/usr/bin/env bash

function get_answer {
  local f input_file extension

  f=$1
  input_file=$2

  extension="${f##*.}"

  case $extension in
    cpp)
      make -s path="$f"
      "./$(dirname "$f")/aocmain" "$input_file"
      ;;
    py)
      python3 "$f" "$input_file"
      ;;
    go)
      go run "$f" "$input_file"
      ;;
    sh)
      bash "$f" "$input_file"
      ;;
    R)
      Rscript "$f" "$input_file"
      ;;
    *)
      echo "unknown file: $f" >&2
      return 1
      ;;
  esac
}
