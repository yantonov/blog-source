#!/bin/sh

SCRIPT_DIR=$(cd `dirname $0` && pwd)
cd $SCRIPT_DIR

if [ -z "$1" ]; then
    echo "usage: $0 post-title"
    exit 1
fi

cd ..

hugo new post/$1.md
