#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR

cd ../content/post

LAST_POST=$(ls -1 | sort -r | head -n 1 || echo "")

emacs $LAST_POST
