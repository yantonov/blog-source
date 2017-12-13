#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR

THEME=$(./used-theme.sh | head -n 1 || echo "")

cd ..

hugo --theme=$THEME
