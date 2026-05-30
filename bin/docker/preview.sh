#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR

cd ..

THEME=`./used-theme.sh | head -n 1`

cd ..

docker run --rm \
       -v "$PWD":/src \
       -p 1313:1313 \
       hugo-fixed \
       server \
       --bind 0.0.0.0 --port 1313 \
       --theme=$THEME \
       --buildDrafts
