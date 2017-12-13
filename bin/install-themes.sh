#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR

cd ..
cd themes
git clone "https://github.com/masa0221/hugo-theme-geppaku"
