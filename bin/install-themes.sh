#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR

cd ..
cd themes

THEME="hugo-theme-pure"
if [ -d "${THEME}" ]; then
    echo "theme '${THEME}' is already exists"
    exit 1;
fi

git clone "https://github.com/xiaoheiAh/hugo-theme-pure.git"
