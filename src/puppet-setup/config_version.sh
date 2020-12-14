#!/bin/sh

# Usage
if [ $# -ne 2 -o ! -d "$1" -o ! -d "$1/$2" ]; then
  echo "usage: $0 <environmentpath> <environment>" >&2
  exit 1
fi

cat "$1/$2/release"
