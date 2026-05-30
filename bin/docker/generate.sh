#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR

cd ..

THEME=$(./used-theme.sh | head -n 1 || echo "")

cd ..

docker run --rm \
       -v "$PWD":/src \
       hugo-fixed \
       --theme=$THEME
